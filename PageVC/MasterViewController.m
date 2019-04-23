//
//  MasterViewController.m
//  PageVC
//
//  Created by Lina on 16/4/28.
//  Copyright © 2016年 Lina. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "ScanQRViewController.h"
#import "LNZheZhaoViewController.h"
#import "UserLayerViewController.h"
#import "ShiJueViewController.h"
#import "TestCornerViewController.h"
#import "NSArray+NOCrash.h"
#import "MessageforWardVC.h"
#import "WXApi.h"
#import "WebPViewController.h"




@interface MasterViewController ()

@property NSArray *objects;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
//    [self testArrayCrash];
//    [self test_block];
//    return;
//    [self testIsEquel];
//    [self testBlockFanhuizhileixing];

  



    _objects = @[@"仿淘宝APP内弹消息窗口",@"扫描二维码",@"今日头条翻页",@"遮罩",@"图层树",@"视觉效果",@"圆角测试",@"字典和数组 崩溃问题",@"理解消息转发机制",@"加载webp动态图"];
    
    
}


- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)jiance{
    NSString *str = @"www.baidu.comdhfjdfj17701031767";
    //根据检测的类型初始化 这里是检测电话号码和网址
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypePhoneNumber | NSTextCheckingTypeLink error:nil];
    //获得检测所得到的数组  range 是你想要检测的字符串的位置和长度；
    NSArray *matches = [detector matchesInString:str options:0 range:NSMakeRange(0, [str length])];
    
    for (NSTextCheckingResult *match in matches) {
        
        //当match匹配为网址时设置颜色
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
        
        if ([match resultType] == NSTextCheckingTypeLink) {
            
            NSRange matchRange = [match range];
            //这里可以自行设置
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:matchRange];
            [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:matchRange];
        }
        //当match匹配为电话号码时设置其attribute
        if ([match resultType] == NSTextCheckingTypePhoneNumber) {
            
            NSRange matchRange = [match range];
            //这里可以自行设置
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:matchRange];
            [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:matchRange];
        }
    }
    //设置label的内容
    //textLabel.attributedText = attributedString;
}
    
    
    
- (BOOL)isIndex:(CFIndex)index inRange:(NSRange)range
    
{
  return index > range.location && index < range.location+range.length;
}
    

            


#pragma mark - Segues

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = self.objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            [self toDetailVC];
            break;
        case 1:
            [self toScanQR];
            break;
        case 2:
            [self toScanQR];
            break;
        case 3:
            [self tozhezhao];
            break;
        case 4:
            [self tolayer];
            break;
        case 5:
            [self toshijue];
            break;
        case 6:
            [self testCorner];
            break;
        case 7:
            [self testArrayCrash];
            break;
            
        case 8:
            [self testMessageForward];
            break;
        case 9:
            [self testWebP];
            break;
            
        default:
            break;
    }

}

- (void)toDetailVC{
    DetailViewController *vc = [[DetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)toScanQR{
    

    
    
    ScanQRViewController *vc = [[ScanQRViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tozhezhao{
    LNZheZhaoViewController *vc = [[LNZheZhaoViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tolayer{
    UserLayerViewController *vc = [[UserLayerViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)toshijue{
    ShiJueViewController *vc = [[ShiJueViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)testCorner{
    TestCornerViewController *vc = [[TestCornerViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)testWebP{
    WebPViewController *vc = [[WebPViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)testArrayCrash{
    NSString *s = nil;
    NSArray *array = @[@"43",@"wrq",s];
    NSMutableArray *muarray = [NSMutableArray arrayWithObject:@"23"];
    [muarray addObject:s];
    NSString *str = [array objectAtIndex:2];
    NSString *mustr = [muarray objectAtIndex:2];
    NSLog(@"%@,%@",str,muarray);
    //以上为数组的，字典同理l也可以是用runtime机制替换对应方法
    
}

- (void)testMessageForward{
    MessageforWardVC *vc = [[MessageforWardVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)test_block{
    
    NSString *str1 = @"11111";
    __weak  NSString *str2 = @"222222";
    __block  NSString *str3 = @"33333";
    
    NSMutableString *mstr1 = [NSMutableString stringWithString:@"mmmmm1"];
    __weak NSMutableString *mstr2 = [NSMutableString stringWithString:@"mmmmm2"];
    __block NSMutableString *mstr3 = [NSMutableString stringWithString:@"mmmmm3"];
    NSArray *array = @[@"123"];
    void ( ^blk)(void) = ^{
        //        str1 = @"block";
        //        str2 = @"block";
        str3 = @"block";
        [mstr2 appendString:@"block"];
        [mstr3 appendString:@"block"];
         NSLog(@"array ==%@",array);
        NSLog(@"str1 ==%@",str1);
        NSLog(@"str2 ==%@",str2);
        NSLog(@"str3 ==%@",str3);
        NSLog(@"mstr1 ==%@",mstr1);
        NSLog(@"mstr2 ==%@",mstr2);
        NSLog(@"mstr3 ==%@",mstr3);
    };

    
    blk();
    str1 = @"str1变了";
    str2 = @"str2变了";
    str3 = @"str3变了";
    mstr1 = [NSMutableString stringWithString:@"mmstr1\mmmm1"];
//    [mstr1 appendString:@"mstr1变了"];
    [mstr2 appendString:@"mstr2变了"];
    [mstr3 appendString:@"mstr3变了"];
    array = @[@"4.5.6"];
    blk();

}

- (void)testIsEquel{
    ShiJueViewController *vc = [[ShiJueViewController alloc]init];
    ShiJueViewController *vc1 = [[ShiJueViewController alloc]init];
    NSArray *a = @[@1];
    NSArray *b = a;
    NSArray *c = @[@1];
    if (a==b) {NSLog(@"a ==b");} //YES
    if (a==c) {NSLog(@"a==c");} //NO
    if ([a isEqual:b]) {NSLog(@"a isEqual: b");} //YES
    if ([a isEqual:c]) {NSLog(@"a isEqual: c");}//YES
    if ([vc isEqual:vc1]) {NSLog(@"vc isEqual: vc1");}//NO
    // == 指针相同      重写“isEqual”方法就是提供自定义的相等标准
}

- (void)testBlockFanhuizhileixing{
    //正确
    id  s  =   ^(int i){
        return @"3355";
    };
    
    //错误
//    id  s1  =   ^(int i){
//        if (i==1) {
//            return @"3355";
//        }else{
//            return @(2);
//        }
//    };
}


@end
