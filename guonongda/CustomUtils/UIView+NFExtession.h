//
//  UIView+NFExtession.h
//  fram
//
//  Created by guest on 16/7/20.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NFExtession)

//不带文字的加载
- (MBProgressHUD *)createHUD;
//带文字，带菊花圈的加载
- (MBProgressHUD *)createHUDWithTitle:(NSString *)title;
//带黑色背景的菊花圈加载
- (MBProgressHUD *)createDimBackgroundHUD;
//带黑色背景,带文字的菊花圈加载
- (MBProgressHUD *)createDimBackgroundHUDWithTitle:(NSString *)title;
@end
