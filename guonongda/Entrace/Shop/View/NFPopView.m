//
//  NFPopView.m
//  guonongda
//
//  Created by guest on 16/9/14.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFPopView.h"
#import "NFPersonRatingView.h"


@interface NFPopView ()
@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet NFPersonRatingView *ratingView;

@end


@implementation NFPopView

- (void)awakeFromNib{
    self.width = kScreenWidth;
    _shopNameLabel.textColor = kBaseColor;
}


- (IBAction)toShopByDD:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(openDiDi)]) {
        [self.delegate performSelector:@selector(openDiDi) withObject:nil];
    }
}


@end
