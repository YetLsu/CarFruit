//
//  UIView+NFExtession.m
//  fram
//
//  Created by guest on 16/7/20.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "UIView+NFExtession.h"

@implementation UIView (NFExtession)

- (MBProgressHUD *)createHUD{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
//    hud.dimBackground = YES;
    hud.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
    [self addSubview:hud];
    [hud show:YES];
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

- (MBProgressHUD *)createHUDWithTitle:(NSString *)title{
    MBProgressHUD *hud = [self createHUD];
    hud.labelText = title;
    return hud;
}

- (MBProgressHUD *)createDimBackgroundHUD{
    MBProgressHUD *hud = [self createHUD];
    hud.dimBackground = YES;
    return hud;
}

- (MBProgressHUD *)createDimBackgroundHUDWithTitle:(NSString *)title{
    MBProgressHUD *hud = [self createHUDWithTitle:title];
    hud.labelText = title;
    return hud;

}

@end
