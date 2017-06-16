//
//  NFAddNewShopViewController.m
//  guonongda
//
//  Created by guest on 16/9/20.
//  Copyright © 2016年 聂凡. All rights reserved.
//


#import "NFAddNewShopViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "NFNewShopCell.h"

#define kCellWidth (kScreenWidth - 40)/3
@interface NFAddNewShopViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,MAMapViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,NFNewShopCellDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) UILabel *addressLabel;
//地图上移动的图标
@property (nonatomic, strong) UIImageView *shopAnotationView;
@property (nonatomic, strong) UILabel *shopAddrLabel;
@property (nonatomic, strong) CLLocation *userLocation;
@property (nonatomic, strong) CLLocation *shopLocation;

@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@property (nonatomic, strong) CLGeocoder *geoCoder;

@end

static NSString *const newShopCellIdentifier = @"newShopCellIdentifier";
@implementation NFAddNewShopViewController

- (NSMutableArray *)datasource{
    if (_datasource == nil) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavi];
    
    [self setupContent];
    
    [self setupSomeOther];
}

- (void)setupNavi{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    titleLabel.text = @"新店推荐";
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


- (void)setupContent{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UILabel *markLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 64, kScreenWidth - 30, 40)];
    markLabel.text = @"\t拍照后，发布店铺审核成功的用户，可获得滴滴出行优惠券一张";
    markLabel.numberOfLines = 2;
    markLabel.font = [UIFont systemFontOfSize:13];
    markLabel.textColor = [UIColor grayColor];
    [self.view addSubview:markLabel];
    
    self.view.backgroundColor = kBaseBackgroundColor;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kCellWidth, kCellWidth + 15);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, markLabel.bottom + 5, kScreenWidth, kCellWidth + 15) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = kBaseBackgroundColor;
    [_collectionView registerClass:[NFNewShopCell class] forCellWithReuseIdentifier:newShopCellIdentifier];
    [self.view addSubview:_collectionView];

    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, _collectionView.bottom + 15, kScreenWidth, kScreenHeight - _collectionView.bottom - 15)];
    _mapView.showsScale = NO;
    _mapView.showsCompass = NO;
    _mapView.rotateEnabled = NO;
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    [self.view addSubview:_mapView];
    
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    bgView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8];
    _shopAddrLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, 40)];
//    _shopAddrLabel.text = @"华齐路纺都大厦1101";
    _shopAddrLabel.textColor = [UIColor grayColor];
    _shopAddrLabel.font = [UIFont systemFontOfSize:13];
    [bgView addSubview:_shopAddrLabel];
    [_mapView addSubview:bgView];
    
    
    UIButton *locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    locationBtn.frame = CGRectMake(10, _mapView.height - 70, 40, 40);
    [locationBtn setBackgroundImage:[UIImage imageNamed:@"location_"] forState:UIControlStateNormal];
    [locationBtn addTarget:self action:@selector(showUserLocation) forControlEvents:UIControlEventTouchUpInside];
    [_mapView addSubview:locationBtn];
    

    _shopAnotationView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 23, 27.5)];
    _shopAnotationView.center = _mapView.center;
    _shopAnotationView.image = [UIImage imageNamed:@"map_store1"];
    [self.view addSubview:_shopAnotationView];
    
    
    
}

- (void)setupSomeOther{
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    _imagePickerController.delegate = self;
    
    _geoCoder = [[CLGeocoder alloc] init];
}

#pragma mark 地图的代理方法
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    if (updatingLocation) {
        _userLocation = userLocation.location;
    }
}


#pragma mark 点击定位按钮
- (void)showUserLocation{
    [_mapView setCenterCoordinate:_userLocation.coordinate animated:YES];

}


#pragma mark 发布
- (void)publishAction{
    

}

#pragma mark collectionView datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.datasource.count < 3) {
        return self.datasource.count + 1;
    }else{
        return 3;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NFNewShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:newShopCellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    if (indexPath.row == _datasource.count && _datasource.count < 3) {
        cell.shopImageView.image = [UIImage imageNamed:@"add_plus"];
        cell.deleteBtn.hidden = YES;
        
    }else {
        cell.shopImageView.image = _datasource[indexPath.row];
        cell.deleteBtn.hidden = NO;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.datasource.count == indexPath.row){
        [self presentViewController:_imagePickerController animated:YES completion:nil];
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(0, 10, 0, 10);
}

#pragma mark 拍照后的图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [_imagePickerController dismissViewControllerAnimated:YES completion:nil];
    [self.datasource addObject:info[UIImagePickerControllerOriginalImage]];
    [_collectionView reloadData];

}

#pragma mark 删除照片
- (void)deleteThePhotoFromCell:(NFNewShopCell *)shopCell{
    UIImage *image = shopCell.shopImageView.image;
    [self.datasource removeObject:image];
    [_collectionView reloadData];
}

#pragma mark 地图移动结束后调用
- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction{
    CLLocationCoordinate2D center = [_mapView convertPoint:self.shopAnotationView.center toCoordinateFromView:self.view];
//     MACoordinateRegion region = _mapView.region;
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:center.latitude longitude:center.longitude];
    
//    [NFUtils getRegeoCoderWithLocation:location block:^(CLPlacemark *placemark) {
//        _shopAddrLabel.text = placemark.name;
//    }];
    
    [_geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placemark = [placemarks lastObject];
        _shopAddrLabel.text = placemark.name;
    }];
}



//- (void)mapView:(MAMapView *)mapView didLongPressedAtCoordinate:(CLLocationCoordinate2D)coordinate{
//    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
//    [_geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        CLPlacemark *placemark = [placemarks lastObject];
//        _shopAddrLabel.text = placemark.name;
//    }];
//
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
