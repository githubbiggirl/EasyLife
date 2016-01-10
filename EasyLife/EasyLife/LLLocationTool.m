//
//  LLLocationTool.m
//  EasyLife
//
//  Created by qingyun on 16/1/9.
//  Copyright © 2016年 lily. All rights reserved.
//

#import "LLLocationTool.h"
#import <CoreLocation/CoreLocation.h>

@implementation LLLocationCity
@end
@interface LLLocationTool ()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, strong) CLGeocoder *geo;
@end

@implementation LLLocationTool
singleton_implementation(LLLocationTool)

- (id)init
{
    if (self = [super init]) {
        _geo = [[CLGeocoder alloc]init];
        
        _manager = [[CLLocationManager alloc]init];
        _manager.delegate = self;
        [_manager startUpdatingLocation];
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    //1.停止定位
    [_manager stopUpdatingLocation];
    
    //2.根据经纬度反响得到城市名称
    CLLocation *loca = locations[0];
    [_geo reverseGeocodeLocation:loca completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        //取出位置
        CLPlacemark *place = placemarks[0];
        NSLog(@"%@",place.locality);
        
        NSString *cityName = place.locality;
        
        cityName = [cityName substringFromIndex:cityName.length - 1];
        
        //设置定位城市
        _locationCity = [[LLLocationCity alloc]init];
        _locationCity.city = cityName;
        _locationCity.coordinate = loca.coordinate;//坐标
        
        //发出通知
        [[NSNotificationCenter defaultCenter] postNotificationName:LocationCityNote object:nil];
    }];
}
@end
