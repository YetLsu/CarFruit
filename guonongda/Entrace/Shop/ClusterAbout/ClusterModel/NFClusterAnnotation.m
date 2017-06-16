//
//  NFClusterAnnotation.m
//  guonongda
//
//  Created by guest on 16/9/26.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFClusterAnnotation.h"

@implementation NFClusterAnnotation
#pragma mark - compare

- (NSUInteger)hash
{
    NSString *toHash = [NSString stringWithFormat:@"%.5F%.5F%ld", self.coordinate.latitude, self.coordinate.longitude, (long)self.count];
    return [toHash hash];
}

- (BOOL)isEqual:(id)object
{
    return [self hash] == [object hash];
}
#pragma mark - Life Cycle

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate count:(NSInteger)count
{
    self = [super init];
    if (self)
    {
        _coordinate = coordinate;
        _count = count;
        _models  = [NSMutableArray arrayWithCapacity:count];
    }
    return self;
}


@end
