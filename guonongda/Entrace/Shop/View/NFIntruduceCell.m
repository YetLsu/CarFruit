//
//  NFIntruduceCell.m
//  guonongda
//
//  Created by guest on 16/10/7.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFIntruduceCell.h"

@implementation NFIntruduceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.cellButton.imageEdgeInsets = UIEdgeInsetsMake(0, 45, 0, 0);
    self.cellButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 25);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
