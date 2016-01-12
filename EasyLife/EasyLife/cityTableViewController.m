//
//  cityTableViewController.m
//  EasyLife
//
//  Created by qingyun on 16/1/9.
//  Copyright © 2016年 lily. All rights reserved.
//

#import "cityTableViewController.h"
#import "CityResultTableViewController.h"

@interface cityTableViewController ()
@property (nonatomic, strong) UISearchController *searchController;
@end

@implementation cityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(presentViewController:)];
    
    self.title = @"选择城市";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem alloc];
    
    CityResultTableViewController *resultTVC = [[CityResultTableViewController alloc]initWithStyle:UITableViewStylePlain];
//    resultTVC.Citydatas = self.provincesAndCities;
    resultTVC.cities = self.provincesAndCities;
    _searchController = [[UISearchController alloc]initWithSearchResultsController:resultTVC];
    
    _searchController.searchResultsUpdater = resultTVC;
    _searchController.hidesNavigationBarDuringPresentation = YES;
    _searchController.dimsBackgroundDuringPresentation = YES;
    
    
    
}

- (void)presentViewController:(UIBarButtonItem *)sender
{
    [self presentViewController:_searchController animated:YES completion:nil];
}

- (NSArray *)provincesAndCities
{
    if (_provincesAndCities == nil) {
        _provincesAndCities = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ProvincesAndCities.plist" ofType:nil]];
    }
    return _provincesAndCities;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.provincesAndCities.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *citysDic = self.provincesAndCities[section];
    NSArray *citys = citysDic[@"Cities"];
    return citys.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"CityCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSDictionary *citysDic = self.provincesAndCities[indexPath.section];
    _Cities = citysDic[@"Cities"];
    NSDictionary *cityInfoDic = _Cities[indexPath.row];
    cell.textLabel.text = cityInfoDic[@"city"];
    
    return cell;
}
//设置行标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *dic = self.provincesAndCities[section];
    //其中State是plist文件中的一个键 表示省份
    return dic[@"State"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *citysDic = self.provincesAndCities[indexPath.section];
    //一个省中城市的集合
   _Cities = citysDic[@"Cities"];
    NSDictionary *cityInfoDic = _Cities[indexPath.row];
    //读取到每一个城市
    NSString *city = cityInfoDic[@"city"];
    if ([_citysDelegate respondsToSelector:@selector(citysViewDidSelectedCity:)]) {
        [_citysDelegate citysViewDidSelectedCity:city];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
