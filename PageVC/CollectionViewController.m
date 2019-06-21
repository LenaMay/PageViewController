//
//  CollectionViewController.m
//  PageVC
//
//  Created by zhanglina on 2019/6/20.
//  Copyright © 2019 Lina. All rights reserved.
//

#import "CollectionViewController.h"
#import "VoiceBookCollectionViewCell.h"
#import "BooksCollectionViewFlowLayout.h"


@interface CollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *array;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    _array = @[@{@"name":@"21"},@{@"name":@"21"},@{@"name":@"21"},@{@"name":@"21"},@{@"name":@"21"},@{@"name":@"21"},@{@"name":@"21"},@{@"name":@"21"},@{@"name":@"21"},@{@"name":@"21"},@{@"name":@"21"},@{@"name":@"21"}];
    [self.collectionView registerClass:[VoiceBookCollectionViewCell class] forCellWithReuseIdentifier:@"VoiceBookCollectionViewCell"];
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        BooksCollectionViewFlowLayout *layout  = [[BooksCollectionViewFlowLayout alloc] init];
        // 设置每个item的大小
        layout.itemSize = CGSizeMake(70,90);
        layout.minimumInteritemSpacing = 20;
        // 设置行间距
        layout.minimumLineSpacing = 10;
        // 设置布局方向(滚动方向)
//        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.size.width, self.view.size.height) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    VoiceBookCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VoiceBookCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
  
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"这是第%ld个",(long)indexPath.item);
     NSLog(@"这是第%ld个section",(long)indexPath.section);
    NSLog(@"这是第%ld个row",(long)indexPath.row);
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
