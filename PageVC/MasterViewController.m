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


@interface MasterViewController ()

@property NSArray *objects;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    _objects = @[@"仿淘宝APP内弹消息窗口",@"扫描二维码",@"今日头条翻页",@"相册选照片"];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            [self toSelectphoto];
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

- (void)toSelectphoto{
    
}

@end
