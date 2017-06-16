//
//  NFShopModel.m
//  guonongda
//
//  Created by guest on 16/8/30.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFShopModel.h"

@implementation NFShopModel

- (void)setJuli:(NSInteger)juli{
    if (_juli != juli) {
        _juli = juli;
    }
    if (juli > 9999) {
        NSInteger zhengshubufen = juli/1000;
        NSString *zhengshubufenstr = [NSString stringWithFormat:@"%ld",zhengshubufen];
        NSString *juliString = [NSString stringWithFormat:@"%ld",juli];
        NSRange range = [juliString rangeOfString:zhengshubufenstr];
        NSRange range2 = NSMakeRange(range.location + range.length, 2);
        NSString *xiaoshubufen = [juliString substringWithRange:range2];
        NSString *finalStr = [NSString stringWithFormat:@"%@.%@km",zhengshubufenstr,xiaoshubufen];
        
        _distance = finalStr;
    }else{
        _distance = [NSString stringWithFormat:@"%ldm",juli];
        
    }
}

@end
