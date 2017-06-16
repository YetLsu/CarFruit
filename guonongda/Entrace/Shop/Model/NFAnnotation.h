//
//  NFAnnotation.h
//  guonongda
//
//  Created by guest on 16/8/30.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
@class NFShopModel;

@interface NFAnnotation : MAPointAnnotation
@property (nonatomic, strong) NFShopModel *shopModel;
@property (nonatomic, assign) BOOL isOpen;

@end
