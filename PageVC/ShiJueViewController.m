//
//  ShiJueViewController.m
//  PageVC
//
//  Created by Lina on 2018/9/20.
//  Copyright © 2018年 Lina. All rights reserved.
//

#import "ShiJueViewController.h"

@interface ShiJueViewController ()

@end

@implementation ShiJueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIView *shadowView = [[UIView alloc]initWithFrame:CGRectMake(50, 100, 100, 100)];
    [self.view addSubview:shadowView];
    shadowView.backgroundColor = [UIColor blueColor];
    [shadowView.layer setMasksToBounds:YES];
    UIImage *image1 = [UIImage imageNamed:@"ic_gold medal"];
    shadowView.layer.contents = (__bridge id) [image1 CGImage];
    [shadowView.layer setMasksToBounds:YES];
    shadowView.backgroundColor = [UIColor clearColor];
    [shadowView.layer setShadowOpacity:1];

    UIView *maskView  = [[UIView alloc]initWithFrame:CGRectMake(160,100, 100, 100)];
    [self.view addSubview:maskView];
    UIImage *image = [UIImage imageNamed:@"ic_1024"];
    maskView.layer.contents = (__bridge id) [image CGImage];
    [maskView.layer setMasksToBounds:YES];
    maskView.backgroundColor = [UIColor clearColor];
    [maskView.layer setShadowOpacity:1];
////    [maskView.layer setCornerRadius:50];
//    [maskView.layer setShadowColor:[UIColor blackColor].CGColor];
//    [maskView.layer setShadowOffset:CGSizeMake(5, 5)];
//    [maskView.layer setShadowRadius:3];
    
    
    CGMutablePathRef squarePath = CGPathCreateMutable();
    CGPathAddRect(squarePath, NULL, maskView.bounds);
    maskView.layer.shadowPath = squarePath; CGPathRelease(squarePath);

//     //create a circular shadow
//
//     CGMutablePathRef circlePath = CGPathCreateMutable(); CGPathAddEllipseInRect(circlePath, NULL, shadowView.bounds); shadowView.layer.shadowPath = circlePath; CGPathRelease(circlePath);
    
    
//蒙版
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame =maskView.bounds;

    UIBezierPath *maskPath = [UIBezierPath  bezierPathWithRoundedRect:maskView.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
//     UIBezierPath *maskPath = [UIBezierPath  bezierPathWithRoundedRect:maskView.bounds cornerRadius:10];
    
     maskLayer.path = maskPath.CGPath;
//    UIImage *maskImage = [UIImage imageNamed:@"ic_gold medal"];
//    maskLayer.contents = (__bridge id)maskImage.CGImage;
//    maskLayer.contentsGravity = kCAGravityResizeAspect;
    [maskView.layer setMask:maskLayer];

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
