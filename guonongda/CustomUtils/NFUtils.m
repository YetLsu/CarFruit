//
//  NFUtils.m
//  fram
//
//  Created by guest on 16/7/15.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFUtils.h"
#import "AppDelegate.h"
#import "NFNetWorkManager.h"
#import <AMapLocationKit/AMapLocationKit.h>

@implementation NFUtils
+ (AppDelegate *)getAppDelegate{
   return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

+ (UIAlertController *)creatAlertWithMessage:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    return alert;
}

//+ (CLLocation *)getCurrentLocation{
//
//    return [self getAppDelegate].location;
//}
//
//+ (AMapLocationReGeocode *)getRegeo{
//    return [self getAppDelegate].regeocode;
//}

//+ (NSString *)getCityCode{
//   return [[self getRegeo] citycode];
//}
//
//+ (CLLocationDegrees)getlat{
//    return [[self getCurrentLocation] coordinate].latitude;
//}
//
//+ (CLLocationDegrees)getlon{
//    return [[self getCurrentLocation] coordinate].longitude;
//}

//+ (UIAlertView *)createAlterViewWithMessage:(NSString *)message{
//    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
//    [alterView show];
//    return alterView;
//}

//获取当前时间
+ (NSString *)getCurrentTime{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dataFormatter stringFromDate:localeDate];
    return currentDateStr;
}


+ (CLLocation *)getLocationWithLat:(NSString *)lat lon:(NSString *)lon{
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[lat doubleValue] longitude:[lon doubleValue]];
    
    return location;
}


+ (void)getDataWithBaseURL:(NSString *)baseUrl parameters:(NSMutableDictionary *)parameters block:(DataBlock)block{
    AFHTTPSessionManager *manager = [[NFNetWorkManager shareNetWorkManager] manager];
    [manager GET:baseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            block(nil);
        }
    }];
}

+ (void)postDataWithBaseURL:(NSString *)baseUrl parameters:(NSMutableDictionary *)parameters block:(DataBlock)block{
    AFHTTPSessionManager *manager = [[NFNetWorkManager shareNetWorkManager] manager];
    [manager POST:baseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            block(nil);
        }
    }];
}

+ (void)postMutipleRequestWithBaseURL:(NSString *)baseUrl parameters:(NSDictionary *)parameters block:(DataBlock)block{
    NSArray *keys = [parameters allKeys];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:baseUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (int i = 0; i < keys.count; i++) {
            [formData appendPartWithFormData:[[parameters objectForKey:keys[i]] dataUsingEncoding:NSUTF8StringEncoding] name:keys[i]];
        }
    } error:nil];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            block(@"error");
        }else{
            block(responseObject);
        }
    }] resume];
}

//+ (void)getRegeoCoderWithLocation:(CLLocation *)location block:(LocationBlock)geoBlock{
//    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
//    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        CLPlacemark *placemark = [placemarks firstObject];
//        geoBlock(placemark);
//    }];
//}

- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10 * 中国移动：China Mobile
     11 * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12 */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15 * 中国联通：China Unicom
     16 * 130,131,132,152,155,156,185,186
     17 */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20 * 中国电信：China Telecom
     21 * 133,1349,153,180,189
     22 */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25 * 大陆地区固话及小灵通
     26 * 区号：010,020,021,022,023,024,025,027,028,029
     27 * 号码：七位或八位
     28 */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//以上集合一起，并兼容14开头的
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    NSString * phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [regextestmobile evaluateWithObject:mobileNum];
}




@end
