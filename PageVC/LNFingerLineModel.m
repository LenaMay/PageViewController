//
//  LNFingerLineModel.m
//  PageVC
//
//  Created by Lina on 2018/7/2.
//  Copyright © 2018年 Lina. All rights reserved.
//

#import "LNFingerLineModel.h"

@implementation LNFingerLineModel
- (instancetype)init {
    if (self=[super init]) {
        self.linePoints = [[NSMutableArray alloc] initWithCapacity:10];
    }

    return self;
}

@end
