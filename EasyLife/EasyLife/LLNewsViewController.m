//
//  LLNewsViewController.m
//  EasyLife
//
//  Created by qingyun on 16/1/12.
//  Copyright © 2016年 lily. All rights reserved.
//

#import "LLNewsViewController.h"
#import "UIBarButtonItem+LL.h"

@interface LLNewsViewController ()<UIWebViewDelegate>
@property (nonatomic, weak) UIWebView *webView;
@property (nonatomic, weak) UIActivityIndicatorView *indicator;
@property (nonatomic, strong) UITableView *newsTableView;
@end

#define baiduNewUrl @"http://news.baidu.com" //@"http://m.baidu.com/news?fr=mohone"
#define fengNewUrl @"http://3g.ifeng.com"
#define sinaNewUrl @"http://news.sina.cn"
#define tencenNewUrl @"http://info.3g.qq.com"
#define NetEaseNewUrl @"http://3g.163.com"


@implementation LLNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"最新闻";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_back" target:self action:@selector(cancel)];
//    self.navigationItem.rightBarButtonItem  = [UIBarButtonItem itemWithIcon:@"navigationbar_more" target:self action:@selector(selectMoreNews)];
    
    [self setupWebView];
    [self loadWebViewUrl];
    [self setupActivityIndicator];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)setupWebView
{
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    self.webView = webView;
    self.webView.delegate = self;
}

- (void)loadWebViewUrl
{
    NSURL *url = [NSURL URLWithString:NetEaseNewUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
}

- (void)setupActivityIndicator
{
    //初始化
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    
    //设置显示样式，见UIActivityIndicatorViewStyle的定义
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    
    //设置显示位置
    [indicator setCenter:CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2)];
    
    //设置背景颜色
    indicator.backgroundColor = [UIColor grayColor];
    
    indicator.alpha =0.5;
    
    //设置背景为圆角矩形
    indicator.layer.cornerRadius = 6;
    indicator.layer.masksToBounds = YES;
    
    [self.view addSubview:indicator];
    self.indicator = indicator;
    self.indicator.hidden = YES;
}
#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.indicator startAnimating];
    self.indicator.hidden = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.indicator stopAnimating];
    self.indicator.hidden = YES;
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
