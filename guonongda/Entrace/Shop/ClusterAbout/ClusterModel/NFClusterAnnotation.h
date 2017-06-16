//
//  NFClusterAnnotation.h
//  guonongda
//
//  Created by guest on 16/9/26.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NFClusterAnnotation : NSObject

@property (assign, nonatomic) CLLocationCoordinate2D coordinate; //poi的平均位置
@property (assign, nonatomic) NSInteger count;
//@property (nonatomic, strong) NSMutableArray *pois;
@property (nonatomic, strong) NSMutableArray *models;
//@property (nonatomic, strong) NSString *title;
//@property (nonatomic, strong) NSString *subtitle;


- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate count:(NSInteger)count;


@end
