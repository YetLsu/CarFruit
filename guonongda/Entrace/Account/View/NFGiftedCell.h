//
//  NFGiftedCell.h
//  guonongda
//
//  Created by guest on 16/10/21.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NFGiftedCell;
@protocol NFGiftedCellDelegate <NSObject>

- (void)lookOverWithCell:(NFGiftedCell *)cell;

@end

@interface NFGiftedCell : UITableViewCell
@property (nonatomic, assign) id<NFGiftedCellDelegate> delegate;
@end
