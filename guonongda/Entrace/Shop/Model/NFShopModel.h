//
//  NFShopModel.h
//  guonongda
//
//  Created by guest on 16/8/30.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NFShopModel : NSObject

@property (nonatomic, copy) NSString *shopModelId;
//店名
@property (nonatomic, copy) NSString *name;
//主图片
@property (nonatomic, copy) NSString *imgurl;
//图片
@property (nonatomic, copy) NSString *imglisturl;
//评分
@property (nonatomic, copy) NSString *grade;
//地址
@property (nonatomic, copy) NSString *address;
//电话
@property (nonatomic, copy) NSString *phone;
//营业时间
@property (nonatomic, copy) NSString *time;
//纬度
@property (nonatomic, copy) NSString *lat;
//精度
@property (nonatomic, copy) NSString *lon;
//城市名
@property (nonatomic, copy) NSString *cityname;
//距离
//@property (nonatomic, copy) NSString *juli;
@property (nonatomic, assign) NSInteger juli;
//收藏
@property (nonatomic, assign) NSInteger collectionnum;
//带单位的距离
@property (nonatomic, copy) NSString *distance;

@end
