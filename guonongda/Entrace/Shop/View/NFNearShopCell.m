//
//  NFNearShopCell.m
//  guonongda
//
//  Created by guest on 16/9/15.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFNearShopCell.h"
#import "RatingView.h"

@interface NFNearShopCell ()
@property (weak, nonatomic) IBOutlet UIView *wrapperView;
@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *giftLabel;
@property (weak, nonatomic) IBOutlet UIImageView *giftImageView;
@property (weak, nonatomic) IBOutlet RatingView *ratingView;


@end



@implementation NFNearShopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _wrapperView.layer.cornerRadius = 3;
    _wrapperView.layer.masksToBounds = YES;
    
}
- (void)setRating:(CGFloat)rating{
    _ratingView.rating = rating;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
