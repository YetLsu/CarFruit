//
//  NFHotSearchCell.m
//  guonongda
//
//  Created by guest on 16/9/18.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFHotSearchCell.h"

@implementation NFHotSearchCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if (self) {
        
        [self setupContent];
        
    }
    return self;
}


- (void)setupContent{
    
    self.layer.cornerRadius = 12;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1;
    self.layer.borderColor = kBaseBackgroundColor.CGColor;
    
    _tagLabel = [[UILabel alloc] initWithFrame:self.contentView.frame];
    _tagLabel.font = [UIFont systemFontOfSize:13];
    _tagLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_tagLabel];
    
//    _tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _tagButton.frame = self.contentView.frame;
//    _tagButton.titleLabel.font = [UIFont systemFontOfSize:13];
//    [_tagButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.contentView addSubview:_tagButton];

}






@end
