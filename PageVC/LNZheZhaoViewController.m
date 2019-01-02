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
    // Do any additional setup after loading the view.
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
