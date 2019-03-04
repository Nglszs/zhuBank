//
//  CoinMemberSucceedViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/4.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinMemberSucceedViewController.h"

@interface CoinMemberSucceedViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation CoinMemberSucceedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购买会员卡成功";
    [self SetReturnButton];
    [self SetNavTitleColor];
    [self initView];
}
- (void)initView{
    UICollectionViewFlowLayout * flow = [UICollectionViewFlowLayout new];
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flow];
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.copy);
    }];
    [self initHeaderView];
    
}
- (void)initHeaderView{
    
    
}
@end
