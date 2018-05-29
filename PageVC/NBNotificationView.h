//
//  NBNotificationView.h
//  BJEducation
//
//  Created by Lina on 2017/3/9.
//  Copyright © 2017年 com.bjhl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NBNotificationView : UIToolbar
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor * titleTextColor;
@property (nonatomic, strong) UIFont* subtitleFont;
@property (nonatomic, strong) UIColor *  subtitleTextColor;
@property (nonatomic) NSTimeInterval duration;
@property (nonatomic, readonly) BOOL isAnimating;
@property (nonatomic, readonly) BOOL isDragging;
@property (nonatomic) CGSize iconSize;
@property (nonatomic, readonly) CGSize intrinsicContentSize;
+ (NBNotificationView *)sharedNotification;
+ (void)setSharedNotification:(NBNotificationView *)value;
- (nonnull instancetype)init;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder ;
- (void)layoutSubviews;
- (nonnull instancetype)initWithFrame:(CGRect)frame;
- (void)showWithImage:(UIImage * _Nullable)image title:(NSString * _Nullable)title message:(NSString * _Nullable)message duration:(NSTimeInterval)duration iconSize:(CGSize)iconSize onTap:(void (^ _Nullable)(void))onTap;
- (void)hideWithCompletion:(void (^ _Nullable)(void))completion;
+ (void)showWithImage:(UIImage * _Nullable)image title:(NSString * _Nullable)title message:(NSString * _Nullable)message duration:(NSTimeInterval)duration iconSize:(CGSize)iconSize onTap:(void (^ _Nullable)(void))onTap;
+ (void)hideWithCompletion:(void (^ _Nullable)(void))completion;

@end
