//
//  NFPopView.h
//  guonongda
//
//  Created by guest on 16/9/14.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NFPopViewDelegate <NSObject>

- (void)openDiDi;

@end


@interface NFPopView : UIView
@property (nonatomic, assign) id<NFPopViewDelegate> delegate;

@end
