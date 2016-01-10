//
//  UrlSource.h
//  EasyLife
//
//  Created by qingyun on 16/1/8.
//  Copyright © 2016年 lily. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UrlSource : NSObject
// 获得天气数据
+ (void)getWeatherDataWithCity:(NSString *)city success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

@end
