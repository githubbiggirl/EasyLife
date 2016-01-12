//
//  CityResultTableViewController.m
//  EasyLife
//
//  Created by qingyun on 16/1/10.
//  Copyright © 2016年 lily. All rights reserved.
//

#import "CityResultTableViewController.h"
#import "cityTableViewController.h"

@interface CityResultTableViewController ()
@property (nonatomic, strong) NSArray *CityResult;
@property (nonatomic, strong) cityTableViewController *citytableVC;
@end

@implementation CityResultTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _citytableVC = [[cityTableViewController alloc]init];    
    _cities = _citytableVC.Cities;
    NSLog(@"%@",_cities);
    
   
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *filterString = searchController.searchBar.text;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.city CONTAINS[cd] %@",filterString];
    NSMutableArray *array = [NSMutableArray array];
    for (int i =0 ; i<_cities.count; i++) {
        NSArray *filterArray = [_cities filteredArrayUsingPredicate:predicate];
        [array addObject:filterArray];
    }
    _selectedCities = array;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.selectedCities.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"fitlerCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    /**
     * 10号调试到这里了
     */
    NSDictionary *citysDic = _selectedCities[indexPath.row];
//    NSArray *citys = citysDic[@"Cities"];
//    NSDictionary *cityInfoDic = citys[indexPath.row];
    cell.textLabel.text = citysDic[@"city"];
    

    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
