//
//  NFTimeView.m
//  guonongda
//
//  Created by guest on 16/11/4.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFTimeView.h"

#define kDefaultTime 60
@interface NFTimeView ()
@property (nonatomic, assign) CGFloat allTime;
@end
@implementation NFTimeView

- (void)setTime:(CGFloat)time{
    if (_time != time) {
        _time = time;
    }
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 2);
    CGFloat rectX = rect.origin.x;
    CGFloat rectY = rect.origin.y;
    CGFloat rectCenterX = rectX + rect.size.width/2;
    CGFloat rectCenterY = rectY + rect.size.height/2;
    CGMutablePathRef path1 = CGPathCreateMutable();
    CGPathAddEllipseInRect(path1, NULL, CGRectMake(1, 1, rect.size.width - 2, rect.size.height - 2));
    [kBaseColor setStroke];
    CGContextAddPath(ctx, path1);
    CGContextStrokePath(ctx);
    CGPathRelease(path1);

    CGFloat radius = (rect.size.width - 20)/2;
    CGContextAddArc(ctx, rectCenterX, rectCenterY, radius, 0, (_time/kDefaultTime)*2*M_PI, NO);
    [[UIColor redColor] setStroke];
    
    CGContextStrokePath(ctx);
    
    
}




@end
