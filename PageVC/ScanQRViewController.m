//
//  ScanViewController.m
//  二维码
//
//  Created by zhanglina on 15/4/9.
//  Copyright (c) 2015年 张丽娜. All rights reserved.
//

#import "ScanQRViewController.h"

#import "UIAlertView+Block.h"


@interface ScanQRViewController ()<UIAlertViewDelegate>
{
    UIView *_scanContaionView;
    UINavigationItem *_customNavItem;
    UILabel *_titleLabel;
    BOOL _isHide;

}
@property (nonatomic, strong) AVCaptureDevice * device;
@property (nonatomic, strong) AVCaptureDeviceInput * input;
@property (nonatomic, strong) AVCaptureMetadataOutput * output;
@property (nonatomic, strong) AVCaptureSession * session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, retain) UIImageView * line;
@property (nonatomic, strong) UINavigationBar  *customNavBar;//自定义导航栏
@property (nonatomic, strong) UILabel *nonetNoticelabel;
@property (nonatomic, strong) NSString *scanStr;//扫描成功后的数据
;



@end

@implementation ScanQRViewController
- (void)dealloc{
    [self clear];
}

-  (void)clear
{
    _device =  nil;
    if (_session) {
        if (_session.running) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [_session stopRunning];
            });
        }
    }
    _session = nil;
    _input = nil;
    _output  = nil;
    [_preview removeFromSuperlayer];
    _preview = nil;
    [_line removeFromSuperview];
    _line = nil;
    
    if (timer) {
         [timer  invalidate];
    }
    timer = nil;
}

- (UILabel *)nonetNoticelabel{
    
    if (!_nonetNoticelabel) {
        _nonetNoticelabel  = [[UILabel alloc]initWithFrame:CGRectMake(self.view.current_w /2- 100,(self.view.frame.size.height-kNavBarHeight)/2,200, 60)];
        [_nonetNoticelabel setCenterY:(self.view.frame.size.height-kNavBarHeight)/2];
        [_nonetNoticelabel setText:@"连接失败，请检查网络"];
        [_nonetNoticelabel setBackgroundColor:[UIColor blackColor]];
        [_nonetNoticelabel setTextAlignment:NSTextAlignmentCenter];
        [_nonetNoticelabel.layer setMasksToBounds:YES];
        [_nonetNoticelabel.layer setCornerRadius:6];
        [_nonetNoticelabel setFont:UIFont_Font(16)];
        [_nonetNoticelabel setTextColor:[UIColor whiteColor]];
        [self.view insertSubview:_nonetNoticelabel atIndex:0];
    }
    return _nonetNoticelabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"扫描二维码"];

    self.view.backgroundColor = [UIColor blackColor];
    UIView *backView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,  (self.view.frame.size.height-kNavBarHeight)/2-220*KSCALE/2)];
    [backView1 setBackgroundColor:[UIColor blackColor]];
    [backView1 setAlpha:0.5];
    [self.view addSubview:backView1];
    UIView *backView2 = [[UIView alloc]initWithFrame:CGRectMake(0,backView1.current_y_h, self.view.frame.size.width/2-220*KSCALE/2,220*KSCALE)];
    [backView2 setAlpha:0.5];
    [backView2 setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:backView2];
    UIView *backView3= [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-(self.view.frame.size.width/2-220*KSCALE/2), backView1.current_y_h, self.view.frame.size.width/2-220*KSCALE/2, 220*KSCALE)];
    [backView3 setAlpha:0.5];
    [backView3 setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:backView3];

    UIView *backView4 = [[UIView alloc]initWithFrame:CGRectMake(0, backView2.current_y_h, self.view.frame.size.width,  (self.view.frame.size.height-kNavBarHeight)/2-220*KSCALE/2+64)];
    [backView4 setAlpha:0.5];
    [backView4 setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:backView4];


    
      //扫描框和动画
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-220*KSCALE/2-6,(self.view.frame.size.height-kNavBarHeight)/2-220*KSCALE/2-6, 220*KSCALE+12,220*KSCALE +12)];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.image = [UIImage imageNamed:@"ic_scanbox.png"];
    [self.view addSubview:imageView];
  
    //扫描动画容器
    _scanContaionView =  [[UIView alloc]initWithFrame:CGRectMake(0,0,imageView.size.width-14,imageView.size.height-12)];
    [_scanContaionView setCenter:imageView.current_innerCenter];
    [_scanContaionView setClipsToBounds:YES];
    [_scanContaionView setBackgroundColor:[UIColor clearColor]];
    [imageView addSubview:_scanContaionView];
    
 
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(15,imageView.current_y_h +30, self.view.frame.size.width-40, 50)];
    labIntroudction.backgroundColor = [UIColor clearColor];
    [labIntroudction setFont:[UIFont systemFontOfSize:13]];
    [labIntroudction setTextAlignment:NSTextAlignmentCenter];
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.text=@"将二维码放入框内，即可自动扫描";
    [self.view addSubview:labIntroudction];
    num =0;
    [self setupLine];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self customNavigationBar];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    num = 0;
    [self setupLine];
     if (SYSTEM_VERSION>=7.) {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            NSString *mediaType = AVMediaTypeVideo;
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
            if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
                [self cameraServerEnableWarn];
                return;
            }
        }
        if (_session==nil) {
            [self setupCamera];
        }
    }
    [self startScan];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    [self clear];
}

#pragma  mark -- 设置自定义导航栏
- (void)customNavigationBar
{
    if (self.navigationController) {
        _customNavBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.current_w, SYSTEM_VERSION>=7?64:44)];
        //    //毛玻璃效果
        //    [_customNavBar setTranslucent:YES];
        //    [_customNavBar setShadowImage:nil];
        [_customNavBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin];
        _customNavItem = [[UINavigationItem alloc] init];
        [_customNavBar pushNavigationItem:_customNavItem animated:NO];
        [self.view addSubview:_customNavBar];
        [self setTitle:@"扫描二维码"];
        [self setleftBarItem];
    }
}

- (void)setleftBarItem{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0, 0,30, 44)];
    if (SYSTEM_VERSION<7.) {
      
        [backButton setImage:[UIImage imageNamed:@"ic_back"] forState:UIControlStateNormal];
    }else{
        [backButton setImage:[UIImage imageNamed:@"ic_back"] forState:UIControlStateNormal];
    }
    [backButton addTarget:self action:@selector(onBack:) forControlEvents:UIControlEventTouchUpInside];
    _customNavItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
}

//设置标题和logo
- (void)setTitle:(NSString *)title
{
    //设置标题 else 显示logo
    if (title) {
        //标题
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [_titleLabel setFont:[UIFont systemFontOfSize:18]];
        [_titleLabel setText:title];
        [_customNavItem setTitleView:_titleLabel];
    }
}


- (void)setupCamera
{
    // Device// 获取 AVCaptureDevice 实例
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // Input// 初始化输入流
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    // Output// 初始化输出流
    _output = [[AVCaptureMetadataOutput alloc]init];
    // 创建dispatch queue.
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //    // 创建dispatch queue.
    //    dispatch_queue_t dispatchQueue;
    //    dispatchQueue = dispatch_queue_create(kScanQRCodeQueueName, NULL);
    //    [_output setMetadataObjectsDelegate:self queue:dispatchQueue];
    //    // 设置元数据类型 AVMetadataObjectTypeQRCode
    
    // Session// 创建会话
    _session = [[AVCaptureSession alloc]init];
    
    //向会话中添加输出输入流
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
        // 条码类型 AVMetadataObjectTypeQRCode  // 设置元数据类型 AVMetadataObjectTypeQRCode
        [_output setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode,nil]];
    }
    
    // Preview  // 创建输出对象
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =self.view.bounds;
    [self.view.layer  insertSublayer:_preview atIndex:0];
    [_preview   setOpacity:0];
    
    [ _output setRectOfInterest : CGRectMake (((self.view.frame.size.height-kNavBarHeight)-260*KSCALE)/2/(self.view.frame.size.height-kNavBarHeight) ,(( self.view.frame.size.width - 260*KSCALE)/ 2 )/ self.view.frame.size.width , 260*KSCALE / (self.view.frame.size.height-kNavBarHeight) , 260 *KSCALE/ self.view.frame.size.width )];
    
}


- (void)viewDidLayoutSubviews
{
    [_customNavBar.superview bringSubviewToFront:_customNavBar];
    [self.view layoutIfNeeded];
    [super viewDidLayoutSubviews];
}


#pragma  mark --- 创建subView
- (void)setupLine{
    if (_line) {
        [_line removeFromSuperview];
    }
        _line = [[UIImageView alloc] initWithFrame:CGRectMake(0, -61, _scanContaionView.current_w, 61)];
        [_line setBackgroundColor: [UIColor clearColor]];
        [_line setAlpha:0.7];
        _line.image = [UIImage imageNamed:@"ic_barcode_orange"];
        [_scanContaionView  addSubview:_line];
        ;
}




-(void)animation1
{
    CGFloat height=_scanContaionView.current_h;
    if (num >= height) {
        num= -_line.current_h;
    }else{
        num  = _line.current_y+1*2;
    }
    [_line setY: num ];
    
}


- (void)startScan{
    
    [_line setHidden:NO];
    if (timer==nil) {
        timer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    }
       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (SYSTEM_VERSION>=7.)
        {
            if (!_session.running) {
                [_session startRunning];
            }
            dispatch_async(dispatch_get_main_queue(), ^{

                CABasicAnimation *animation =
                [CABasicAnimation animationWithKeyPath:@"opacity"];
                [animation setToValue:@(1.0)];
                [animation setDuration:0.25];
                [animation setRemovedOnCompletion:NO];
                animation.fillMode = kCAFillModeForwards;
                [_preview addAnimation:animation forKey:nil];
            });
        }
        else{
        }
    });
}


#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
        [_session stopRunning];
        [_line setHidden:YES];
        [timer invalidate];
        timer = nil;
        self.scanStr = stringValue;
        if (self.scanStr ) {
            [self QRVerification];
        }else{
            [self openAgain];
        }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    CGFloat x,y,width,height;
    
    x = rect.origin.x / readerViewBounds.size.width;
    y = rect.origin.y / readerViewBounds.size.height;
    width = rect.size.width / readerViewBounds.size.width;
    height = rect.size.height / readerViewBounds.size.height;
//    NSLog(@"%f,%f,%f,%f",x,y,width,height);
    return CGRectMake(y, x, width, height);
}

//二位码扫描结果验证
- (void)QRVerification{

    if (![NSString isBlankString:self.scanStr ]){
        
        weakifyself
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"" message:self.scanStr delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"跳转", @"复制",nil];
        [av showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            strongifyself
            if (buttonIndex == 1){
//                WebPageViewController *vc = [[WebPageViewController alloc]initWithURL:[NSURL URLWithString:self.scanStr]];
//                [self.navigationController pushViewController:vc animated:YES];
            }else if(buttonIndex == 2){
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = self.scanStr;
                [self openAgain];
            }else{
                [self openAgain];
            }
        }];
    }
}

- (void)showAlterView:(NSString *)message{
   
    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"返回",@"继续扫码",nil];
    [alterView show];
}

- (NSString *)clearUrl:(NSString *)uglyString
{
    NSString *cleanString=[uglyString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return cleanString;
}

- (void)openAgain{
    [self startScan];
    if (timer==nil) {
        timer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    }
}

- (void)cameraServerEnableWarn
{
    UIAlertView * alertView = nil;
    if (SYSTEM_VERSION >= 8.0)
    {
        alertView  = [[UIAlertView alloc]initWithTitle:@"请到设置->隐私->相机中开启【跟谁学机构版】相机服务" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
    }
    else
    {
        alertView = [[UIAlertView alloc]initWithTitle:@"请到设置->隐私->相机中开启【跟谁学机构版】相机服务" message:nil delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    }
    alertView.tag = 200;
    [alertView show];
}

- (void)updateNavArray{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController popViewControllerAnimated:NO];
   
}

- (BOOL)hidesBottomBarWhenPushed
{
    return YES;
}

- (BOOL)shouldHiddenNavigationBar{
    
    return YES;
}


- (void)stopScan{
    
    [timer invalidate];
    [_line setHidden:YES];
    timer = nil;
    if (SYSTEM_VERSION >= 7.)
    {
        if(_session.isRunning){
           [_session stopRunning];
        }
    }

    [_line setHidden:YES];

}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
