//
//  UITextField+utils.h
//  BJEducation_student
//
//  Created by Mrlu-bjhl on 14-10-16.
//  Copyright (c) 2014年 Baijiahulian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (utils)
/*!
 *  @brief  设置TextField的字数限制
 *
 *  @param limitNumber 限制的字数
 *  @param inputblock  实际输入的字数
 *  @param warnBlock   超字符警告
 */
- (void)setTextFieldLimitNumber:(NSInteger)limitNumber inputblock:(void (^)(NSInteger num))inputblock warnBlock:(void (^)(void))warnBlock;


/*!
 *  @brief  设置TextField的字数限制 超出不会隐藏键盘
 *
 *  @param limitNumber 限制的字数
 *  @param inputblock  实际输入的字数
 *  @param warnBlock   超字符警告
 */

- (void)setTextFieldLimitNumber:(NSInteger )number;
/*!
 *  @author MrLu, 15-05-16 11:05:03
 *
 *  @brief  判断文本是否有修改(中文输入的时候联想情况)
 *
 *  @return 是否有修改
 */
- (BOOL)isTextChanged;

@end
