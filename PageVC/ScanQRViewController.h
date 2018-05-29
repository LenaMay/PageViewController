//
//  ScanViewController.h
//  二维码
//
//  Created by zhanglina on 15/4/9.
//  Copyright (c) 2015年 张丽娜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>



NS_ASSUME_NONNULL_BEGIN

typedef void(^ActionBlock)( NSString * _Nullable result);

@interface ScanQRViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>
{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
}

@property (nonatomic, assign) BOOL isDebug; //default: NO
@property (nonatomic, copy, nullable) ActionBlock actionBlock; //没有设置时跳转打开webView/设置是自己控制结果

@end

NS_ASSUME_NONNULL_END
