//
//  NBNotificationView.m
//  BJEducation
//
//  Created by Lina on 2017/3/9.
//  Copyright © 2017年 com.bjhl. All rights reserved.
//

#import "NBNotificationView.h"
#define defaultTitleFont  UIFont_Font(14)
#define defaultSubtitleFont  UIFont_Font(14)
#define defaultAnimationDuration  0.3
#define defaultAxhibitionDuration  5.0

#define defaultHeight  64.0
#define defaultWidth [UIScreen mainScreen].bounds.size.width
#define defaultLabelTitleHeight  26
#define defaultLabelMessageHeight  35
#define defaultDragViewHeight  3
#define defaultIconSize = CGSizeMake(22,22)
#define defaultImageBorder 15
#define defaultTextBorder 10
#define UIFont_Font(size) [UIFont systemFontOfSize:size]
#define UIFont_bold_Font(size) [UIFont boldSystemFontOfSize:size]


typedef void  (^NotificationViewTapAction)(void);
@interface NBNotificationView()
@property (nonatomic, strong) UIImageView  *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel  *subtitleLabel;
@property (nonatomic, strong)NSTimer  *dismissTimer;
@property (nonatomic, assign) NotificationViewTapAction tapAction;
@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, assign) BOOL isDragging;

@end

@implementation NBNotificationView

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 0, defaultWidth, defaultHeight)];
    if(self){
        [self setupUI];
        [self startNotificationObservers];
    }
    return self;
}

+(NBNotificationView *)sharedNotification{
    
    static id sharedNotification = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNotification = [[self alloc] init];
    });
    return sharedNotification;
}


- (void)setupUI{
    self.titleFont = UIFont_Font(14);
    // Bar style
    self.barTintColor = nil;
    [self setTranslucent:YES];
    self.barStyle = UIBarStyleDefault;
    self.tintColor = [UIColor redColor];
    
//    self.layer.zPosition = CGFloat.greatestFiniteMagnitude - 1
    self.backgroundColor = [UIColor clearColor];
    self.multipleTouchEnabled = NO;
    self.exclusiveTouch = YES;
    
    self.frame =CGRectMake(0, 0, defaultWidth, 64);
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
    // Add subviews
    [self addSubview:self.titleLabel];
    [self addSubview:self.subtitleLabel];
    [self addSubview:self.imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTap:)];
    [self addGestureRecognizer:tap];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(didPan:)];
    [self addGestureRecognizer:pan];
    [self setupFrames];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self setupFrames];
    
}

- (void)startNotificationObservers{
    if (![[UIDevice currentDevice] isGeneratingDeviceOrientationNotifications]) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationStatusDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
}

- (void)orientationStatusDidChange:(NSNotification *)noti{
    [self setupUI];
}

- (void)setupFrames{
    CGRect frame = self.frame;
    frame.size.width = defaultWidth;
    self.frame = frame;
    self.titleLabel.frame = self.titleLabelFrame;
    self.imageView.frame = CGRectMake(15, 8, self.iconSize.width, self.iconSize.height);
    self.subtitleLabel.frame = self.messageLabelFrame;
    [self fixLabelMessageSize];

}

- (CGRect)titleLabelFrame{
    if (self.imageView.image == nil) {
        return CGRectMake(10, 3, defaultWidth - 20,defaultLabelTitleHeight);
    }
    return CGRectMake([self textPointX], 3, defaultWidth - 20, defaultLabelTitleHeight);
}

- (CGRect)messageLabelFrame{
    
    if (self.imageView.image == nil) {
        return CGRectMake(10, 25, defaultWidth - 20,defaultLabelMessageHeight);
    }
    return CGRectMake([self textPointX], 25, defaultWidth - 20, defaultLabelMessageHeight);
}


- (CGFloat)textPointX{
    return defaultImageBorder + self.iconSize.width + defaultTextBorder;
}

- (void)fixLabelMessageSize{
    
    CGSize size = [self.subtitleLabel sizeThatFits:CGSizeMake(defaultWidth - [self textPointX], MAXFLOAT)];
    CGRect frame = self.subtitleLabel.frame;
    frame.size.height = size.height>defaultLabelMessageHeight ? defaultLabelMessageHeight:size.height;
    self.subtitleLabel.frame = frame;
}

-(void)scheduledDismiss{
    [self hideWithCompletion:nil];
}

- (void)didTap:(UIGestureRecognizer *)gesture{
    if (self.tapAction) {
        self.tapAction();
    }
    [self hideWithCompletion:nil];
}

- (void)didPan:(UIPanGestureRecognizer *)panGersture{
    switch (panGersture.state) {
        case UIGestureRecognizerStateEnded:
        {
            self.isDragging = NO;
            if (self.frame.origin.y < 0 || self.duration <=0 ) {
                [self hideWithCompletion:nil];
            }
        }
            break;
        case UIGestureRecognizerStateBegan:
        {
            self.isDragging = YES;

        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            if (!self.superview) {
                return;
            }
            if (!panGersture.view) {
                return;
            }
           CGPoint translation =  [panGersture translationInView:self.superview];
            CGPoint newCenter = CGPointMake(self.superview.frame.size.width/2, panGersture.view.center.y + translation.y);
            if (newCenter.y >= (-1 * defaultHeight/2) && newCenter.y <= defaultHeight/2   ) {
                panGersture.view.center = newCenter;
                [panGersture setTranslation:CGPointZero inView:self.superview];
            }
            
        }
            break;
            
        default:
            break;
    }
}

- (void)showWithImage:(UIImage * _Nullable)image title:(NSString * _Nullable)title message:(NSString * _Nullable)message duration:(NSTimeInterval)duration iconSize:(CGSize)iconSize onTap:(void (^ _Nullable)(void))onTap{
    
    self.dismissTimer = nil;
    self.tapAction = onTap;
    /// Content
    self.imageView.image = image;
    self.titleLabel.text = title;
    self.subtitleLabel.text = message;
    
    self.iconSize = iconSize;
    
    /// Prepare frame
    CGRect frame = self.frame;
    frame.origin.y = -frame.size.height;
    self.frame = frame;
    
    [self setupFrames];
    
    [self setUserInteractionEnabled:YES];
    self.isAnimating = YES;
    
    /// Add to window
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    window.windowLevel = UIWindowLevelStatusBar;
    [window addSubview:self];
   /// Show animation
    [UIView animateWithDuration:defaultAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect frame = self.frame;
        frame.origin.y += frame.size.height;
        self.frame = frame;
    } completion:^(BOOL finished) {
        self.isAnimating = NO;
    }];
     // Schedule to hide
    if (self.duration>0) {
        CGFloat time = self.duration + defaultAnimationDuration;
        self.dismissTimer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(scheduledDismiss) userInfo:nil repeats:NO];
    }
}

- (void)hideWithCompletion:(void (^ _Nullable)(void))completion{
    if(self.isDragging){
        self.dismissTimer = nil;
        return;
    }
    if (self.superview == nil) {
        self.isAnimating = NO;
        return;
    }
    if (self.isAnimating) {
        return;
    }
    self.isAnimating = YES;
    self.dismissTimer = nil;
    [UIView animateWithDuration:defaultAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect frame = self.frame;
        frame.origin.y -= frame.size.height;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [[[[UIApplication sharedApplication] delegate] window] setWindowLevel:UIWindowLevelNormal];
        self.isAnimating = NO;
        if (completion) {
            completion();
        }
    }];
    
}





- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.numberOfLines = 1;
        _titleLabel.font = self.titleFont;
        _titleLabel.textColor = self.titleTextColor;
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel{
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc]init];
        _subtitleLabel.backgroundColor = [UIColor clearColor];
        _subtitleLabel.numberOfLines = 1;
        _subtitleLabel.font = self.subtitleFont;
        _subtitleLabel.textColor = self.subtitleTextColor;
    }
    return _titleLabel;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.layer.cornerRadius = 3;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

- (void)setDismissTimer:(NSTimer *)dismissTimer{
    if(_dismissTimer.isValid){
        [_dismissTimer invalidate];
    }
    _dismissTimer = dismissTimer;
}

- (void)setTitleFont:(UIFont *)titleFont{
    _titleFont = titleFont;
    [self.titleLabel  setFont:titleFont];
}

- (void)setTitleTextColor:(UIColor *)titleTextColor
{
    _titleTextColor = titleTextColor;
    [_titleLabel setTextColor:titleTextColor];
}

- (void)setSubtitleFont:(UIFont *)subtitleFont{
    _subtitleFont = subtitleFont;
    [self.subtitleLabel setFont:subtitleFont];
}

- (void)setSubtitleTextColor:(UIColor *)subtitleTextColor{
    _subtitleTextColor = subtitleTextColor;
    [self.subtitleLabel setTextColor:subtitleTextColor];
}

+ (void)showWithImage:(UIImage * _Nullable)image title:(NSString * _Nullable)title message:(NSString * _Nullable)message duration:(NSTimeInterval)duration iconSize:(CGSize)iconSize onTap:(void (^ _Nullable)(void))onTap{
    
    [[NBNotificationView sharedNotification] showWithImage:image title:title message:message duration:duration iconSize:iconSize onTap:onTap];
    
}

+ (void)hideWithCompletion:(void (^ _Nullable)(void))completion{
    [[NBNotificationView sharedNotification] hideWithCompletion:completion];
}



@end
