//
//  NFShopViewController.m
//  guonongda
//
//  Created by guest on 16/8/29.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFShopViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "NFShopModel.h"
#import <DIOpenSDK/DIOpenSDK.h>
#import "NFDDViewController.h"
#import "NFPopView.h"
#import "NFShopDetailViewController.h"


#import "NFCoordinateQuadTree.h"
#import "NFClusterAnnotation.h"
#import "NFClusterAnnotationView.h"


#define kShopURL @"http://app.guonongda.com:8080/shop/showlist2.do"

@interface NFShopViewController ()<MAMapViewDelegate,NFPopViewDelegate>
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) CLLocation *userLocation;
@property (nonatomic, strong) CLLocation *shopLocation;
@property (nonatomic, strong) NSMutableArray *annotations;
@property (nonatomic, strong) NFPopView *popView;

//@property (nonatomic, strong) NFAnnotationView *lastSelectedAnnotation;
@property (nonatomic, strong) NFClusterAnnotationView *lastSelectedAnnotation;

//上一个放大的级别
@property (nonatomic, assign) CGFloat lastZoomLevel;
//上一个中心点
@property (nonatomic, assign) CLLocationCoordinate2D lastCenter;

@property (nonatomic, strong) NFCoordinateQuadTree *coordinateQuadTree;
//判断区域位置有没有发生改变
@property (nonatomic, assign) BOOL shouldRegionChangeReCalculate;

@property (nonatomic, strong) NSMutableArray *models;


@end


static NSString *const reusedAnnotationViewId = @"reusedAnnotationViewId";
@implementation NFShopViewController

- (NSMutableArray *)models{
    if (_models == nil) {
        _models = [NSMutableArray array];
    }
    return _models;
}


- (NSMutableArray *)annotations{
    if (_annotations == nil) {
        _annotations = [NSMutableArray array];
    }
    return _annotations;
}

- (NFCoordinateQuadTree *)coordinateQuadTree{
    if (_coordinateQuadTree == nil) {
        _coordinateQuadTree = [[NFCoordinateQuadTree alloc] init];
    }
    return _coordinateQuadTree;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NFShopModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"shopModelId":@"id"};
    }];
    
    [self requestData];
    [self configureContent];
    
}

#pragma mark 设置内容
- (void)configureContent{
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _mapView.showsUserLocation = YES;
    [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    _mapView.delegate = self;
    _mapView.showsScale = NO;
    _mapView.showsCompass = NO;
    _mapView.rotateCameraEnabled = NO;
    [self.view addSubview:_mapView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
#warning TODO 修改了y 向下移动了64
    button.frame = CGRectMake(10, kScreenHeight - 160 - 10 - 40, 40, 40);
    [button addTarget:self action:@selector(findMe) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"location_"] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    _popView = [[[NSBundle mainBundle] loadNibNamed:@"NFPopView" owner:nil options:nil] lastObject];
    _popView.frame = CGRectMake(0, kScreenHeight - 160, kScreenWidth, 160);
    _popView.hidden = YES;
    _popView.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [_popView addGestureRecognizer:tap];
    [self.view addSubview:_popView];
}

#pragma mark popView 的点击事件
- (void)tapAction{
    NFShopDetailViewController *shopDetailVc = [[NFShopDetailViewController alloc] init];
    [self.navigationController pushViewController:shopDetailVc animated:YES];

}


#pragma mark 设置自己为中心
- (void)findMe{
    
    [_mapView setCenterCoordinate:_userLocation.coordinate animated:YES];
}

#pragma mark 打开滴滴
- (void)openDiDi{
    [DIOpenSDK showDDPage:self animated:YES params:nil delegate:nil];

}



#pragma mark 地图定位方法
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    if (updatingLocation) {
        _userLocation = userLocation.location;
        //请求数据
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            MACoordinateSpan span = MACoordinateSpanMake(0.031725, 0.020614);
            MACoordinateRegion  region = MACoordinateRegionMake(_userLocation.coordinate, span);
            [_mapView setRegion:region animated:YES];
        });

    }
    
}
#pragma mark 请求数据
- (void)requestData{
    NSString *url = kShopURL;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code"] = @"0575";
//    parameters[@"lon"] = @(_userLocation.coordinate.longitude);
//    parameters[@"lat"] = @(_userLocation.coordinate.latitude);
    parameters[@"lat"] = @(30.098319);
    parameters[@"lon"] = @(120.503840);
    parameters[@"index"] = @0;
    [NFUtils getDataWithBaseURL:url parameters:parameters block:^(id responseObject) {
        if (responseObject) {
            NSArray *array = responseObject[@"data"];
            for (NSDictionary *dict in array) {
                NFShopModel *model = [NFShopModel mj_objectWithKeyValues:dict];
//                NFAnnotation *annotation = [[NFAnnotation alloc] init];
//                annotation.title = model.name;
//                annotation.subtitle = model.address;
//                annotation.shopModel = model;
//                annotation.coordinate = CLLocationCoordinate2DMake([dict[@"lat"] doubleValue], [dict[@"lon"] doubleValue]);
//                [self.annotations addObject:annotation];
                [self.models addObject:model];
            }
//            [_mapView addAnnotations:_annotations];
            
            if (self.models == nil) {
                return;
            }
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                [self.coordinateQuadTree buildTreeWithModels:self.models];
                
                self.shouldRegionChangeReCalculate = YES;
                
                [self addAnnotationToMapView:_mapView];
                
            });

            
            
        }
        
    }];
    
}

#pragma mark 添加大头针模型
- (void)addAnnotationToMapView:(MAMapView *)mapView{
    @synchronized (self) {
        if (self.coordinateQuadTree.root == nil || !self.shouldRegionChangeReCalculate ) {
            return;
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            /* 根据当前zoomLevel和zoomScale 进行annotation聚合. */
            double zoomScale = self.mapView.bounds.size.width / self.mapView.visibleMapRect.size.width;
            
            NSArray *annotations = [self.coordinateQuadTree clusteredAnnotationsWithinMapRect:mapView.visibleMapRect
                                                                                withZoomScale:zoomScale
                                                                                 andZoomLevel:mapView.zoomLevel];
            
            
            /* 更新annotation. */
            [self updateMapViewAnnotationsWithAnnotations:annotations];
        });
    }
}

#pragma mark 更新大头针视图
- (void)updateMapViewAnnotationsWithAnnotations:(NSArray *)annotations{
    /* 用户滑动时，保留仍然可用的标注，去除屏幕外标注，添加新增区域的标注 */
    NSMutableSet *before = [NSMutableSet setWithArray:self.mapView.annotations];
    [before removeObject:[self.mapView userLocation]];
    NSSet *after = [NSSet setWithArray:annotations];
    
    /* 保留仍然位于屏幕内的annotation. */
    NSMutableSet *toKeep = [NSMutableSet setWithSet:before];
    [toKeep intersectSet:after];
    
    /* 需要添加的annotation. */
    NSMutableSet *toAdd = [NSMutableSet setWithSet:after];
    [toAdd minusSet:toKeep];
    
    /* 删除位于屏幕外的annotation. */
    NSMutableSet *toRemove = [NSMutableSet setWithSet:before];
    [toRemove minusSet:after];
    
    /* 更新. */
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mapView addAnnotations:[toAdd allObjects]];
        [self.mapView removeAnnotations:[toRemove allObjects]];
    });

}

#pragma mark 设置大头针视图
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    
//    if ([annotation isKindOfClass:[NFAnnotation class]]) {
//        NFAnnotation *anno = (NFAnnotation *)annotation;
//        NFShopModel *shopModel = anno.shopModel;
//        
//        NFAnnotationView *annotationView = (NFAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reusedAnnotationViewId];
//        if (annotationView == nil) {
//            annotationView = [[NFAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reusedAnnotationViewId];
//        }
//        annotationView.shopModel = shopModel;
//        //        annotationView.canShowCallout = YES;
//        annotationView.image = [UIImage imageNamed:@"map_store1"];
//        annotationView.centerOffset = CGPointMake(0, -18);
//        return annotationView;
//    }
    
    if([annotation isKindOfClass:[NFClusterAnnotation class]]){
        NFClusterAnnotationView *annotationView = (NFClusterAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reusedAnnotationViewId];
        if (annotationView == nil) {
            annotationView = [[NFClusterAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reusedAnnotationViewId];
        }
        annotationView.annotation = annotation;
        annotationView.image = [UIImage imageNamed:@"map_store1"];
        annotationView.count = [(NFClusterAnnotation *)annotation count];
        annotationView.canShowCallout = NO;
        
        return annotationView;
    }
    
    return nil;
}

#pragma mark 当地图region发生改变时，重新添加大头针模型
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
    [self addAnnotationToMapView:self.mapView];
}

#pragma mark 通过中心和当前的放大级别请求数据
//- (void)requestData:(CLLocationCoordinate2D)center zoomLevel:(CGFloat)zoomLevel{
//    
//    NSString *url = kShopURL;
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    parameters[@"code"] = @"0575";
//    parameters[@"lon"] = @(center.longitude);
//    parameters[@"lat"] = @(center.latitude);
//    if (zoomLevel == 0 || zoomLevel == _lastZoomLevel) {
//       parameters[@"index"] = @0;
//    }else if (_lastZoomLevel < zoomLevel){
//        return;
//    }else if (_lastZoomLevel > zoomLevel){
//        parameters[@"index"] = @2;
//    }
//    [NFUtils getDataWithBaseURL:url parameters:parameters block:^(id responseObject) {
//        if (responseObject) {
//            NSArray *array = responseObject[@"data"];
//            for (NSDictionary *dict in array) {
//                NFShopModel *model = [NFShopModel mj_objectWithKeyValues:dict];
//                NFAnnotation *annotation = [[NFAnnotation alloc] init];
//                annotation.title = model.name;
//                annotation.subtitle = model.address;
//                annotation.shopModel = model;
//                annotation.coordinate = CLLocationCoordinate2DMake([dict[@"lat"] doubleValue], [dict[@"lon"] doubleValue]);
//                [self.annotations addObject:annotation];
//            }
//            [_mapView addAnnotations:_annotations];
//        }
//        
//    }];
//    
//}

#pragma mark 大头针视图的选中和底部视图的弹出
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{

//    if ([view isKindOfClass:[NFAnnotationView class]]) {
//        _lastSelectedAnnotation = (NFAnnotationView *)view;
//        _lastSelectedAnnotation.image = [UIImage imageNamed:@"map_store2"];
//        _popView.hidden = NO;
//        
//    }
    
    if([view isKindOfClass:[NFClusterAnnotationView class]]){
        NFClusterAnnotationView *clusterAnnotationView = (NFClusterAnnotationView *)view;
        if (clusterAnnotationView.count != 1) {
            [_mapView setZoomLevel:(self.mapView.zoomLevel +1) atPivot:self.mapView.center animated:YES];
            [_mapView deselectAnnotation:clusterAnnotationView.annotation animated:YES];
            return;
        }else{
            _lastSelectedAnnotation = clusterAnnotationView;
            _lastSelectedAnnotation.image = [UIImage imageNamed:@"map_store2"];
            _popView.hidden = NO;
            
        }
    }
}

- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view{
    if (_popView.hidden == NO) {
        _popView.hidden = YES;
        _lastSelectedAnnotation.image = [UIImage imageNamed:@"map_store1"];
    }

}


#pragma mark 地图的移动

//- (void)mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction{
//    CLLocationCoordinate2D center = [mapView convertPoint:self.view.center toCoordinateFromView:self.view];
//    [self.annotations removeAllObjects];
//    [self requestData:center zoomLevel:_lastZoomLevel];
//}
#pragma mark 地图的放大和缩小
//- (void)mapView:(MAMapView *)mapView mapDidZoomByUser:(BOOL)wasUserAction{
//    CGFloat zoomLevel = mapView.zoomLevel;
//    [self requestData:_lastCenter zoomLevel:zoomLevel];
//    _lastZoomLevel = zoomLevel;
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
