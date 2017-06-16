//
//  NFShopDetailHeaderView.h
//  guonongda
//
//  Created by guest on 16/9/19.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NFShopDetailHeaderViewDelegate <NSObject>

- (void)pinClick;
@end


@interface NFShopDetailHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopShortIntruLabel;
@property (nonatomic, assign) id<NFShopDetailHeaderViewDelegate> delegate;
@end
