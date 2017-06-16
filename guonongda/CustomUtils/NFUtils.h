//
//  NFUtils.h
//  fram
//
//  Created by guest on 16/7/15.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <AMapLocationKit/AMapLocationKit.h>


typedef void (^DataBlock)(id responseObject);
//typedef void (^LocationBlock)(CLPlacemark *placemark);

@class AppDelegate;

@interface NFUtils : NSObject
@property (nonatomic, assign) DataBlock block;
//@property (nonatomic, assign) LocationBlock geoBlock;
//+ (AppDelegate *)getAppDelegate;
//获取当前时间
+ (NSString *)getCurrentTime;

//创建只有一个按钮的提示消息
+ (UIAlertController *)creatAlertWithMessage:(NSString *)message;

//检查手机号是否正确
+ (BOOL)isMobileNumber:(NSString *)mobileNum;


//根据经纬度获取地理位置
+ (CLLocation *)getLocationWithLat:(NSString *)lat lon:(NSString *)lon;


//+ (UIAlertView *)createAlterViewWithMessage:(NSString *)message;

//封装网络请求get请求
+ (void)getDataWithBaseURL:(NSString *)baseUrl parameters:(NSMutableDictionary *)parameters block:(DataBlock)block;
//封装网络请求post请求
+ (void)postDataWithBaseURL:(NSString *)baseUrl parameters:(NSMutableDictionary *)parameters block:(DataBlock)block;

//封装表单上传请求
+ (void)postMutipleRequestWithBaseURL:(NSString *)baseUrl parameters:(NSDictionary *)parameters block:(DataBlock)block;

@end
