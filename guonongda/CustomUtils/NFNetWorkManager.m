//
//  NFNetWorkManager.m
//  fram
//
//  Created by guest on 16/7/21.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFNetWorkManager.h"
#import "AFURLSessionManager.h"
@implementation NFNetWorkManager

+ (instancetype)shareNetWorkManager{
    
    static NFNetWorkManager *netWorkManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netWorkManager = [[NFNetWorkManager alloc] init];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        //设置请求超时时间
        manager.requestSerializer.timeoutInterval = 10;
        netWorkManager.manager = manager;
    });
    return netWorkManager;
}

@end
