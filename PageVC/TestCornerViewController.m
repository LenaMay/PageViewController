//
//  TestCornerViewController.m
//  PageVC
//
//  Created by Lina on 2018/12/25.
//  Copyright © 2018 Lina. All rights reserved.
//

#import "TestCornerViewController.h"

@interface TestCornerViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TestCornerViewController
- (void)setName:(NSString *)name{
    NSLog(@"TestCornerViewController setname");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource =self;
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell  = [tableView  dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        for (int i = 0; i<7; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10 + i*50, 0, 40, 40)];
            [imageView setImage:[UIImage imageNamed:@"ic_1024"]];

            //第一种
//            [imageView.layer setMasksToBounds:YES];
//            [imageView.layer setCornerRadius:20];
//
            //第二种
//            CAShapeLayer *maskLayer = [CAShapeLayer layer];
//            maskLayer.frame =imageView.bounds;
//            UIBezierPath *maskPath = [UIBezierPath  bezierPathWithRoundedRect:imageView.bounds cornerRadius:20];
//            maskLayer.path = maskPath.CGPath;
//            [imageView.layer setMask:maskLayer];
//
            //第三种
            //开始对imageView进行画图
            UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, NO, 1.0);
            //使用贝塞尔曲线画出一个圆形图
            [[UIBezierPath bezierPathWithRoundedRect:imageView.bounds cornerRadius:imageView.frame.size.width] addClip];
            [imageView drawRect:imageView.bounds];
            imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            //结束画图
            UIGraphicsEndImageContext();
            
            [cell addSubview:imageView];
        }
       
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
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
