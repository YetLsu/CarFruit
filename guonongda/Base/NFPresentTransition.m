//
//  NFPresentTransition.m
//  guonongda
//
//  Created by guest on 16/9/23.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFPresentTransition.h"

@interface NFPresentTransition ()
@property (nonatomic, assign)NFPresentTransitionType type;
@end

@implementation NFPresentTransition

+ (instancetype)transitionWithTransitionType:(NFPresentTransitionType)type{
    NFPresentTransition *transition = [[self alloc] initWithTransitionType:type];
    return transition;
}

- (instancetype)initWithTransitionType:(NFPresentTransitionType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    //为了将两种动画的逻辑分开，变得更加清晰，我们分开书写逻辑，
    switch (_type) {
        case NFPresentTransitionTypePresent:
            [self presentAnimation:transitionContext];
            break;
            
        case NFPresentTransitionTypeDismiss:
            [self dismissAnimation:transitionContext];
            break;
    }

}

//present 的动画
- (void)presentAnimation:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *tempView = [fromVc.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = fromVc.view.frame;
    fromVc.view.hidden = YES;
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:tempView];
    [containerView addSubview:toVc.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:1/0.55 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
    


}


//dismiss 的动画
- (void)dismissAnimation:(id <UIViewControllerContextTransitioning>)transitionContext{}


@end
