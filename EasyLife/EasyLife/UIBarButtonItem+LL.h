//
//  UIBarButtonItem+LL.h
//  EasyLife
//
//  Created by qingyun on 16/1/9.
//  Copyright © 2016年 lily. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LL)

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highlightIcon:(NSString *)highlightIcon target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highlightIcon:(NSString *)highlightIcon imageScale:(CGFloat)imageScale target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)itemWithTitle:(NSString *)tilte;

@end
