//
//  NFGiftCell.m
//  guonongda
//
//  Created by guest on 16/10/10.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFGiftCell.h"
#define kCellMargin 15

@interface NFGiftCell ()
@property (weak, nonatomic) IBOutlet UILabel *leftPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightPriceLabel;


@end

@implementation NFGiftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _leftPriceLabel.textColor = [UIColor colorWithHexString:@"#c34239"];
}

- (void)setFrame:(CGRect)frame{
//    NSLog(@"frame");
    frame.size.height -= kCellMargin;
    frame.size.width = kScreenWidth - 2*kCellMargin;
    frame.origin.x = kCellMargin;
    frame.origin.y += kCellMargin;
    [super setFrame:frame];
}
- (IBAction)exchangeAction:(UIButton *)sender {
    
    NSLog(@"exchange");
    if ([self.delegate respondsToSelector:@selector(cell:exchangeWithPrice:)]) {
        [self.delegate performSelector:@selector(cell:exchangeWithPrice:) withObject:self withObject:self.leftPriceLabel.text];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
