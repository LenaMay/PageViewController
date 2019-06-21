//
//  BooksCollectionViewFlowLayout.m
//  PageVC
//
//  Created by zhanglina on 2019/6/21.
//  Copyright © 2019 Lina. All rights reserved.
//
#import "BooksBackCollectionReusableView.h"
#import "BooksCollectionViewFlowLayout.h"
NSString * const BooksCollectionViewFlowLayoutDecorationViewKind = @"BooksCollectionViewFlowLayoutDecorationViewKind";

@implementation BooksCollectionViewFlowLayout
-(void)prepareLayout{//准备方法被自动调用，以保证layout实例的正确。
    [super prepareLayout];
    
    [self registerClass:[BooksBackCollectionReusableView class] forDecorationViewOfKind:BooksCollectionViewFlowLayoutDecorationViewKind];

    
}

- (CGSize)collectionViewContentSize
{
    CGSize contentSize = CGSizeMake(self.collectionView.bounds.size.width, 600);
    
    return contentSize;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    // create a mutable copy so we can add layout attributes for any shelfs that
    // have frames that intersect the rect the CollectionView is interested in
    NSMutableArray *newArray = [array mutableCopy];
    //    NSLog(@"in rect:%@",NSStringFromCGRect(rect));
    // Add any decoration views (shelves) who's rect intersects with the
    // CGRect passed to the layout by the CollectionView
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    for (int row = 0; row < 12; row++)
    {
        [dictionary setObject:[NSIndexPath indexPathForItem:row inSection:0] forKey:[NSValue valueWithCGRect:CGRectMake(0, 40 * row, DEVICE_SCREEN_WIDTH, 40)]];
    }
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id shelfRect, BOOL *stop) {
        //        NSLog(@"[shelfRect CGRectValue]:%@",NSStringFromCGRect([shelfRect CGRectValue]));
        
        if (CGRectIntersectsRect([shelfRect CGRectValue], rect))
        {
            UICollectionViewLayoutAttributes *shelfAttributes =
            [self layoutAttributesForDecorationViewOfKind:BooksCollectionViewFlowLayoutDecorationViewKind
                                              atIndexPath:key];
            [newArray addObject:shelfAttributes];
        }
    }];
    
    for (int i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        [newArray addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    
    return [newArray copy];
}
//-(CGSize)collectionViewContentSize{//返回collectionView的内容的尺寸
//    self
//}

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{//返回对应于indexPath的位置的装饰视图的布局属性，如果没有装饰视图可不重载
    UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:elementKind withIndexPath:indexPath];
     att.frame = CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, 40);
    att.zIndex = -1;
    return att;
}

@end
