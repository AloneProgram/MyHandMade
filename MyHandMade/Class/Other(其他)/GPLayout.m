//
//  GPLayout.m
//  MyHandMade
//
//  Created by iKnet on 16/7/29.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPLayout.h"

@implementation GPLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    CGFloat offsetY = self.collectionView.contentOffset.y;
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    CGFloat frameHeight= self.collectionView.frame.size.height;
    CGFloat contentHeight = self.collectionView.contentSize.height;
    CGFloat contentInsetBoom = self.collectionView.contentInset.bottom;
    CGFloat bottomOffSet = offsetY + frameHeight - contentHeight - contentInsetBoom;
    CGFloat numerOfItems = [self.collectionView numberOfItemsInSection:nil];
    
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (attrs.representedElementCategory == UICollectionElementCategoryCell) {

            CGRect cellRect = attrs.frame;
            if (offsetY <= 0) {
                CGFloat distance = fabs(offsetY) / 8;
                cellRect.origin.y += offsetY + distance * (CGFloat)(attrs.indexPath.section + 1);
                
            }else if (bottomOffSet > 0 ){
                CGFloat distance = bottomOffSet / 8;
                cellRect.origin.y += bottomOffSet - distance *(CGFloat)(numerOfItems - attrs.indexPath.section);
            }
            attrs.frame = cellRect;

        }
    }
    return array;
    
}

@end
