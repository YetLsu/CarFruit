//
//  NFCityCell.m
//  guonongda
//
//  Created by guest on 16/10/12.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFCityCell.h"

@implementation NFCityCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _cityLabel = [[UILabel alloc] initWithFrame:self.contentView.frame];
        _cityLabel.textAlignment = NSTextAlignmentCenter;
        _cityLabel.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:_cityLabel];
    }
    return self;
}

- (void)setCity:(NSString *)city{
    if (_city != city) {
        _city = city;
    }
    _cityLabel.text = _city;

}

@end
