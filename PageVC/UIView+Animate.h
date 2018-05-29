//
//  UIView+Animate.h
//  BJEducation_student
//
//  Created by Mac_ZL on 16/9/7.
//  Copyright © 2016年 Baijiahulian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animate)
/**
 *  @author LiangZhao, 16-09-07 19:09:34
 *
 *  跳跃动画
 *
 *  @param offset   跳跃偏移量 正值向下偏移，推荐偏移量：4
 *  @param duration 动画时间
 */
- (void)addJumpAnimateWithOffset:(CGFloat) offset duration:(NSTimeInterval )duration;

@end
