//
//  NFCoordinateQuadTree.h
//  guonongda
//
//  Created by guest on 16/9/26.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import "QuadTree.h"
@interface NFCoordinateQuadTree : NSObject

@property (nonatomic, assign) QuadTreeNode * root;

- (void)buildTreeWithModels:(NSArray *)models;
- (void)clean;

- (NSArray *)clusteredAnnotationsWithinMapRect:(MAMapRect)rect withZoomScale:(double)zoomScale andZoomLevel:(double)zoomLevel;


@end
