//
//  NFNearShopViewController.m
//  guonongda
//
//  Created by guest on 16/8/30.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFNearShopViewController.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import "NFShopDetailViewController.h"
#import "NFNearShopCell.h"
#import "NFShopSearchViewController.h"
#import "NFAddNewShopViewController.h"
#import "NFShopInnerViewController.h"
@interface NFNearShopViewController ()<UITableViewDelegate,UITableViewDataSource,AMapLocationManagerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;

@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) AMapLocationReGeocode *regeocode;
@property (nonatomic, strong) UIButton *locationBtn;

@property (nonatomic, strong) UIView *searchView;



@end
static NSString *nearShopCellId = @"nearShopCellId";
@implementation NFNearShopViewController

- (NSMutableArray *)datasource{
    if (_datasource == nil) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavi];
    [self configureLocation];
    [self setupContent];
    
    
}

- (void)configureLocation{
    _locationManager = [[AMapLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [self reLocation];
    
}

- (void)reLocation{
    [_locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
    _regeocode = regeocode;
    [_locationBtn setTitle:_regeocode.POIName forState:UIControlStateNormal];
    }];
}

- (void)setupNavi{
    _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _locationBtn.frame = CGRectMake(0, 20, 200, 40);
    [_locationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_locationBtn addTarget:self action:@selector(reLocation) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = _locationBtn;
    
//    左边添加新店的按钮
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(0, 0, 46, 40);
    [addButton setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    [addButton setContentEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    [addButton addTarget:self action:@selector(addNewShop) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    self.navigationItem.rightBarButtonItem = rightButton;
    
}


#pragma mark 请求定位
- (void)setupContent{
    _searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 45)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, kScreenWidth - 30, 25)];
    imageView.image = [UIImage imageNamed:@"seachbar"];
    [_searchView addSubview:imageView];
    [self.view addSubview:_searchView];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchAction:)];
    [_searchView addGestureRecognizer:tapGR];

    self.view.backgroundColor = kBaseBackgroundColor;

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_searchView.frame), kScreenWidth, kScreenHeight - 45)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"NFNearShopCell" bundle:nil] forCellReuseIdentifier:nearShopCellId];
    _tableView.rowHeight = 140;
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    _tableView.scrollIndicatorInsets = _tableView.contentInset;
    [self.view addSubview: _tableView];

}

#pragma mark 跳转到发现新店
- (void)addNewShop{
    NFAddNewShopViewController *newShopVc = [[NFAddNewShopViewController alloc] init];
    [self.navigationController pushViewController:newShopVc animated:YES];
}
#pragma mark 跳转到搜索页面
- (void)searchAction:(UITapGestureRecognizer *)tapGR{
    NSLog(@"search");
    NFShopSearchViewController *shopSearchVc = [[NFShopSearchViewController alloc] init];
    
    [self.navigationController pushViewController:shopSearchVc animated:YES];
    
}


#pragma mark tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NFNearShopCell *cell = [tableView dequeueReusableCellWithIdentifier:nearShopCellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    [cell setRating:5];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NFShopDetailViewController *shopDetail = [[NFShopDetailViewController alloc] init];
//    NFShopInnerViewController *shopInnerVc = [[NFShopInnerViewController alloc] init];
    
    [self.navigationController pushViewController:shopDetail animated:YES];
    
}





//取消searchbar背景色
//- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
//{
//    CGRect rect = CGRectMake(0, 0, size.width, size.height);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetFillColorWithColor(context, [color CGColor]);
//    CGContextFillRect(context, rect);
//    
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return image;
//}

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
