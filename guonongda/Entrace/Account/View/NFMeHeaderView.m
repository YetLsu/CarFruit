//
//  NFMeHeaderView.m
//  guonongda
//
//  Created by guest on 16/9/27.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFMeHeaderView.h"
#import "NFItemButton.h"

#define kUserImageViewWidth 55

@implementation NFMeHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupContent];
    }
    return self;
}

- (void)setupContent{
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"person_banner_bg"]];
    CGFloat selfWidth = self.frame.size.width;
    _userImageView = [[UIImageView alloc] initWithFrame:CGRectMake((selfWidth - kUserImageViewWidth)/2, 79, kUserImageViewWidth, kUserImageViewWidth)];
    _userImageView.layer.cornerRadius = kUserImageViewWidth/2;
    _userImageView.layer.masksToBounds = YES;
    _userImageView.layer.borderWidth = 2;
    _userImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _userImageView.contentMode = UIViewContentModeScaleAspectFill;
    _userImageView.image = [UIImage imageNamed:@"1.jpg"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginOrSetting)];
    [_userImageView addGestureRecognizer:tap];
    _userImageView.userInteractionEnabled = YES;
    [self addSubview:_userImageView];
    
    _userSexImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_userImageView.right-13, _userImageView.bottom - 13, 13, 13)];
    _userSexImageView.image = [UIImage imageNamed:@"person_SEX_M"];
    [self addSubview:_userSexImageView];
    
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake((selfWidth - 200)/2, _userImageView.bottom + 15, 200, 20)];
    _userNameLabel.font = [UIFont systemFontOfSize:15];
    _userNameLabel.textAlignment = NSTextAlignmentCenter;
    _userNameLabel.text = @"登录／注册";
    _userNameLabel.textColor = [UIColor whiteColor];
    [self addSubview:_userNameLabel];
    
//    底下三个按钮
    
    NSArray *titles = @[@"扫一扫",@"卡券",@"拼一拼"];
    NSArray *imageNames = @[@"person_pin",@"person_card",@"person_sao"];
    
    CGFloat margin = (kScreenWidth - 3*80)/4;
    CGFloat btnW = 80;
    CGFloat btnH = 64;
    for (int i = 0; i < 3; i++) {
        NFItemButton *button = [[NFItemButton alloc] initWithFrame:CGRectMake(margin + (margin + btnW)*i, _userNameLabel.bottom + 15, btnW, btnH)];
        
        [button setItemTitle:titles[i]];
        [button setItemTitleFont:16];
        [button setItemTitleColor:[UIColor whiteColor]];
        [button setItemImage:[UIImage imageNamed: imageNames[i]] forControlState:UIControlStateNormal];
        [button addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [self addSubview:button];
        
    }
    

}

- (void)itemClick:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(itemClickAction:)]) {
        [self.delegate performSelector:@selector(itemClickAction:) withObject:@(button.tag)];
    }
}

- (void)loginOrSetting{
    if ([self.delegate respondsToSelector:@selector(accountClickAction)]) {
        [self.delegate performSelector:@selector(accountClickAction) withObject:nil];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
