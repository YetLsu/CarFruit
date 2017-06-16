//
//  NFPinPublishViewController.m
//  guonongda
//
//  Created by guest on 16/11/4.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFPinPublishViewController.h"
#import "NFPinningViewController.h"

@interface NFPinPublishViewController ()

@end

@implementation NFPinPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavi];
    
    [self setupContent];
}

- (void)setupNavi{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    titleLabel.text = @"发布拼单";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    
    UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    publishButton.frame = CGRectMake(0, 2, 60, 40);
    [publishButton setTitle:@"发布" forState:UIControlStateNormal];
    [publishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    publishButton.titleLabel.font = [UIFont systemFontOfSize:18];
    publishButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [publishButton addTarget:self action:@selector(publishAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:publishButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)publishAction{
    NSLog(@"publish");
    NFPinningViewController *pinningVc = [[NFPinningViewController alloc] init];
    [self.navigationController pushViewController:pinningVc animated:YES];
    
    
}

- (void)setupContent{
    self.view.backgroundColor = kBaseBackgroundColor;
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
