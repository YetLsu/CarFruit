//
//  NFCoordinateQuadTree.m
//  guonongda
//
//  Created by guest on 16/9/26.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFCoordinateQuadTree.h"
#import "NFClusterAnnotation.h"


#import "NFShopModel.h"

QuadTreeNodeData QuadTreeNodeDataForModel(NFShopModel *model)
{
    return QuadTreeNodeDataMake([model.lat doubleValue],[model.lon doubleValue], (__bridge_retained void *)(model));
}

BoundingBox BoundingBoxForMapRect(MAMapRect mapRect)
{
    CLLocationCoordinate2D topLeft = MACoordinateForMapPoint(mapRect.origin);
    CLLocationCoordinate2D botRight = MACoordinateForMapPoint(MAMapPointMake(MAMapRectGetMaxX(mapRect), MAMapRectGetMaxY(mapRect)));
    
    CLLocationDegrees minLat = botRight.latitude;
    CLLocationDegrees maxLat = topLeft.latitude;
    
    CLLocationDegrees minLon = topLeft.longitude;
    CLLocationDegrees maxLon = botRight.longitude;
    
    return BoundingBoxMake(minLat, minLon, maxLat, maxLon);
}

float CellSizeForZoomLevel(double zoomLevel)
{
    /*zoomLevel越大，cellSize越小. */
    if (zoomLevel < 13.0)
    {
        return 64;
    }
    else if (zoomLevel <15.0)
    {
        return 32;
    }
    else if (zoomLevel <18.0)
    {
        return 16;
    }
    else if (zoomLevel < 20.0)
    {
        return 8;
    }
    
    return 64;
}

BoundingBox quadTreeNodeDataArrayForModels(QuadTreeNodeData *dataArray, NSArray * models)
{
    NFShopModel *model = models[0];
    
    CLLocationDegrees minX = [model.lat doubleValue];
    CLLocationDegrees maxX = [model.lat doubleValue];
    
    CLLocationDegrees minY = [model.lon doubleValue];
    CLLocationDegrees maxY = [model.lon doubleValue];
    
    for (NSInteger i = 0; i < [models count]; i++)
    {
        dataArray[i] = QuadTreeNodeDataForModel(models[i]);
        
        if (dataArray[i].x < minX)
        {
            minX = dataArray[i].x;
        }
        
        if (dataArray[i].x > maxX)
        {
            maxX = dataArray[i].x;
        }
        
        if (dataArray[i].y < minY)
        {
            minY = dataArray[i].y;
        }
        
        if (dataArray[i].y > maxY)
        {
            maxY = dataArray[i].y;
        }
    }
    
    return BoundingBoxMake(minX, minY, maxX, maxY);
}



@implementation NFCoordinateQuadTree

//根据地图的放大和放大级别聚集大头针模型
- (NSArray *)clusteredAnnotationsWithinMapRect:(MAMapRect)rect withZoomScale:(double)zoomScale andZoomLevel:(double)zoomLevel{

    double CellSize = CellSizeForZoomLevel(zoomLevel);
    double scaleFactor = zoomScale / CellSize;
    
    NSInteger minX = floor(MAMapRectGetMinX(rect) * scaleFactor);
    NSInteger maxX = floor(MAMapRectGetMaxX(rect) * scaleFactor);
    NSInteger minY = floor(MAMapRectGetMinY(rect) * scaleFactor);
    NSInteger maxY = floor(MAMapRectGetMaxY(rect) * scaleFactor);
    
    NSMutableArray *clusteredAnnotations = [[NSMutableArray alloc] init];
    for (NSInteger x = minX; x <= maxX; x++)
    {
        for (NSInteger y = minY; y <= maxY; y++)
        {
            MAMapRect mapRect = MAMapRectMake(x / scaleFactor, y / scaleFactor, 1.0 / scaleFactor, 1.0 / scaleFactor);
            
            __block double totalX = 0;
            __block double totalY = 0;
            __block int     count = 0;
            
            NSMutableArray *models = [[NSMutableArray alloc] init];
            
            /* 查询区域内数据的个数. */
            QuadTreeGatherDataInRange(self.root, BoundingBoxForMapRect(mapRect), ^(QuadTreeNodeData data)
                                      {
                                          totalX += data.x;
                                          totalY += data.y;
                                          count++;
                                          
                                          [models addObject:(__bridge NFShopModel *)data.data];
                                      });
            
            /* 若区域内仅有一个数据. */
            if (count == 1)
            {
                CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(totalX, totalY);
                NFClusterAnnotation *annotation = [[NFClusterAnnotation alloc] initWithCoordinate:coordinate count:count];
//                annotation.pois = pois;
                annotation.models = models;
                [clusteredAnnotations addObject:annotation];
            }
            
            /* 若区域内有多个数据 按数据的中心位置画点. */
            if (count > 1)
            {
                CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(totalX / count, totalY / count);
                NFClusterAnnotation *annotation = [[NFClusterAnnotation alloc] initWithCoordinate:coordinate count:count];
                annotation.models = models;
                
                [clusteredAnnotations addObject:annotation];
            }
        }
    }
    
    return [NSArray arrayWithArray:clusteredAnnotations];
}


//根据models数组建立四叉树
- (void)buildTreeWithModels:(NSArray *)models{
    QuadTreeNodeData *dataArray = malloc(sizeof(QuadTreeNodeData)*[models count]);
    
    BoundingBox maxBounding = quadTreeNodeDataArrayForModels(dataArray, models);
    
    /*若已有四叉树，清空.*/
    [self clean];
    
    NSLog(@"build tree.");
    /*建立四叉树索引. */
    self.root = QuadTreeBuildWithData(dataArray, [models count], maxBounding, 4);
    
    free(dataArray);
}

//清空
- (void)clean{
    if (self.root)
    {
        NSLog(@"free tree.");
        FreeQuadTreeNode(self.root);
    }

}

@end
