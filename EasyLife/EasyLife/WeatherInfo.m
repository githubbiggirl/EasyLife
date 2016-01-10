//
//  WeatherInfo.m
//  EasyLife
//
//  Created by qingyun on 16/1/9.
//  Copyright © 2016年 lily. All rights reserved.
//

#import "WeatherInfo.h"

@implementation WeatherInfo


- (NSDictionary *)objectClassInArray
{
    return @{@"index": [LLIndexDetail class], @"weather_data": [LLWeatherData class]};
}
@end



@implementation LLIndexDetail

@end


@implementation LLWeatherData

@end

