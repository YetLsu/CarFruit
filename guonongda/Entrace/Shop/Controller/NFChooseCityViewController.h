//
//  NFChooseCityViewController.h
//  guonongda
//
//  Created by guest on 16/10/12.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NFChooseCityDelegate <NSObject>

- (void)getCity:(NSString *)city;

@end


@interface NFChooseCityViewController : UIViewController
@property (nonatomic, copy) NSString *currentCity;
@property (nonatomic, assign) id<NFChooseCityDelegate> delegate;
@end
