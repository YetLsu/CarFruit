//
//  NFShopMapViewController.m
//  guonongda
//
//  Created by guest on 16/10/12.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFShopMapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "UINavigationBar+Awesome.h"
#import <AMapNaviKit/AMapNaviKit.h>
#import "SpeechSynthesizer.h"
#import "NFShopWrongViewController.h"

#define kBottomViewHeight 140
@interface NFShopMapViewController ()<MAMapViewDelegate,AMapNaviDriveViewDelegate,AMapNaviDriveManagerDelegate>
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) CLLocation *userLocation;
//默认为驾车导航
@property (nonatomic, strong) AMapNaviDriveManager *driveManager;
//语音驾车导航的视图
@property (nonatomic, strong) AMapNaviDriveView *naviDriveView;


@end

@implementation NFShopMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBottomView];
    [self setupMap];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (AMapNaviDriveManager *)driveManager{
    if (_driveManager == nil) {
        _driveManager = [[AMapNaviDriveManager alloc] init];
        _driveManager.delegate = self;
    }
    return _driveManager;
}

- (void)initNaviDriveView{
    if (self.naviDriveView == nil) {
        self.naviDriveView = [[AMapNaviDriveView alloc] initWithFrame:self.view.bounds];
        self.naviDriveView.delegate = self;
    }
    
}

- (void)setupMap{
    self.view.backgroundColor = [UIColor whiteColor];
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - _bottomView.height - 10)];
    _mapView.showsScale = NO;
    _mapView.showsCompass = NO;
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;
    [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    _mapView.rotateCameraEnabled = NO;
    [self.view addSubview: _mapView];
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    //30.096357
    //120.510736
#warning 这里的店铺地址仅仅作为测试
    self.shopLocation = [NFUtils getLocationWithLat:@"30.096357" lon:@"120.510736"];
    pointAnnotation.coordinate = self.shopLocation.coordinate;
    [_mapView addAnnotation:pointAnnotation];
    
//    _endPoint = _shopLocation.coordinate;
    
    UIButton *findMeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    findMeButton.frame = CGRectMake(10, _mapView.bottom - 100, 40, 40);
    [findMeButton addTarget:self action:@selector(findMe) forControlEvents:UIControlEventTouchUpInside];
    [findMeButton setBackgroundImage:[UIImage imageNamed:@"location_"] forState:UIControlStateNormal];
    [self.view addSubview:findMeButton];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(-5, 64, 65, 40);
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    backButton.backgroundColor = [UIColor colorWithHexString:@"#31ae9a" alpha:0.6];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backButton.layer.cornerRadius = 8;
    backButton.layer.masksToBounds = YES;
    [self.view addSubview:backButton];
}


- (void)setupBottomView{
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - kBottomViewHeight, kScreenWidth, kBottomViewHeight)];
    UILabel *shopName = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 20)];
    shopName.text = @"杨洋水果";
    shopName.textAlignment = NSTextAlignmentCenter;
    shopName.font = [UIFont boldSystemFontOfSize:18];
    shopName.textColor = [UIColor blackColor];
    [_bottomView addSubview:shopName];
    
    UILabel *shopLocation = [[UILabel alloc] initWithFrame:CGRectMake(0, shopName.bottom + 10, kScreenWidth, 20)];
    shopLocation.text = @"万达中心名宅12号楼4单元";
    shopLocation.textAlignment = NSTextAlignmentCenter;
    shopLocation.font = [UIFont systemFontOfSize:13];
    shopLocation.textColor = [UIColor blackColor];
    [_bottomView addSubview:shopLocation];
    
    CGFloat buttonW = (kScreenWidth - 30)/2;
    CGFloat buttonH = _bottomView.height - shopLocation.bottom - 20;
    
    UIButton *naviButton = [UIButton buttonWithType:UIButtonTypeCustom];
    naviButton.frame = CGRectMake(10, shopLocation.bottom + 10, buttonW, buttonH);
    [naviButton setTitle:@"自驾导航" forState:UIControlStateNormal];
    [naviButton setTitleColor:kBaseColor forState:UIControlStateNormal];
    naviButton.layer.borderWidth = 1;
    naviButton.layer.borderColor = kBaseColor.CGColor;
    naviButton.layer.cornerRadius = 8;
    naviButton.layer.masksToBounds = YES;
    [naviButton addTarget:self action:@selector(naviAction) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:naviButton];
    
    UIButton *correctButton = [UIButton buttonWithType:UIButtonTypeCustom];
    correctButton.frame = CGRectMake(10 + naviButton.right, shopLocation.bottom + 10, buttonW, buttonH);
    [correctButton setTitle:@"店铺纠错" forState:UIControlStateNormal];
    [correctButton setTitleColor:kBaseColor forState:UIControlStateNormal];
    correctButton.layer.borderWidth = 1;
    correctButton.layer.borderColor = kBaseColor.CGColor;
    correctButton.layer.cornerRadius = 8;
    correctButton.layer.masksToBounds = YES;
    [correctButton addTarget:self action:@selector(correctAction) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:correctButton];
    [self.view addSubview:_bottomView];
}

#pragma mark - 返回
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 地图的代理方法
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    
    if(updatingLocation)
    {
        _userLocation = userLocation.location;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            MACoordinateSpan span = MACoordinateSpanMake(0.031725, 0.020614);
            MACoordinateRegion  region = MACoordinateRegionMake(_userLocation.coordinate, span);
            [_mapView setRegion:region animated:YES];
        });
    }
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";;
        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"map_store1"];
        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        annotationView.canShowCallout= NO;       //设置气泡可以弹出，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        return annotationView;

    }
    return nil;
}

#pragma mark - 设置地图中心
- (void)findMe{
    [self.mapView setCenterCoordinate:self.userLocation.coordinate animated:YES];
}

#pragma mark - 导航
- (void)naviAction{
    AMapNaviPoint *startP = [AMapNaviPoint locationWithLatitude:self.userLocation.coordinate.latitude longitude:self.userLocation.coordinate.longitude];
    
    AMapNaviPoint *endP = [AMapNaviPoint locationWithLatitude:self.shopLocation.coordinate.latitude longitude:self.shopLocation.coordinate.longitude];
    
    NSArray *startArray = @[startP];
    NSArray *endArray = @[endP];
    
    [self.driveManager calculateDriveRouteWithStartPoints:startArray endPoints:endArray wayPoints:nil drivingStrategy:AMapNaviDrivingStrategyDefault];
}

#pragma mark - 导航代理 路线计算成功的回调方法
- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager
{
    
    [self initNaviDriveView];
    
    //将naviDriveView添加到AMapNaviDriveManager中
    [self.driveManager addDataRepresentative:self.naviDriveView];
    
    //将导航视图添加到视图层级中
    [self.view addSubview:self.naviDriveView];
    
    //开始实时导航
    [self.driveManager startGPSNavi];
}

#pragma mark - 调用语音导航
-(void)driveManager:(AMapNaviDriveManager *)driveManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType
{
    
    [[SpeechSynthesizer sharedSpeechSynthesizer] speakString:soundString];
    
}

#pragma mark - 停止导航
- (void)driveViewCloseButtonClicked:(AMapNaviDriveView *)driveView
{
    [self.driveManager stopNavi];
    [[SpeechSynthesizer sharedSpeechSynthesizer] stopSpeak];
    //将naviDriveView从AMapNaviDriveManager中移除
    [self.driveManager removeDataRepresentative:self.naviDriveView];
    
    //将导航视图从视图层级中移除
    [self.naviDriveView removeFromSuperview];
}

#pragma mark - 纠错
- (void)correctAction{
    NFShopWrongViewController *shopWrongVc = [[NFShopWrongViewController alloc] init];
    [self.navigationController pushViewController:shopWrongVc animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
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
