//
//  NFItemButton.h
//  fram
//
//  Created by guest on 16/7/4.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NFItemButton : UIControl
/**设置图片*/
- (void)setItemImage:(UIImage *)image
     forControlState:(UIControlState)state;
/** 设置标题*/
- (void)setItemTitle:(NSString *)title
withSpecialTextColor:(UIColor *)color;
/** 设置标题字体*/
- (void)setItemTitleFont:(CGFloat)size;
- (void)setItemTitle:(NSString *)title;
- (void)setItemTitleColor:(UIColor *)color;


@end
