//
//  NFPinNearCell.h
//  guonongda
//
//  Created by guest on 16/11/2.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NFPinNearCell;
@protocol NFPinNearCellDelegate <NSObject>

- (void)pinWithNearCell:(NFPinNearCell *)cell;

@end


@interface NFPinNearCell : UITableViewCell
@property (nonatomic, assign) id<NFPinNearCellDelegate> delegate;


@end
