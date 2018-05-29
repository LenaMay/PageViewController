//
//  NSString+utils.h
//  BJEducation_student
//
//  Created by Mrlu-bjhl on 14-9-7.
//  Copyright (c) 2014年 Baijiahulian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSString (utils)
//判断字符串是否为nil null 则返回为yes
+(BOOL)isNil:(NSString *)str;
+(NSString *)getStrByNil:(NSString *)str;
+ (BOOL)isBlankString:(NSString *)string;
//返回长度
- (CGFloat )stringLengthWithFont:(UIFont *)font;
- (CGFloat )stringHeightWithFont:(UIFont *)font size:(CGSize)size;
- (CGSize)stringSizeWithFont:(UIFont *)font size:(CGSize)size;

- (BOOL)isUrl;

+ (NSString *)encodeToPercentEscapeString: (NSString *) input;

+ (NSString *)decodeFromPercentEscapeString: (NSString *) input;

- (BOOL)containsHTMLTag;
- (NSString *) stringByStrippingHTML;

+ (NSArray *)getSeparatedLinesFromLabel:(UILabel *)label;

//默认值
+ (NSString *)defaultString:(NSString *)string defaultValue:(NSString *)value;

@end
