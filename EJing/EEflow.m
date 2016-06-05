//
//  EEflow.m
//  EJing
//
//  Created by 123 on 16/3/24.
//  Copyright (c) 2016年 陈海岩. All rights reserved.
//

#import "EEflow.h"

@implementation EEflow
#define ZOOM_ACYOR 0.5
#define DISTANCE 200
- (instancetype)init{
    if(self=[super init]){
        self.itemSize=CGSizeMake(160, 200);
        self.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        self.sectionInset=UIEdgeInsetsMake(120, 0, 120, 0);
        //self.minimumInteritemSpacing=50;
        self.minimumLineSpacing=50;
    }
    return self;
}
//使滑动item是产生动画的滑动效果
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}
//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds{
//    return YES;
//}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *origalArray=[super layoutAttributesForElementsInRect:rect];
    //必须对元素进行一个拷贝的动作，否则会出现提示的信息
    NSArray *array=[[NSArray alloc] initWithArray:origalArray copyItems:YES];
    CGRect visible;
    visible.origin=self.collectionView.contentOffset;
    visible.size=self.collectionView.bounds.size;
    for (UICollectionViewLayoutAttributes* attributes in array) {
        CGFloat distante=CGRectGetMidX(visible)-attributes.center.x;
        if (ABS(distante)<DISTANCE) {
            CGFloat zoom=1+ZOOM_ACYOR*(1-ABS(distante/DISTANCE));
            attributes.transform3D=CATransform3DMakeScale(zoom, zoom, 1);
            attributes.zIndex=1;
        }
    }
    return array;
}

@end
