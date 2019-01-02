//
//  LNFingerLineModel.h
//  PageVC
//
//  Created by Lina on 2018/7/2.
//  Copyright © 2018年 Lina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LNFingerLineModel : NSObject
@property (nonatomic,strong)NSMutableArray <__kindof NSValue *>*linePoints;//线条所包含的所有点
@property (nonatomic,strong)UIColor *lineColor;//线条的颜色
@property (nonatomic)float lineWidth;//线条的粗细

@end
