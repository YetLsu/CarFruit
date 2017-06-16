//
//  NFPersonRatingView.m
//  guonongda
//
//  Created by guest on 16/9/15.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFPersonRatingView.h"

@interface NFPersonRatingView ()
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *midView;
@property (nonatomic, strong) UIView *foreView;
@end


@implementation NFPersonRatingView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupContent];
    }
    return self;
}

- (void)awakeFromNib{
    [self setupContent];
}

- (void)setupContent{
    UIImage *botImage = [UIImage imageNamed:@"shop_rate"];
    UIImage *midImage = [UIImage imageNamed:@"m6~"];
    UIImage *foreImage = [UIImage imageNamed:@"f6~"];
    
    CGFloat imageWidth = botImage.size.width;
    CGFloat imageHeight = botImage.size.height;
    
    
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, imageWidth*10, imageHeight)];
    _bottomView.backgroundColor = [UIColor colorWithPatternImage:botImage];
    [self addSubview:_bottomView];
    
    _midView = [[UIView alloc] initWithFrame:_bottomView.frame];
    _midView.backgroundColor = [UIColor colorWithPatternImage:midImage];
    [self addSubview:_bottomView];
    
    _foreView = [[UIView alloc] initWithFrame:_bottomView.frame];
    _foreView.backgroundColor = [UIColor colorWithPatternImage:foreImage];
    [self addSubview:_foreView];
    

    CGFloat scale = CGRectGetHeight(self.frame)/imageHeight;

    CGAffineTransform newTransform = CGAffineTransformMakeScale(scale, scale);

    _bottomView.transform = newTransform;
    _midView.transform = newTransform;
    _foreView.transform = newTransform;
    
    CGRect bottomRect = _bottomView.frame;
    bottomRect.origin = CGPointMake(0, 0);
    _bottomView.frame = bottomRect;
    
    CGRect midRect = _midView.frame;
    midRect.origin = CGPointMake(0, 0);
    _midView.frame = midRect;
    
    CGRect foreRect = _foreView.frame;
    foreRect.origin = CGPointMake(0, 0);
    _foreView.frame = foreRect;
    
    CGRect selfFrame = self.frame;
    selfFrame.size.width = CGRectGetWidth(_bottomView.frame);
    self.frame = selfFrame;
}

- (void)showVolumeRating:(CGFloat)vRating menRatingToWomen:(CGFloat)mRating{
    CGRect frame = _bottomView.frame;
    frame.size.width = (vRating / 10.0) * frame.size.width;
    _midView.frame = frame;
    frame.size.width = (mRating/10.0)*frame.size.width;
    _bottomView.frame = frame;

}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
