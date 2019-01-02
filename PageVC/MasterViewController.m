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


@interface MasterViewController ()

@property NSArray *objects;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    id array = [[NSMutableArray alloc]init];
    void ( ^blk)(void) = ^{
        NSString *str = @"fdf";
        [array addObject:str];
    };
    NSLog(@"after=%@",array);
    blk();
    NSLog(@"before=%@",array);


    _objects = @[@"仿淘宝APP内弹消息窗口",@"扫描二维码",@"今日头条翻页",@"遮罩",@"图层树",@"视觉效果",@"圆角测试"];
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


@end
