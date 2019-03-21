//
//  LNZheZhaoViewController.m
//  PageVC
//
//  Created by Lina on 2018/7/18.
//  Copyright © 2018年 Lina. All rights reserved.
//

#import "LNZheZhaoViewController.h"

@interface LNZheZhaoViewController ()
@property (nonatomic, strong) UIImageView * imageView;
@end

@implementation LNZheZhaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self zhezhao];
    [self yinying];
    // Do any additional setup after loading the view.
 

}




- (void)yinying{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIView *shadowView =[[UIView alloc]initWithFrame:CGRectMake(30, 200, 200, 50)];
//    [shadowView setBackgroundColor:[UIColor redColor]];
    
    
//    UIView *shadowLeft  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 50)];
//    [shadowLeft setBackgroundColor:[UIColor whiteColor]];
//    shadowLeft.layer.shadowColor = [UIColor blackColor] .CGColor;
//    shadowLeft.layer.shadowOpacity = 0.2;
//    shadowLeft.layer.shadowRadius = 10;
//    //    shadowView.layer.shadowOffset = CGSizeZero;
//    CGRect shadowRectLeft = CGRectMake(-3,0,5, 50);
//    UIBezierPath *pathLeft =[UIBezierPath bezierPathWithRect:shadowRectLeft];
//    shadowLeft.layer.shadowPath = pathLeft.CGPath;
//    [shadowView addSubview:shadowLeft];
    
    UIView *shadowRight  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 50)];
    [shadowRight setBackgroundColor:[UIColor whiteColor]];
    shadowRight.layer.shadowColor = [UIColor blackColor] .CGColor;
    shadowRight.layer.shadowOpacity = 0.2;
    shadowRight.layer.shadowRadius = 10;
    //    shadowView.layer.shadowOffset = CGSizeZero;
    CGRect shadowRectRight = CGRectMake(50,50 + 3,100, 10);
    UIBezierPath *pathRight =[UIBezierPath bezierPathWithRect:shadowRectRight];

 UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:shadowRectRight byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5,5)];
    shadowRight.layer.shadowPath = pathRight.CGPath;
    [shadowView addSubview:shadowRight];
    
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    [contentView setBackgroundColor:[UIColor redColor]];
    [shadowView addSubview:contentView];
    [self.view addSubview:shadowView];
    
    
    
//
//    [shadowView setBackgroundColor:[UIColor whiteColor]];
//    shadowView.layer.shadowColor = [UIColor blackColor] .CGColor;
//    shadowView.layer.shadowOpacity = 0.2;
//    shadowView.layer.shadowRadius = 10;
////    shadowView.layer.shadowOffset = CGSizeZero;
//    CGRect shadowRect  = CGRectMake(0, -3,200, 5);
//    UIBezierPath *path =[UIBezierPath bezierPathWithRect:shadowRect];
////    UIBezierPath *path =[[UIBezierPath alloc] init];
////    [path moveToPoint:CGPointMake(-5, 50)];
////    [path addLineToPoint:CGPointMake(-5, 0)];
////    [path addLineToPoint:CGPointMake(200 +5, -5)];
////    [path addLineToPoint:CGPointMake(200 +5, 50)];
//    shadowView.layer.shadowPath = path.CGPath;
//    [self.view addSubview:shadowView];
    
//    UIView *contentView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
//    [contentView1 setBackgroundColor:[UIColor whiteColor]];
//    UIView *shadowView1 =[[UIView alloc]initWithFrame:CGRectMake(30, 250, 200, 50)];
//    [shadowView1 addSubview:contentView1];
//    [shadowView1 setBackgroundColor:[UIColor clearColor]];
//    shadowView1.layer.shadowColor = [UIColor blackColor] .CGColor;
//    shadowView1.layer.shadowOpacity = 0.2;
//    shadowView1.layer.shadowRadius = 16;
//    //    shadowView.layer.shadowOffset = CGSizeZero;
//    CGRect shadowRect  = CGRectMake(0, -3,200, 5);
//    UIBezierPath *path =[UIBezierPath bezierPathWithRect:shadowRect];
//    UIBezierPath *path1 =[[UIBezierPath alloc] init];
//    [path1 moveToPoint:CGPointMake(-5, 50)];
//    [path1 addLineToPoint:CGPointMake(-5, - 5)];
//    [path1 addLineToPoint:CGPointMake(200, - 5)];
//    [path1 addLineToPoint:CGPointMake(200 +5, -5)];
//    [path1 addLineToPoint:CGPointMake(200 +5, 50)];
//    shadowView1.layer.shadowPath = path1.CGPath;
//    [self.view addSubview:shadowView1];
    
}



-(void)zhezhao{
    
    _imageView  = [[UIImageView alloc]initWithFrame:CGRectMake(20, 70, 400, 400)];
    [_imageView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.imageView];
    CALayer *imagelayer = [[CALayer alloc]init];
    [imagelayer setFrame:self.imageView.bounds];
    [imagelayer setBackgroundColor:[UIColor blueColor].CGColor];
    CAShapeLayer *shapeLay = [[CAShapeLayer alloc]init];
    [shapeLay setFrame:self.imageView.bounds];
    [shapeLay setBackgroundColor:[UIColor orangeColor].CGColor];
    shapeLay.strokeColor = [UIColor blueColor].CGColor;
    //    shapeLay.fillColor = nil;
    
    
    // 创建一个全屏大的path
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(60, 80, 100, 100)];
    //    // 创建一个圆形path
    //    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x/2, self.center.y *3/2)radius:SCREEN_WIDTH/5 startAngle:0 endAngle:2 * M_PI clockwise:NO];
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.imageView.center.x/2, self.imageView.center.y *3/2)radius:100/5 startAngle:0 endAngle:2 * M_PI clockwise:NO];
    
    //    shapeLay.path = path.CGPath;
    //    [path setUsesEvenOddFillRule:YES];
    shapeLay.path = circlePath.CGPath;
    shapeLay.fillRule = kCAFillRuleEvenOdd;
    shapeLay.fillColor = [UIColor blackColor].CGColor;
    imagelayer.mask = shapeLay;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
