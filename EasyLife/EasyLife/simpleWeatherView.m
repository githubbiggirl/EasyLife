//
//  simpleWeatherView.m
//  EasyLife
//
//  Created by qingyun on 16/1/9.
//  Copyright © 2016年 lily. All rights reserved.
//

#import "simpleWeatherView.h"

@implementation simpleWeatherView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)createView
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"simpleWeatherView" owner:self options:nil];
    simpleWeatherView *weatherView = [nib objectAtIndex:0];
    return weatherView;
}

@end
