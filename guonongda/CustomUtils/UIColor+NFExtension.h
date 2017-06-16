//
//  UIColor+NFExtension.h
//  fram
//
//  Created by guest on 16/7/4.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (NFExtension)

+ (instancetype)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

+ (instancetype)colorWithHexString:(NSString *)color;
@end
