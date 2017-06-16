//
//  NFGiftedCell.m
//  guonongda
//
//  Created by guest on 16/10/21.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFGiftedCell.h"
#define kCellMargin 15
@implementation NFGiftedCell
- (IBAction)lookOverAction:(UIButton *)sender {
    NSLog(@"look over");
    if ([self.delegate respondsToSelector:@selector(lookOverWithCell:)]) {
        [self.delegate performSelector:@selector(lookOverWithCell:) withObject:self];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setFrame:(CGRect)frame{
    //    NSLog(@"frame");
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
