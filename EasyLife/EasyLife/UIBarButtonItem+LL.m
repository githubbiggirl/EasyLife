//
//  UIBarButtonItem+LL.m
//  EasyLife
//
//  Created by qingyun on 16/1/9.
//  Copyright © 2016年 lily. All rights reserved.
//

#import "UIBarButtonItem+LL.h"

@implementation UIBarButtonItem (LL)

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highlightIcon:(NSString *)highlightIcon target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    button.frame = (CGRect){CGPointZero,button.currentBackgroundImage.size};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highlightIcon:(NSString *)highlightIcon imageScale:(CGFloat)imageScale target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    CGSize btnSize = CGSizeMake(button.currentBackgroundImage.size.width * imageScale, button.currentBackgroundImage.size.height * imageScale);
    button.frame = (CGRect){CGPointZero,btnSize};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    button.frame = (CGRect){CGPointZero,button.currentBackgroundImage.size};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)tilte
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = (CGRect){CGPointZero,CGSizeMake(50, 36)};
    [button setTitle:tilte forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    button.userInteractionEnabled = NO;
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}


@end
