//
//  VoiceBookCollectionViewCell.m
//  PageVC
//
//  Created by zhanglina on 2019/6/20.
//  Copyright © 2019 Lina. All rights reserved.
//

#import "VoiceBookCollectionViewCell.h"

@implementation VoiceBookCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setUpView];
    }
    return self;
}

- (void)setUpView{
    [self.contentView setBackgroundColor:[UIColor greenColor]];
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView setBackgroundColor:[UIColor blueColor]];
    [self.contentView addSubview:imageView];
    [imageView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
    }];
    
    UILabel *label =[[UILabel alloc]init];
    label.text = @"haha";
    label.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
    }];
}
@end
