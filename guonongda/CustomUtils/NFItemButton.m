//
//  NFItemButton.m
//  fram
//
//  Created by guest on 16/7/4.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFItemButton.h"

@interface NFItemButton (){
    UIImageView *_itemImageView;
    UILabel *_itemTitleLabel;
}
@end

@implementation NFItemButton
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}
- (void)setupSubViews{
    CGFloat itemW = CGRectGetWidth(self.frame);
    //设置图片视图
    _itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake((itemW - 40)/2, 0, 40, 40)];
    _itemImageView.contentMode = UIViewContentModeScaleAspectFit;
//    _itemImageView.contentMode = UIViewContentModeCenter;
    [self addSubview:_itemImageView];
    
    //设置标题
    _itemTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_itemImageView.frame), itemW, 24)];
    _itemTitleLabel.textAlignment = NSTextAlignmentCenter;
//    _itemTitleLabel.font = [UIFont systemFontOfSize: 10];
//    _itemTitleLabel.textColor = [UIColor colorWithHexString:@"#bababa"];
    [self addSubview:_itemTitleLabel];
}

/**设置图片*/
- (void)setItemImage:(UIImage *)image
     forControlState:(UIControlState)state{
    if (state == UIControlStateNormal) {
        _itemImageView.image = image; // 普通状态下的图片
    } else if (state == UIControlStateSelected) {
        _itemImageView.highlightedImage = image;  // 特殊状态下的图片
    }

}
/** 设置标题*/
- (void)setItemTitle:(NSString *)title
withSpecialTextColor:(UIColor *)color{
    _itemTitleLabel.text = title;
    _itemTitleLabel.highlightedTextColor = color;
}

- (void)setSelected:(BOOL)selected {
    
    [super setSelected:selected];
    
    // 当按钮被选中的时候，切换子视图的状态
    _itemImageView.highlighted = selected;
    _itemTitleLabel.highlighted = selected;
    
}

- (void)setItemTitleFont:(CGFloat)size{
    _itemTitleLabel.font = [UIFont systemFontOfSize:size];

}
- (void)setItemTitle:(NSString *)title{
    _itemTitleLabel.text = title;
}
- (void)setItemTitleColor:(UIColor *)color{
    [_itemTitleLabel setTextColor:color];
}

@end
