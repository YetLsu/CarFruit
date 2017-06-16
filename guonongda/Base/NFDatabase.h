//
//  NFDatabase.h
//  guonongda
//
//  Created by guest on 16/9/18.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NFDatabase : NSObject

+ (instancetype)database;

- (BOOL)addSearchShopName:(NSString *)shopName;

- (BOOL)clearTableSearch;

- (NSArray *)selectSearchHistory;

@end
