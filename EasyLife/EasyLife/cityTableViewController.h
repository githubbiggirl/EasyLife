//
//  cityTableViewController.h
//  EasyLife
//
//  Created by qingyun on 16/1/9.
//  Copyright © 2016年 lily. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CitysViewdelegate <NSObject>

- (void)citysViewDidSelectedCity:(NSString *)city;

@end
@interface cityTableViewController : UITableViewController

@property (nonatomic, weak) id<CitysViewdelegate> citysDelegate;

@property (nonatomic, strong) NSArray *provincesAndCities;
@property (nonatomic, strong) NSArray *Cities;


@end
