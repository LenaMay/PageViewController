//
//  NSString+utils.m
//  BJEducation_student
//
//  Created by Mrlu-bjhl on 14-9-7.
//  Copyright (c) 2014年 Baijiahulian. All rights reserved.
//

#import "NSString+utils.h"
#import <CoreText/CoreText.h>

@implementation NSString (utils)

+(BOOL)isNil:(NSString *)str{
    if (str==nil||[self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    return NO;
}

+(NSString *)getStrByNil:(NSString *)str{
    if (str==nil||[str isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return str;
}
+ (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
+ (BOOL)isPhoneMobile:(NSString *)mobileNum
{
    NSString *regex = @"1[0-9]{10}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:mobileNum];
    return isMatch;
}

- (CGFloat)stringLengthWithFont:(UIFont *)font{
    CGFloat width = 0.0;
    CGSize labsize = CGSizeZero;
    if ([[UIDevice currentDevice].systemVersion floatValue] < 7.0) {
        labsize = [self sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, font.pointSize) lineBreakMode:NSLineBreakByWordWrapping];
    }
    else
    {
        labsize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, font.pointSize) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil].size;
    }
    
    width = labsize.width;
    return  ceilf(width);
}

- (CGFloat )stringHeightWithFont:(UIFont *)font size:(CGSize)size{
    CGFloat height = 0.0;
    CGSize labsize = CGSizeZero;
    size.height = MAXFLOAT;
    if ([[UIDevice currentDevice].systemVersion floatValue] < 7.0) {
        labsize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    }
    else
    {
        labsize = [self boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil].size;
    }
    
    height = labsize.height;
    height = height + 1;
    return ceilf(height);
}

- (CGSize)stringSizeWithFont:(UIFont *)font size:(CGSize)size {
    CGSize labsize = CGSizeZero;
    if ([[UIDevice currentDevice].systemVersion floatValue] < 7.0) {
        labsize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    }
    else
    {
        labsize = [self boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil].size;
    }
    return labsize;
}

- (BOOL)isUrl
{
    NSString *match=@"((http|ftp|https)://)(([a-zA-Z0-9\\._-]+\\.[a-zA-Z]{2,6})|([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}))(:[0-9]{1,4})*(/[a-zA-Z0-9\\&%_\\./-~-]*)?";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
    return YES;
}

+ (NSString *)encodeToPercentEscapeString: (NSString *) input
{
    // Encode all the reserved characters, per RFC 3986
    // (<http://www.ietf.org/rfc/rfc3986.txt>)
    NSString*
    outputStr = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                             
                                                                             NULL, /* allocator */
                                                                             
                                                                             (__bridge CFStringRef)input,
                                                                             
                                                                             NULL, /* charactersToLeaveUnescaped */
                                                                             
                                                                             (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                             
                                                                             kCFStringEncodingUTF8);
    return outputStr;
}

+ (NSString *)decodeFromPercentEscapeString: (NSString *) input
{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (BOOL)containsHTMLTag {
    NSRange r = [self rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch];
    return r.location != NSNotFound;
}

- (NSString *) stringByStrippingHTML {
    NSRange r;
    NSString *s = [self copy];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

+ (NSArray *)getSeparatedLinesFromLabel:(UILabel *)label
{
    NSString *text = [label text];
    UIFont   *font = [label font];
    CGRect    rect = [label bounds];
    
    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width, rect.size.height));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines)
    {
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        
        NSString *lineString = [text substringWithRange:range];
        [linesArray addObject:lineString];
    }
    return (NSArray *)linesArray;
}

+ (NSString *)defaultString:(NSString *)string defaultValue:(NSString *)value
{
    if (string != nil && ![string isEqual:[NSNull null]]) {
        return string;
    } else {
        return value;
    }
}

@end
