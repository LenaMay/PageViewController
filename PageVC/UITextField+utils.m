//
//  UITextField+utils.m
//  BJEducation_student
//
//  Created by Mrlu-bjhl on 14-10-16.
//  Copyright (c) 2014年 Baijiahulian. All rights reserved.
//

#import "UITextField+utils.h"

@implementation UITextField (utils)
- (void)setTextFieldLimitNumber:(NSInteger)limitNumber inputblock:(void (^)(NSInteger))inputblock warnBlock:(void (^)(void))warnBlock
{
    NSString *toBeString = self.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > limitNumber) {
                self.text = [toBeString substringToIndex:limitNumber];
                [self  resignFirstResponder];
                //超过限制字数
                if (warnBlock) {
                    warnBlock();
                }
            }
            else
            {
                //当前输入文字
                if (inputblock) {
                   inputblock(limitNumber - toBeString.length);
                }
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    else{
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > limitNumber) {
            self.text = [toBeString substringToIndex:limitNumber];
            [self  resignFirstResponder];
            //超过限制字数
            if (warnBlock) {
                warnBlock();
            }
        }
        else
        {
            //当前输入文字
            if (inputblock) {
                inputblock(limitNumber - toBeString.length);
            }
        }
    }
}

- (BOOL)isTextChanged
{
    BOOL isChanged = NO;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        isChanged = !position;
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        isChanged = YES;
    }
    return isChanged;
}



- (void)setTextFieldLimitNumber:(NSInteger )number{
    
    NSString *toBeString =self.text;
    NSString *lang;
    if (IS_OS_7_OR_LATER) {
        lang = [[self textInputMode] primaryLanguage];
    }else{
        lang = [[UITextInputMode currentInputMode] primaryLanguage];
    }
    if([lang isEqualToString:@"zh-Hans"]){ //简体中文输入，包括简体拼音，健体五笔，简体手写
        
        UITextRange *selectedRange = [self markedTextRange];
        
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        
        if (!position){//非高亮
            
            if (toBeString.length > number) {
                self.text = [toBeString substringToIndex:number];
            }
        }
    }else{//中文输入法以外
        if (toBeString.length > number) {
            self.text = [toBeString substringToIndex:number];
        }
    }

}
@end
