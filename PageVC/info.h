//
//  info.h
//  PageVC
//
//  Created by Lina on 2017/5/8.
//  Copyright © 2017年 Lina. All rights reserved.
//

#ifndef info_h
#define info_h




//IOS版本
#define SYSTEM_VERSION [[UIDevice currentDevice].systemVersion floatValue]
//系统名字  手机型号+系统+系统版本
#define SYSTEM_NAME  [NSString stringWithFormat:@"%@ %@ %@",[[UIDevice currentDevice] model],[[UIDevice currentDevice] systemName],[[UIDevice currentDevice] systemVersion]]

#define DEVICE_NAME  [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] model]]
// 应用版本
#define APPVERISON			[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define APPBUILD            [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
//当前设备屏幕高度
#define DEVICE_SCREEN [UIScreen mainScreen].bounds
#define DEVICE_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define DEVICE_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

//判断设备
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define IS_IPHONE_4 (fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480) < DBL_EPSILON)

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define IS_4_Inch_LATER (([UIScreen mainScreen].bounds.size.width > 320) && ([UIScreen mainScreen].bounds.size.height > 568))

#define IS_IPHONE_6_Plus ([UIScreen mainScreen].scale == 3 )
#define IS_IPHONE_6  ([UIScreen mainScreen].scale == 2 && (fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON ))

#define IS_OS_9_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_STANDARD_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0  && IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale == [UIScreen mainScreen].scale)
#define IS_ZOOMED_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0 && IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale > [UIScreen mainScreen].scale)
#define IS_STANDARD_IPHONE_6_PLUS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0)
#define IS_ZOOMED_IPHONE_6_PLUS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0 && IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale < [UIScreen mainScreen].scale)


//4.0 4.7 5.5尺寸放大系数
#define KSCALE ((IS_IPHONE_6 || IS_IPHONE_6_Plus)?(DEVICE_SCREEN_WIDTH/320.):1.0)

#define KSCALEWITHMARGIN(margin) ((IS_IPHONE_6 || IS_IPHONE_6_Plus)?((DEVICE_SCREEN_WIDTH - (margin))/(320. - (margin))):1.0)


#define KFOURSCALE ((IS_IPHONE_6 || IS_IPHONE_6_Plus||IS_IPHONE_5)?KSCALE:0.8)

#define kNavBarHeight ([[UIDevice currentDevice].systemVersion floatValue]>=7?64:44)
#define UIFont_Font(size) [UIFont systemFontOfSize:size]
#define UIFont_bold_Font(size) [UIFont boldSystemFontOfSize:size]

#define __WeakSelf__  __weak typeof (self)

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define __WeakObject(object) __weak typeof (object)

#define weakifyself __WeakSelf__ wSelf = self;
#define strongifyself __WeakSelf__ self = wSelf;

#define weakifyobject(obj) __WeakObject(obj) $##obj = obj;
#define strongifobject(obj) __WeakObject(obj) obj = $##obj;



#import "NSString+utils.h"
#import "UIAlertView+Block.h"
#import "UIActionSheet+Blocks.h"
#import "UIView+Basic.h"
#import "UIView+Animate.h"
#import "UIView+Extension.h"
#import "UITextView+utils.h"
#import "UITextField+utils.h"
#import "UITableViewCell+utils.h"
#import <Masonry/Masonry.h>

#endif /* info_h */
