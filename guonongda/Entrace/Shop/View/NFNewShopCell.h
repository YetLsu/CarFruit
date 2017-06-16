//
//  NFNewShopCell.h
//  guonongda
//
//  Created by guest on 16/9/20.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NFNewShopCell;
@protocol NFNewShopCellDelegate <NSObject>

- (void)deleteThePhotoFromCell:(NFNewShopCell *)shopCell;

@end


@interface NFNewShopCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *shopImageView;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, assign) id<NFNewShopCellDelegate> delegate;
@end
