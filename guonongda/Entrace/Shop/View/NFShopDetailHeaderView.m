//
//  NFShopDetailHeaderView.m
//  guonongda
//
//  Created by guest on 16/9/19.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFShopDetailHeaderView.h"

@interface NFShopDetailHeaderView ()


@end
@implementation NFShopDetailHeaderView

- (void)awakeFromNib{
    self.width = kScreenWidth;
}


- (IBAction)pinAction:(UIButton *)sender {
    NSLog(@"pin");
    if([self.delegate respondsToSelector:@selector(pinClick)]){
        [self.delegate performSelector:@selector(pinClick)];
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
