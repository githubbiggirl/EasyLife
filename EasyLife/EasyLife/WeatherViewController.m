//
//  WeatherViewController.m
//  EasyLife
//
//  Created by qingyun on 16/1/8.
//  Copyright © 2016年 lily. All rights reserved.
//

#import "WeatherViewController.h"
#import "KLComment.h"
#import "simpleWeatherView.h"
#import "WeatherInfo.h"
#import "cityTableViewController.h"
#import "LLLocationTool.h"
#import "UrlSource.h"
#import "MJExtension.h"
#import "NSObject+MJKeyValue.h"
#import "UIImage+WB.h"

@interface WeatherViewController ()<CitysViewdelegate>
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *weekLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *windLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *qualityLabel;

@property (nonatomic, strong) NSArray *simpleWeathers;

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"天气预报";
    
    
/**
 * 关于定位的监听和操作
 */
    //定位
    [LLLocationTool sharedLLLocationTool];
    
    //监听定位城市改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationCity) name:LocationCityNote object:nil];
    
    //读取当前城市
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *city = [defaults objectForKey:@"currentCity"];
    if (city == nil) {
        city = @"北京";
    }
    
    /**
     * 加载各种视图
     */
    [self setupSimpleWeathers];
    
    [self locationCity];
    
    [self loadWeatherData:city];
    
}

//取消
- (void)Cancel
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 收到定位城市通知
- (void)locationCity
{
    LLLocationCity *locationCity = [LLLocationTool sharedLLLocationTool].locationCity;
    if (locationCity && locationCity.city) {
        [self loadWeatherData:[LLLocationTool sharedLLLocationTool].locationCity.city];
    }
}

#pragma mark - 获取城市天气数据
- (void)loadWeatherData:(NSString *)city
{
    [UrlSource getWeatherDataWithCity:city success:^(id json) {
        
        NSArray *weatherInfo = [WeatherInfo objectArrayWithKeyValuesArray:json[@"results"]];
        NSLog(@"%@",weatherInfo);
        _weatherinfo = weatherInfo[0];
        
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
        //用[NSDate date]可以获取系统当前时间
        NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
        _weatherinfo.date = currentDateStr;
       
        [self setupWeatherInfo:_weatherinfo];

    } failure:^(NSError *error) {
        NSLog(@"加载天气失败!");
    }];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:city forKey:@"currentCity"];
}

#pragma mark - 选择城市
- (IBAction)selectCities:(id)sender {
    
    cityTableViewController *cityVC = [[cityTableViewController alloc]initWithStyle:UITableViewStylePlain];
    cityVC.citysDelegate = self;
    [self.navigationController pushViewController:cityVC animated:YES];
}

//代理方法
- (void)citysViewDidSelectedCity:(NSString *)city
{
    //加载天气
    [self loadWeatherData:city];
}

- (void)setupSimpleWeathers
{
    CGFloat simpleWeatherX = 0;
    CGFloat simpleX = 10;
    CGFloat simpleWeatherY = CGRectGetMaxY(self.detailLabel.frame);
//    if (is4Inch) {
//        simpleWeatherY += 10;
//    }
    CGFloat simpleWeatherH = 120;
    CGFloat simpleWeatherW = (self.view.frame.size.width - 2* simpleX)/3;
    
    NSMutableArray *simpleWeathers = [NSMutableArray array];
    
    
    for (int i = 0; i < 3; ++i) {
        simpleWeatherView *simpleWeather = [simpleWeatherView createView];
        [self.view addSubview:simpleWeather];
        [simpleWeathers addObject:simpleWeather];
        
        simpleWeatherX = simpleX + simpleWeatherW * i;
        simpleWeather.frame = CGRectMake(simpleWeatherX, simpleWeatherY, simpleWeatherW, simpleWeatherH);
    }
    self.simpleWeathers = simpleWeathers;
}

- (void)setupWeatherInfo:(WeatherInfo *)weatherinfo
{
    LLWeatherData *weatherData = self.weatherinfo.weather_data[0];
    LLIndexDetail *detail = self.weatherinfo.index[0];
    
    self.cityLabel.text = self.weatherinfo.currentCity;
    self.dateLabel.text = self.weatherinfo.date;
    self.qualityLabel.text = self.weatherinfo.pm25;
    self.weekLabel.text = [weatherData.date substringToIndex:3];
    self.temperatureLabel.text = weatherData.temperature;
    NSString *weather = weatherData.weather;
    NSUInteger strLocation = [weather rangeOfString:@"转"].location;
    if (strLocation != NSNotFound) {
        weather = [weather substringToIndex:strLocation];
    }
    
    
    self.weatherImageView.image = [UIImage imageWithName:weather];
    self.windLabel.text = weatherData.wind;
    self.weatherLabel.text = weatherData.weather;
    self.detailLabel.text = [NSString stringWithFormat:@"%@ : %@",detail.tipt,detail.des];
    
    for (int i =1; i <4; ++i) {
        weatherData = self.weatherinfo.weather_data[i];
        simpleWeatherView *simpleView = self.simpleWeathers[i - 1];
        simpleView.weekLabel.text = weatherData.date;
        simpleView.backgroundColor = [UIColor clearColor];
        NSString *weather = weatherData.weather;
        NSLog(@">>>天气是%@",weather);
        NSUInteger strLocation = [weather rangeOfString:@"转"].location;
        NSLog(@"%lu",(unsigned long)strLocation);
        if (strLocation != NSNotFound) {
            weather = [weather substringToIndex:strLocation];
        }
        simpleView.weatherImageView.image = [UIImage imageWithName:weather];
        simpleView.windLabel.text = weatherData.wind;
        simpleView.weatherLabel.text = weatherData.weather;
        simpleView.temperature.text = weatherData.temperature;

        NSLog(@"%@>>>%@>>>",simpleView.weatherLabel.text,simpleView.windLabel.text);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
