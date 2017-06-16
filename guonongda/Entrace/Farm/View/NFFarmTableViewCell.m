//
//  NFFarmTableViewCell.m
//  guonongda
//
//  Created by guest on 16/9/14.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFFarmTableViewCell.h"

@interface NFFarmTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *hotImageView;

@property (weak, nonatomic) IBOutlet UIImageView *farmImageView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *farmNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *discreptionLabel;

@property (weak, nonatomic) IBOutlet UIView *wrapperView;

@end


@implementation NFFarmTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _wrapperView.layer.cornerRadius = 3;
    _wrapperView.layer.masksToBounds = YES;
    _farmNameLabel.textColor = kBaseColor;
    _priceLabel.textColor = kPriceColor;
    _discreptionLabel.textColor = [UIColor colorWithHexString:@"999999"];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
