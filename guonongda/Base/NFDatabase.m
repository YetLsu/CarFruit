//
//  NFDatabase.m
//  guonongda
//
//  Created by guest on 16/9/18.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFDatabase.h"
#import "FMDB.h"


@interface NFDatabase ()
@property (nonatomic, strong) FMDatabase *db;
@end


@implementation NFDatabase
- (instancetype)init{
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/fruit.db"];
    NSLog(@"%@",path);
    _db = [FMDatabase databaseWithPath:path];
    BOOL result = [_db open];
    if (!result) {
        NSLog(@"数据库打开失败！");
        return self;
    }
    result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_search(id integer PRIMARY KEY AUTOINCREMENT, tag TEXT)"];
    if (!result) {
        NSLog(@"建表失败！");
        [_db close];
        return self;
    }
    
    return self;
}

+ (instancetype)database{
    static NFDatabase *database = nil;
    if (database == nil) {
        database = [[self alloc] init];
    }
    return database;
}

- (BOOL)addSearchShopName:(NSString *)shopName{
    BOOL result = [_db executeUpdate:@"INSERT INTO t_search(tag) VALUES (?)",shopName];
    
    return result;
}

- (NSArray *)selectSearchHistory{
    NSMutableArray *array = [NSMutableArray array];
    FMResultSet *set = [_db executeQuery:@"SELECT * FROM t_search"];
    while ([set next]) {
        NSString *tag = [set objectForColumnName:@"tag"];
        [array addObject:tag];
    }
    return array;
}

- (BOOL)clearTableSearch{
    BOOL result = [_db executeUpdate:@"DELETE FROM t_search"];
    return result;
}




@end
