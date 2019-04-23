//
//  WebPViewController.m
//  PageVC
//
//  Created by zhanglina on 2019/4/23.
//  Copyright © 2019 Lina. All rights reserved.
//

#import "WebPViewController.h"
#import "UserLayerViewController.h"

@interface WebPViewController ()
@property (nonatomic, strong) YYAnimatedImageView *imageView;
@end

@implementation WebPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _imageView = [[YYAnimatedImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:_imageView];
    YYImage *image = [YYImage imageNamed:@"animated_maomao"];
   _imageView.image = image;
    [_imageView setAutoPlayAnimatedImage:NO];
    [_imageView addObserver:self forKeyPath:@"currentAnimatedImageIndex" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    NSInteger count =  _imageView.animationImages.count;
    NSLog(@"-------%ld-------%f",(long)_imageView.maxBufferSize,_imageView.animationDuration);
   
    
    
    UIButton *playbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [playbtn setFrame:CGRectMake(250,100, 100, 50)];
    [playbtn setTitle:@"play" forState:UIControlStateNormal];
    [playbtn setTitle:@"stop" forState:UIControlStateSelected];
    [playbtn addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playbtn];
    
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(100, 250, 100, 100)];
    [self.view addSubview:imageView1];
    imageView1.image = [YYImage imageNamed:@"animated-gif-0"];
}

- (void)play:(UIButton *)sender{
    [_imageView startAnimating];
//    if (!sender.isSelected) {
//        [_imageView startAnimating];
//    }else{
//        [_imageView stopAnimating];
//    }
//    sender.selected = !sender.isSelected;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"%@",keyPath);
    NSLog(@"%@",change);
    if([[change valueForKey:@"new"] integerValue] == [[_imageView valueForKey:@"_totalFrameCount"] integerValue]-1){
        [_imageView stopAnimating];
    }
    NSInteger count =  _imageView.animationImages.count;
   NSLog(@"-------%ld-------%f",(long)[[_imageView valueForKey:@"_totalFrameCount"] integerValue],_imageView.animationDuration);
}

@end
