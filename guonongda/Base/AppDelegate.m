//
//  AppDelegate.m
//  guonongda
//
//  Created by guest on 16/8/29.
//  Copyright © 2016年 聂凡. All rights reserved.
//
#import "AppDelegate.h"
#import "NFNaviController.h"
#import "NFViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "Pingpp.h"
#import <SMS_SDK/SMSSDK.h>
#import <DIOpenSDK/DIOpenSDK.h>
#import "WXApi.h"
@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [AMapServices sharedServices].apiKey = kMapApikey;
    //初始化应用，appKey和appSecret从后台申请得
    [SMSSDK registerApp:kMobSMSAppKey
             withSecret:kMobSMSAppSecret];
    //注册滴滴SDK
    [DIOpenSDK registerApp:kDiDiAppId secret:kDiDiSecret];
    [WXApi registerApp:kWXAppId];
    
    NFViewController *vc = [[NFViewController alloc] init];
    NFNaviController *navi = [[NFNaviController alloc] initWithRootViewController:vc];
    self.window.rootViewController = navi;
    
#ifdef DEBUG
    [Pingpp setDebugMode:YES];
#else
    [Pingpp setDebugMode:NO];
#endif
    
    return YES;
}

#warning 与分享有冲突时可以判断url的host
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}

// iOS 8 及以下请用这个
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    NSLog(@"host:%@",url.host);
    return [WXApi handleOpenURL:url delegate:self];
//    return [Pingpp handleOpenURL:url withCompletion:nil];
}

// iOS 9 以上请用这个
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options {
    NSLog(@"host:%@",url.host);
    return [WXApi handleOpenURL:url delegate:self];
//    return [Pingpp handleOpenURL:url withCompletion:nil];
}

- (void)onResp:(BaseResp *)resp{
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d",resp.errCode];
    NSString *strTitle = @"支付结果";
    if ([resp isKindOfClass:[PayResp class]]) {
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                break;
            case WXErrCodeUserCancel:
                strMsg = @"支付结果：用户点击取消！！";
                break;
            case WXErrCodeSentFail:
                strMsg = @"支付结果：发送失败！";
                break;
            case WXErrCodeAuthDeny:
                strMsg = @"支付结果：授权失败！";
                break;
            default:
                strMsg = @"支付结果：微信不支持！";
                break;
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
