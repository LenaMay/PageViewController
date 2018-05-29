//
//  UITextView+utils.m
//  BJEducation_student
//
//  Created by Mrlu-bjhl on 14-10-16.
//  Copyright (c) 2014年 Baijiahulian. All rights reserved.
//

#import "UITextView+utils.h"

@implementation UITextView (utils)
- (void)setTextViewLimitNumber:(NSInteger)limitNumber inputblock:(void (^)(NSInteger))inputblock warnBlock:(void (^)(void))warnBlock
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


- (float)textViewHeight
{
    float height = 0.0;
    CGSize labsize = CGSizeZero;
    if ([[UIDevice currentDevice].systemVersion floatValue]>=7.0) {
        labsize = [self sizeThatFits:CGSizeMake(self.frame.size.width, FLT_MAX)];
        height = labsize.height;
    } else {
        UIFont *font = self.font;
        NSString *strString = self.text;
        if ([[UIDevice currentDevice].systemVersion floatValue]<7.0) {
            labsize = [strString sizeWithFont:font constrainedToSize:CGSizeMake(self.frame.size.width,MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        }
        else
        {
            labsize = [strString boundingRectWithSize:CGSizeMake(self.frame.size.width,CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil].size;
        }
        height = labsize.height;
        height = height + self.contentInset.top + self.contentInset.bottom;
    }
    return height;
}

- (CGFloat)textViewContentHeight
{
    CGFloat height = 0.;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        CGRect textFrame=[[self layoutManager]usedRectForTextContainer:[self textContainer]];
        height = textFrame.size.height;
    }else {
        
        height = self.contentSize.height;
    }
    return height;
}
@end
