//
//  NFNetWorkManager.h
//  fram
//
//  Created by guest on 16/7/21.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFHTTPSessionManager;
@interface NFNetWorkManager : NSObject
@property (nonatomic, strong) AFHTTPSessionManager *manager;
+ (instancetype)shareNetWorkManager;

@end
