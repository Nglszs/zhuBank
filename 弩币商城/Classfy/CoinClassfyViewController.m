//
//  CoinClassfyViewController.m
//  弩币商城
//
//  Created by Jack on 2019/2/25.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinClassfyViewController.h"
#import "CoinClassfyLeftTVCell.h"
@interface CoinClassfyViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)UICollectionView * CollectionView;
@property (nonatomic,strong)NSIndexPath * selectIndex;
@end

@implementation CoinClassfyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    [self initTableView];
//    [self initCollectionView];
}

- (void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.view);
        make.width.mas_offset(88);
    }];
    
    self.tableView.tableFooterView = [UIView new];
  
}

- (void)initCollectionView{
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc] init];
    self.CollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flow];
    self.CollectionView.delegate = self;
    self.CollectionView.dataSource = self;
    [self.view addSubview:self.CollectionView];
    
}


#pragma mark  tableview  delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CoinClassfyLeftTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CoinClassfyLeftTVCell"];
    if (cell == nil) {
        cell = [[CoinClassfyLeftTVCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"CoinClassfyLeftTVCell"];
        
    }
    if (indexPath.row == self.selectIndex.row) {
        cell.isSelect = YES;
    }else{
        cell.isSelect = NO;
    }
    cell.selectionStyle =   UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectIndex = indexPath;
    [self.tableView reloadData];
}
#pragma mark    CollectionView   delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 9;
}

@end
