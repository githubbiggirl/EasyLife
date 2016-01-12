//
//  CityResultTableViewController.h
//  EasyLife
//
//  Created by qingyun on 16/1/10.
//  Copyright © 2016年 lily. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityResultTableViewController : UITableViewController<UISearchResultsUpdating>

@property (nonatomic, strong) NSArray *cities;

@property (nonatomic, strong) NSMutableArray *selectedCities;
@end
