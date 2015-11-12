//
//  FlowLayout.m
//  FlowCollectionView
//
//  Created by Wenshuang Zhou on 15/11/11.
//  Copyright © 2015年 PCBZ. All rights reserved.
//

#import "FlowLayout.h"

@implementation FlowLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    CGRect visibleRect = (CGRect){self.collectionView.contentOffset, self.collectionView.bounds.size};
    
    for (UICollectionViewLayoutAttributes *attributes in array) {
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
            if (ABS(distance) < ACTIVE_DISTANCE) {
                CGFloat zoom = 1 + ZOOMING_FACTOR * (1 - ABS(distance / ACTIVE_DISTANCE));
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);
                attributes.zIndex = 1;
            }
        }
    }
    return array;
}


- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGFloat offSetAdjustment = MAXFLOAT;
    CGFloat horizontalCenter = (CGFloat) (proposedContentOffset.x + (self.collectionView.bounds.size.width / 2.0));
    
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    
    NSArray *array = [self layoutAttributesForElementsInRect:targetRect];
    
    UICollectionViewLayoutAttributes *currentAttributes;
    
    for (UICollectionViewLayoutAttributes *layoutAttributes in array)
    {
        if(layoutAttributes.representedElementCategory == UICollectionElementCategoryCell)
        {
            CGFloat itemHorizontalCenter = layoutAttributes.center.x;
            if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offSetAdjustment))
            {
                currentAttributes   = layoutAttributes;
                offSetAdjustment    = itemHorizontalCenter - horizontalCenter;
            }
        }
    }
    
    CGFloat nextOffset          = proposedContentOffset.x + offSetAdjustment;
    
    proposedContentOffset.x     = nextOffset;
    CGFloat deltaX              = proposedContentOffset.x - self.collectionView.contentOffset.x;
    CGFloat velX                = velocity.x;
    
    // detection form  gist.github.com/rkeniger/7687301
    // based on http://stackoverflow.com/a/14291208/740949
    if(deltaX == 0.0 || velX == 0 || (velX > 0.0 && deltaX > 0.0) || (velX < 0.0 && deltaX < 0.0)) {
        
    } else if(velocity.x > 0.0) {
        for (UICollectionViewLayoutAttributes *layoutAttributes in array)
        {
            if(layoutAttributes.representedElementCategory == UICollectionElementCategoryCell)
            {
                CGFloat itemHorizontalCenter = layoutAttributes.center.x;
                if (itemHorizontalCenter > proposedContentOffset.x) {
                    proposedContentOffset.x = nextOffset + (currentAttributes.frame.size.width / 2) + (layoutAttributes.frame.size.width / 2);
                    break;
                }
            }
        }
    } else if(velocity.x < 0.0) {
        for (UICollectionViewLayoutAttributes *layoutAttributes in array)
        {
            if(layoutAttributes.representedElementCategory == UICollectionElementCategoryCell)
            {
                CGFloat itemHorizontalCenter = layoutAttributes.center.x;
                if (itemHorizontalCenter > proposedContentOffset.x) {
                    proposedContentOffset.x = nextOffset - ((currentAttributes.frame.size.width / 2) + (layoutAttributes.frame.size.width / 2));
                    break;
                }
            }
        }
    }
    
    proposedContentOffset.y = 0.0;
    
    return proposedContentOffset;
}

@end
