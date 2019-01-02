//
//  UserLayerViewController.m
//  PageVC
//
//  Created by Lina on 2018/9/17.
//  Copyright © 2018年 Lina. All rights reserved.
//


#import "UserLayerViewController.h"
@interface UserLayerViewController()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *clockView;
@property (nonatomic, strong) UIImageView *shi;
@property (nonatomic, strong) UIImageView *fen;
@property (nonatomic, strong) UIImageView *miao;
@end

@implementation UserLayerViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor redColor]];
    
    UIButton  *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setFrame:CGRectMake(10, 70, 80, 30)];
    [button1 setTitle:@"寄宿图" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(jisu) forControlEvents:UIControlEventTouchUpInside];
  
    
    UIButton  *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"模拟时钟" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(170, 70, 80, 30)];
    [button addTarget:self action:@selector(clock) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button1];
    [self.view addSubview:button];

 
}


- (void)jisu{
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(50, 110, 300, 300)];
    [_backView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_backView];
    //    CALayer *blueLayer = [CALayer layer];
    //    blueLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    //    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    //    [backView.layer addSublayer:blueLayer];
    
    //
    UIImage *image = [UIImage imageNamed:@"ic_xueyuan"];
    _backView.layer.contents = (__bridge id) [image CGImage];
    _backView.layer.contentsGravity = kCAGravityResizeAspect;
    _backView.layer.contentsScale = image.scale;
    [_backView.layer setMasksToBounds:YES];
    _backView.layer.contentsRect = CGRectMake(0,0 ,1, 1);
    _backView.layer.contentsCenter = CGRectMake(0,0.5, 0.5, 0.5);
    
    //    [backView setClipsToBounds:YES];
    //    blueLayer.delegate = self;
    //    [blueLayer display];
}

- (void)clock{
//    if (_backView) {
//        [_backView removeFromSuperview];
//    }
    UIImage *image = [UIImage imageNamed:@"1"];
    _clockView   = [[UIView alloc]initWithFrame:CGRectMake(50, 120, 300, 300)];
    _clockView.layer.contents = (__bridge id) [image CGImage];
    _clockView.layer.contentsGravity = kCAGravityResizeAspect;
    [self.view addSubview:_clockView];
    self.shi = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 100)];
    self.shi.center = CGPointMake(150, 150);
    self.shi.image = [UIImage imageNamed:@"2"];
    
    self.fen = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 120)];
    self.fen.center = CGPointMake(150, 150);;
    self.fen.image = [UIImage imageNamed:@"4"];
    
    self.miao = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 140)];
    self.miao.center =CGPointMake(150, 150);;
    self.miao.image = [UIImage imageNamed:@"3"];
    
    self.shi.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    self.fen.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    self.miao.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    
    [self.clockView addSubview:self.shi];
    [self.clockView addSubview:self.fen];
    [self.clockView addSubview:self.miao];
    
    NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(trick) userInfo:nil repeats:YES];
    [self trick];

}

- (void)trick{
    
    NSCalendar *ca = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [ca components:units fromDate:[NSDate date]];
    CGFloat hoursAngle = (components.hour / 12.0) * M_PI * 2.0;
    CGFloat minsAngle = (components.minute / 60.0) * M_PI * 2.0;
    CGFloat secsAngle = (components.second / 60.0) * M_PI * 2.0;
    
     self.shi.transform = CGAffineTransformMakeRotation(hoursAngle);
    self.fen.transform = CGAffineTransformMakeRotation(minsAngle);
    self.miao.transform = CGAffineTransformMakeRotation(secsAngle);

}



- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    //draw a thick red circle
    CGContextSetLineWidth(ctx, 10.0f);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}



@end
