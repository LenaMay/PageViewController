//
//  DetailViewController.m
//  PageVC
//
//  Created by Lina on 16/4/28.
//  Copyright © 2016年 Lina. All rights reserved.
//

#import "DetailViewController.h"
#import "NBNotificationView.h"
#import "WebPViewController.h"

@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    
    UIButton *nameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nameBtn setFrame:CGRectMake(0, 250, 60, 35)];
    [nameBtn setTitle:@"show" forState:UIControlStateNormal];
    [nameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nameBtn setBackgroundImage:[UIImage imageNamed:@"btn_deepblue_normal"] forState:UIControlStateNormal];
    [nameBtn setBackgroundImage:[UIImage imageNamed:@"btn_deepblue_normal"] forState:UIControlStateHighlighted];
    [nameBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nameBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(200, 250, 60, 35)];
    [rightBtn setTitle:@"hide" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"btn_deepblue_normal"] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"btn_deepblue_normal"] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(hideBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    
    
  UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(50,100, 200,100 ) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    [tableView setBackgroundColor:[UIColor clearColor]];
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *string = @"cell";
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:string];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:string];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    [cell.textLabel setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}



- (void)cancelBtnAction:(UIButton *)sender{
    [NBNotificationView showWithImage:[UIImage imageNamed:@""] title:@"测试测试" message:@"hahahahhahahhahshshhhdh" duration:10 iconSize:CGSizeMake(20, 20) onTap:^{
    }];

}
- (void)hideBtnAction:(UIButton *)sender{
    WebPViewController *vc = [[WebPViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
    
    return;
    [NBNotificationView hideWithCompletion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
