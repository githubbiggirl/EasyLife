//
//  UrlSource.m
//  EasyLife
//
//  Created by qingyun on 16/1/8.
//  Copyright © 2016年 lily. All rights reserved.
//

#import "UrlSource.h"
#import "HttpTool.h"
#define baidukey @"Q0qFFiynCewS75iBPQ9TkChH"

@implementation UrlSource
+ (void)getWeatherDataWithCity:(NSString *)city success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"location"] = city;
    params[@"ak"] = baidukey;
    params[@"output"] = @"json";
    
    //发送请求
    [HttpTool getWithURL:@"http://api.map.baidu.com/telematics/v3/weather?" params:params success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            NSLog(@"<<<<%@>>>>>",error);
        }
    }];
}



@end
