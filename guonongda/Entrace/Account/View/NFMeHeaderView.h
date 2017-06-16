//
//  NFMeHeaderView.h
//  guonongda
//
//  Created by guest on 16/9/27.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NFMeHeaderViewDelegate <NSObject>

- (void)itemClickAction:(NSNumber *)tag;

- (void)accountClickAction;

@end


@interface NFMeHeaderView : UIView

@property (nonatomic, strong) UIImageView *userImageView;
@property (nonatomic, strong) UIImageView *userSexImageView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, assign) id<NFMeHeaderViewDelegate> delegate;
@end
