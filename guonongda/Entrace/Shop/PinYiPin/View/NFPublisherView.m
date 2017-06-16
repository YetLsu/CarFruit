//
//  NFPublisherView.m
//  guonongda
//
//  Created by guest on 16/11/4.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFPublisherView.h"

@implementation NFPublisherView


- (void)awakeFromNib{
    self.width = kScreenWidth;
    self.publisherImageView.layer.cornerRadius = self.publisherImageView.height/2;
    self.publisherImageView.layer.masksToBounds = YES;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
