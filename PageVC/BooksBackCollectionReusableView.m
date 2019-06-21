//
//  BooksBackCollectionReusableView.m
//  PageVC
//
//  Created by zhanglina on 2019/6/21.
//  Copyright © 2019 Lina. All rights reserved.
//

#import "BooksBackCollectionReusableView.h"

@implementation BooksBackCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, 48)];
        img.image = [UIImage imageNamed:@"img_shujia"];
        [self addSubview:img];
    }
    
    return self;
}
@end
