//
//  NFPresentTransition.h
//  guonongda
//
//  Created by guest on 16/9/23.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    NFPresentTransitionTypePresent = 0,
    NFPresentTransitionTypeDismiss
}NFPresentTransitionType;


@interface NFPresentTransition : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithTransitionType:(NFPresentTransitionType)type;

- (instancetype)initWithTransitionType:(NFPresentTransitionType)type;

@end
