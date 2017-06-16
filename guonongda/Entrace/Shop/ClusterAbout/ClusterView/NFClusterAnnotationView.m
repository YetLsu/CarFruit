//
//  NFClusterAnnotationView.m
//  guonongda
//
//  Created by guest on 16/9/26.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFClusterAnnotationView.h"

@implementation NFClusterAnnotationView{
    UILabel *_countLabel;

}
- (instancetype)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupContent];
    }
    return self;
}


- (void)setupContent{

    _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 23, 25)];
    
//    _countLabel.center = self.center;
    _countLabel.textColor = kBaseColor;
    _countLabel.font = [UIFont systemFontOfSize:13];
    _countLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_countLabel];
    
}

- (void)setCount:(NSUInteger)count{
    if (_count != count) {
        _count = count;
    }
    if (_count == 1) {
        _countLabel.text = nil;
        self.image = [UIImage imageNamed:@"map_store1"];
    }else{
        self.image = [UIImage imageNamed:@"map_store_bg1"];
        _countLabel.text = [@(count) stringValue];
    }
    [self setNeedsDisplay];
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    
    //添加动画
    [self addBounceAnnimation];
}

- (void)addBounceAnnimation{
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    bounceAnimation.values = @[@(0.05), @(1.1), @(0.9), @(1)];
    bounceAnimation.duration = 0.6;
    
    NSMutableArray *timingFunctions = [[NSMutableArray alloc] initWithCapacity:bounceAnimation.values.count];
    for (NSUInteger i = 0; i < bounceAnimation.values.count; i++)
    {
        [timingFunctions addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    }
    [bounceAnimation setTimingFunctions:timingFunctions.copy];
    
    bounceAnimation.removedOnCompletion = NO;
    
    [self.layer addAnimation:bounceAnimation forKey:@"bounce"];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
