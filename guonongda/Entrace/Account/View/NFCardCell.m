//
//  NFCardCell.m
//  guonongda
//
//  Created by guest on 16/10/10.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFCardCell.h"
#define kCellMargin 15
@implementation NFCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setFrame:(CGRect)frame{
    frame.size.height -= kCellMargin;
    frame.size.width = kScreenWidth - 2*kCellMargin;
    frame.origin.x = kCellMargin;
    frame.origin.y += kCellMargin;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
