//
//  NFGiftCell.h
//  guonongda
//
//  Created by guest on 16/10/10.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NFGiftCell;
@protocol NFGiftCellDelegate <NSObject>

- (void)cell:(NFGiftCell *)cell exchangeWithPrice:(NSString *)price;

@end

@interface NFGiftCell : UITableViewCell
@property (nonatomic, assign) id<NFGiftCellDelegate> delegate;
@end
