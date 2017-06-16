//
//  NFNaviController.m
//  guonongda
//
//  Created by guest on 16/8/29.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFNaviController.h"

@interface NFNaviController ()

@end

@implementation NFNaviController

+ (void)initialize{
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.barTintColor = kBaseColor;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav"] forBarMetrics:UIBarMetricsDefault];
//    self.navigationBar.barTintColor = kBaseColor;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [button setTitle:@"返回" forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:@"navigationButtonBack"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 30, 20);
        // 让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //        [button sizeToFit];
        // 让按钮的内容往左边偏移10
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
        
        //        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        // 修改导航栏左边的item
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back{

    [self popViewControllerAnimated:YES];
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
