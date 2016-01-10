//
//  LLLocationTool.h
//  EasyLife
//
//  Created by qingyun on 16/1/9.
//  Copyright © 2016年 lily. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import <CoreLocation/CoreLocation.h>

@interface LLLocationCity : NSObject
@property (nonatomic, copy) NSString *city;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end

/**
 * 这一点不明白
 */
//通知名
#define LocationCityNote @"location_City_Note"
@interface LLLocationTool : NSObject
singleton_interface(LLLocationTool)

//定位城市
@property (nonatomic, strong) LLLocationCity *locationCity;
@end