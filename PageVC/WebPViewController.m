//
//  WebPViewController.m
//  PageVC
//
//  Created by zhanglina on 2019/4/23.
//  Copyright © 2019 Lina. All rights reserved.
//

#import "WebPViewController.h"
#import "UserLayerViewController.h"
#import <Lottie/Lottie.h>
#import "NSDate+Category.h"


@interface WebPViewController ()<UIScrollViewDelegate>
{
    LOTPointInterpolatorCallback *_positionInterpolator;
    LOTAnimationView *_boatLoader;
    NSInteger _currentIndex;
}
@property (nonatomic, strong) YYAnimatedImageView *imageView;
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation WebPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDate *data = [NSDate date];
    NSDate *weak = data.beginningOfWeek;
    NSString *str = [data formattedTime];
    
    
    
    
    
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
    
    LOTComposition *co = [LOTComposition animationNamed:@"haokekeke"];
    LOTAnimatedControl *heartIcon = [[LOTAnimatedControl alloc]init];
    [heartIcon setFrame:CGRectMake(0, 450, 70, 70)];
    [heartIcon setAnimationComp:co];
    [heartIcon addTarget:self action:@selector(selectAni:) forControlEvents:UIControlEventTouchUpInside];
    heartIcon.tag  = 100 +1;
    [self.view addSubview:heartIcon];
    
    LOTComposition *co1 = [LOTComposition animationNamed:@"kecheng"];
    LOTAnimatedControl *heartIcon1 = [[LOTAnimatedControl alloc]init];
    [heartIcon1 setFrame:CGRectMake(80, 450, 70, 70)];
    [heartIcon1 setAnimationComp:co1];
    [heartIcon1 addTarget:self action:@selector(selectAni:) forControlEvents:UIControlEventTouchUpInside];
    heartIcon1.tag  = 100 +1;
    [self.view addSubview:heartIcon1];
    
    LOTComposition *co2 = [LOTComposition animationNamed:@"faxian"];
    LOTAnimatedControl *heartIcon2 = [[LOTAnimatedControl alloc]init];
    [heartIcon2 setFrame:CGRectMake(160, 450, 70, 70)];
    [heartIcon2 setAnimationComp:co2];
    [heartIcon2 addTarget:self action:@selector(selectAni:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:heartIcon2];
     heartIcon2.tag  = 100 +2;
    
    LOTComposition *co3 = [LOTComposition animationNamed:@"zhanghu"];
    LOTAnimatedControl *heartIcon3 = [[LOTAnimatedControl alloc]init];
    [heartIcon3 setFrame:CGRectMake(240, 450, 70, 70)];
    [heartIcon3 setAnimationComp:co3];
    [heartIcon3 addTarget:self action:@selector(selectAni:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:heartIcon3];
    heartIcon3.tag  = 100 +2;
    
}

- (void)selectAni:(LOTAnimatedControl *)con{
//    [con.animationView ]
    [con.animationView play];
//    [con.animationView playFromProgress:0 toProgress:1 withCompletion:^(BOOL animationFinished) {
//    }];
//    [con2.animationView stop];
    return;
//    LOTAnimatedControl *con1  = (LOTAnimatedControl *)[self.view viewWithTag:101];
//    LOTAnimatedControl *con2  = (LOTAnimatedControl *)[self.view viewWithTag:102];
//    if (!con.selected) {
//          con.selected = !con.selected;
//        if (con.tag == 101) {
//            [con1.animationView playFromProgress:0 toProgress:1 withCompletion:^(BOOL animationFinished) {
//            }];
//            [con2.animationView stop];
//            con2.selected = NO;
//        }else{
//            [con2.animationView playFromProgress:0 toProgress:1 withCompletion:^(BOOL animationFinished) {
//            }];
//            [con1.animationView stop];
//            con1.selected = NO;
//        }
//    }
}

- (void)play:(UIButton *)sender{
//    [_imageView startAnimating];
    // Create Boat Animation
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [scrollView setBackgroundColor:[UIColor whiteColor]];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(DEVICE_SCREEN_WIDTH * 3, self.view.size.height);
    [self.view addSubview:scrollView];
    _array = [NSMutableArray array];
    for (int i = 0; i<3; i++) {
        LOTAnimationView *load = [LOTAnimationView animationNamed:[NSString stringWithFormat:@"data%d",i+1]];
        load.tag = 888+i;
        [load setFrame:CGRectMake(i*DEVICE_SCREEN_WIDTH, 0, self.view.size.width, self.view.size.height)];
        load.loopAnimation = NO;
        [scrollView addSubview:load];
        [_array addObject:load];
    }
    _currentIndex =0;
    LOTAnimationView *load = [_array objectAtIndex:_currentIndex];
    [self playAni:load];
    
}

- (void)playAni:(LOTAnimationView *)load {
    weakifyself
    if (_currentIndex == 0) {
        [load playToFrame:@(37) withCompletion:^(BOOL animationFinished) {
            strongifyself
            [self updateLoop];
            
        }];
    }else if(_currentIndex == 1){
//        [load playToProgress:1 withCompletion:^(BOOL animationFinished) {
//            strongifyself
////            [self updateLoop];
//        }];
       [load playToFrame:@(37) withCompletion:^(BOOL animationFinished) {
            strongifyself
            [self updateLoop];

        }];
    }
    else if(_currentIndex == 2){
//        [load playToProgress:0.6 withCompletion:^(BOOL animationFinished) {
//            strongifyself
//            [self updateLoop];
//        }];
        [load playToFrame:@(30) withCompletion:^(BOOL animationFinished) {
            strongifyself
            [self updateLoop];

        }];
    }
   
}

- (void)updateLoop{
    LOTAnimationView *load = [_array objectAtIndex:_currentIndex];
    if (_currentIndex == 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //通知主线程刷新
            load.loopAnimation = YES;
            load.autoReverseAnimation  = YES;
            [load playFromFrame:@(37) toFrame:@(67) withCompletion:^(BOOL animationFinished) {
                
            }];
        });
    }else if(_currentIndex == 1){
        dispatch_async(dispatch_get_main_queue(), ^{
            //通知主线程刷新
            load.loopAnimation = YES;
            load.autoReverseAnimation  = YES;
//            [load playFromProgress:0.6 toProgress:0.9 withCompletion:^(BOOL animationFinished) {
//
//            }];
            
            [load playFromFrame:@(37) toFrame:@(66) withCompletion:^(BOOL animationFinished) {

            }];
        });
    }else if(_currentIndex == 2){
        dispatch_async(dispatch_get_main_queue(), ^{
            //通知主线程刷新
            load.loopAnimation = YES;
            load.autoReverseAnimation  = YES;
//            [load playFromProgress:0.6 toProgress:0.9 withCompletion:^(BOOL animationFinished) {
//
//            }];
            [load playFromFrame:@(30) toFrame:@(57) withCompletion:^(BOOL animationFinished) {

            }];
        });
    }
    
   
   
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/DEVICE_SCREEN_WIDTH;
    _currentIndex = index;
    LOTAnimationView *load = [_array objectAtIndex:index];
    if (load.isAnimationPlaying) {

    }else{
         [self playAni:load];
    }
   
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
