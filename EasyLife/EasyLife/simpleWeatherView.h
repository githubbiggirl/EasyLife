//
//  simpleWeatherView.h
//  EasyLife
//
//  Created by qingyun on 16/1/9.
//  Copyright © 2016年 lily. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface simpleWeatherView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet UILabel *weekLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperature;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *windLabel;

+ (instancetype)createView;

@end
