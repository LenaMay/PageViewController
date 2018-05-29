//
//  UIView+Animate.m
//  BJEducation_student
//
//  Created by Mac_ZL on 16/9/7.
//  Copyright © 2016年 Baijiahulian. All rights reserved.
//

#import "UIView+Animate.h"

@implementation UIView (Animate)

- (void)addJumpAnimateWithOffset:(CGFloat)offset
                        duration:(NSTimeInterval)duration
{
    CGFloat y = self.layer.position.y;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    animation.duration = duration;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = YES;
    NSMutableArray *values = [NSMutableArray array];
    
    [values addObject:@(y)];
    [values addObject:@(y - offset)];
    [values addObject:@(y)];
    [values addObject:@(y - offset)];
    [values addObject:@(y)];
    
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [self.layer addAnimation:animation forKey:nil];
}
@end
