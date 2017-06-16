//
//  NFDDViewController.m
//  guonongda
//
//  Created by guest on 16/8/30.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFDDViewController.h"

@interface NFDDViewController ()

@end

@implementation NFDDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureContent];
}

- (void)configureContent{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSString *string = [NSString stringWithFormat:@"http://common.diditaxi.com.cn/general/webEntry?maptype=wgs&fromlat=%f&fromlng=%f&tolat=%f&tolng=%f",_userLocation.coordinate.latitude,_userLocation.coordinate.longitude,_shopLocation.coordinate.latitude,_shopLocation.coordinate.longitude];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
    
    [self.view addSubview:webView];

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
