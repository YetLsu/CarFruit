//
//  NFViewController.m
//  guonongda
//
//  Created by guest on 16/8/29.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFViewController.h"
#import "NFShopViewController.h"
#import "NFFarmViewController.h"
#import "NFMeViewController.h"
//#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "NFNearShopViewController.h"
#import "NFChooseCityViewController.h"
@interface NFViewController ()<AMapLocationManagerDelegate,NFChooseCityDelegate>

//@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, strong) UIButton *leftItem;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) AMapLocationReGeocode *regeocode;
@property (nonatomic, strong) NSString *currentCity;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) UIButton *currentSelectedBtn;


@end

@implementation NFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureLocation];
    
    [self configureNavi];
    
    [self configureContent];
    
    
}

- (void)configureLocation{
    _locationManager = [[AMapLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [_locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        _regeocode = regeocode;
        _currentCity = _regeocode.city;
    }];

}


//设置导航栏
- (void)configureNavi{
    
    NSArray *items = @[@"商店",@"果园"];
    UIView *segmentView = [[UIView alloc] initWithFrame:CGRectMake(0, 7, 120, 30)];
    segmentView.layer.borderWidth = 1;
    segmentView.layer.borderColor = [UIColor whiteColor].CGColor;
    segmentView.layer.cornerRadius = 3;
    segmentView.layer.masksToBounds = YES;
    CGFloat btnW = segmentView.width/2;
    CGFloat btnH = segmentView.height;
    _indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, btnW, btnH)];
    _indicatorView.backgroundColor = [UIColor whiteColor];
    [segmentView addSubview:_indicatorView];
    
    for (int i = 0; i < 2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*btnW, 0, btnW, btnH);
        [button addTarget:self action:@selector(changeChildVC:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:items[i] forState:UIControlStateNormal];
        button.tag = i;
        [button setTitleColor:kBaseColor forState:UIControlStateDisabled];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [segmentView addSubview:button];
        
        if (i == 0) {
            button.enabled = NO;
            _currentSelectedBtn = button;
        }
    }
    
    self.navigationItem.titleView = segmentView;
    UIButton *meButton = [UIButton buttonWithType:UIButtonTypeCustom];
    meButton.frame = CGRectMake(0, 0, 40, 20);
    [meButton setImage:[UIImage imageNamed:@"person"] forState:UIControlStateNormal];
    [meButton addTarget:self action:@selector(showMe) forControlEvents:UIControlEventTouchUpInside];
    [meButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -14)];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:meButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftItem.frame = CGRectMake(0, 0, 90, 20);
    [_leftItem addTarget:self action:@selector(leftItemAction) forControlEvents:UIControlEventTouchUpInside];
    [_leftItem setTitle:@"附近" forState:UIControlStateNormal];
    [_leftItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _leftItem.contentEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 20);
    _leftItem.titleLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_leftItem];
    
}

//导航栏的方法
- (void)showMe{
    NFMeViewController *me = [[NFMeViewController alloc] init];
    [self.navigationController pushViewController:me animated:YES];
}

- (void)changeChildVC:(UIButton *)sender{
    NSInteger tag = sender.tag;
    UIViewController *childVc = self.childViewControllers[tag];
    [self.view addSubview:childVc.view];
    
    _currentSelectedBtn.enabled = YES;
    sender.enabled = NO;
    _currentSelectedBtn = sender;
    
    if (tag == 0) {
        [_leftItem setTitle:@"附近" forState:UIControlStateNormal];
    }else{
        [_leftItem setTitle:_currentCity forState:UIControlStateNormal];
    }
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        _indicatorView.center = sender.center;
    }];
    
}

- (void)leftItemAction{
    if (_currentSelectedBtn.tag == 0) {
        NFNearShopViewController *nearShop = [[NFNearShopViewController alloc] init];
        [self.navigationController pushViewController:nearShop animated:YES];
    }else if (_currentSelectedBtn.tag == 1){
        NFChooseCityViewController *cityVc = [[NFChooseCityViewController alloc] init];
        cityVc.delegate = self;
        cityVc.currentCity = _regeocode.city;
        [self.navigationController pushViewController:cityVc animated:YES];
    }
}


//设置内容
- (void)configureContent{
    NFShopViewController *shopVc = [[NFShopViewController alloc] init];
    [self addChildViewController:shopVc];
    NFFarmViewController *farm = [[NFFarmViewController alloc] init];
    [self addChildViewController:farm];
    
    [self changeChildVC:_currentSelectedBtn];
}


//选择城市的回调
- (void)getCity:(NSString *)city{
    _currentCity = city;
    [_leftItem setTitle:_currentCity forState:UIControlStateNormal];
    
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
