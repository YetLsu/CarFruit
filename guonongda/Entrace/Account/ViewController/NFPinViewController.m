//
//  NFPinViewController.m
//  guonongda
//
//  Created by guest on 16/11/1.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFPinViewController.h"
#import "NFPinNearViewController.h"
#import "NFPinMeViewController.h"

@interface NFPinViewController ()
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, assign) CGRect childViewRect;
@property (nonatomic, strong) UIView *currentChildView;

@end

@implementation NFPinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setChildVC];
    [self configureNavi];
    [self setupSegment];
}

- (void)setChildVC{
    NFPinNearViewController *pinNearVc = [[NFPinNearViewController alloc] init];
    pinNearVc.title = @"附 近";
    [self addChildViewController:pinNearVc];
    NFPinMeViewController *pinMeVc = [[NFPinMeViewController alloc] init];
    pinMeVc.title = @"我 的";
    [self addChildViewController:pinMeVc];
}

#pragma mark - 设置导航栏
- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}

- (void)configureNavi{
    
    UIView *naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    naviView.backgroundColor = kBaseColor;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 20, 60, 34);
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(13, 0, 0, 4);
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [naviView addSubview:backButton];
    [self.view addSubview:naviView];
    
    UIButton *filterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    filterButton.frame = CGRectMake(kScreenWidth - 60, 20, 60, 34);
    [filterButton setImage:[UIImage imageNamed:@"pin_screen"] forState:UIControlStateNormal];
    filterButton.imageEdgeInsets = UIEdgeInsetsMake(13, 0, 0, 4);
    [filterButton addTarget:self action:@selector(filterAction) forControlEvents:UIControlEventTouchUpInside];
    [naviView addSubview:filterButton];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 120)/2, 20+7, 120, 30)];
    titleLabel.text = @"拼一拼";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [naviView addSubview:titleLabel];
    [self.view bringSubviewToFront:naviView];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)filterAction{
    NSLog(@"filter");
}

- (void)setupSegment{
    self.view.backgroundColor = kBaseBackgroundColor;
    UIView *segmentView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 44)];
    segmentView.backgroundColor = kBaseColor;
    [self.view addSubview:segmentView];
    
    _indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 13, 7)];
    _indicatorView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"selected"]];
    _indicatorView.y = segmentView.height - 6;
    CGFloat btnW = (kScreenWidth-20)/2;
    CGFloat btnH = segmentView.height - 7;
    for (int i=0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10+i*btnW, 0, btnW, btnH);
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [segmentView addSubview:button];
        button.tag = i;
        if (button.tag == 0) {
            _indicatorView.centerX = button.centerX;
            _selectButton = button;
        }
    }
    [segmentView addSubview:_indicatorView];
    
    _childViewRect = CGRectMake(0, segmentView.bottom, kScreenWidth, kScreenHeight - 64 - 44);
    [self changeChildViewWithTag:0];
}

- (void)click:(UIButton *)button{
    _indicatorView.centerX = button.centerX;
    _selectButton = button;
    [self changeChildViewWithTag:button.tag];
}

- (void)changeChildViewWithTag:(NSInteger)tag{
    UIView *childView = self.childViewControllers[tag].view;
    childView.frame = _childViewRect;
    [self.view addSubview: childView];
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
