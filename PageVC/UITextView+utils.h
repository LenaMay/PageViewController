//
//  UITextView+utils.h
//  BJEducation_student
//
//  Created by Mrlu-bjhl on 14-10-16.
//  Copyright (c) 2014年 Baijiahulian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (utils)
/*!
 *  @brief  设置TextView的字数限制
 *
 *  @param limitNumber 限制的字数
 *  @param inputblock  实际输入的字数
 *  @param warnBlock   超字符警告
 */
- (void) setTextViewLimitNumber:(NSInteger)limitNumber inputblock:(void(^)(NSInteger num))inputblock warnBlock:(void(^)(void))warnBlock;

- (float)textViewHeight;

- (CGFloat)textViewContentHeight;
@end
