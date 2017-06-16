//
//  NFNewShopCell.m
//  guonongda
//
//  Created by guest on 16/9/20.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFNewShopCell.h"

@implementation NFNewShopCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if (self) {
        [self setupContent];
    }
    return self;
}

- (void)setupContent{
    self.backgroundColor = [UIColor colorWithHexString:@"#e8e8e8"];
    _shopImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self.contentView addSubview:_shopImageView];
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteBtn.frame = CGRectMake(self.width - 20, 0, 20, 20);
    [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"add_delet"] forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(delegateAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_deleteBtn];
}

- (void)delegateAction{
    if ([self.delegate respondsToSelector:@selector(deleteThePhotoFromCell:)]) {
        [self.delegate performSelector:@selector(deleteThePhotoFromCell:) withObject:self];
    }
}

@end
