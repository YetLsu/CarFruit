//
//  NFFarmDetailViewController.m
//  guonongda
//
//  Created by guest on 16/10/5.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFFarmDetailViewController.h"
#import "NFWXPayUtils.h"

@interface NFFarmDetailViewController ()

@end

@implementation NFFarmDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupContent];
    
    [self setupBottom];
}

- (void)setupContent{
    self.view.backgroundColor = kBaseBackgroundColor;
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 60)];
    NSURL *url = [NSURL URLWithString:@"http://www.sxeto.com/party/"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [webView setScalesPageToFit:YES];
    
    [webView loadRequest:request];
    
    webView.scrollView.bounces = NO;
    
    [self.view addSubview:webView];
    
}

- (void)setupBottom{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 60 , kScreenWidth, 60)];
    UIButton *reserveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    reserveButton.frame = CGRectMake(15, 8, kScreenWidth - 30, 45);
    [reserveButton setBackgroundImage:[UIImage imageNamed:@"botton_didi_fee"] forState:UIControlStateNormal];
    [reserveButton setTitle:@"微信预约" forState:UIControlStateNormal];
    [reserveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [reserveButton addTarget:self action:@selector(reserveAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:reserveButton];
    [self.view addSubview:bottomView];
}

#pragma mark 调用微信支付
- (void)reserveAction{
    [NFWXPayUtils jumpToWXPay];
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
