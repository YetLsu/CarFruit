//
//  NFPinNearCell.m
//  guonongda
//
//  Created by guest on 16/11/2.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFPinNearCell.h"

#define kCellMargin 15;
@interface NFPinNearCell ()
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UIImageView *userSexImageView;
@property (weak, nonatomic) IBOutlet UIImageView *pinTypeImageView;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIButton *pinButton;

@end


@implementation NFPinNearCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;
    _userImageView.layer.cornerRadius = _userImageView.height/2;
    _userImageView.layer.masksToBounds = YES;
}

- (void)setFrame:(CGRect)frame{
    frame.size.height -= kCellMargin;
    frame.size.width = kScreenWidth - 2*kCellMargin;
    frame.origin.x = kCellMargin;
    frame.origin.y += kCellMargin;
    [super setFrame:frame];
}

- (IBAction)pinAction:(UIButton *)sender {
    NSLog(@"pin");
    if ([self.delegate respondsToSelector:@selector(pinWithNearCell:)]) {
        [self.delegate performSelector:@selector(pinWithNearCell:) withObject:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
