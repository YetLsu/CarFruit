//
//  NFCodeView.m
//  guonongda
//
//  Created by guest on 16/10/21.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFCodeView.h"

@interface NFCodeView ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *codeConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cpButtonLeftConstraint;

@end

@implementation NFCodeView

- (void)awakeFromNib{
    self.width = kScreenWidth - 30;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.cpButton.layer.cornerRadius = 3;
    self.cpButton.layer.masksToBounds = YES;
    self.cpButton.backgroundColor = [UIColor colorWithHexString:@"#c34239"];
    CGFloat width = _codeLabel.width + _cpButton.width;
    CGFloat margin = (self.width - width)/3;
    _codeConstraint.constant = margin;
    _cpButtonLeftConstraint.constant = margin;
}

- (IBAction)copAction:(UIButton *)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.codeLabel.text;
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
    hud.labelText = @"复制成功";
    [hud show:YES];
   
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
