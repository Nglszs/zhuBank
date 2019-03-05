//
//  CoinMemberSucceedViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/4.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinMemberSucceedViewController.h"
#import "RecommendCommodityCell.h"
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
    
UIView * tempView =     [self HeaderView];
    
    UICollectionViewFlowLayout * flow = [UICollectionViewFlowLayout new];
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flow];
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.top.equalTo(tempView.mas_bottom);
    }];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[RecommendCommodityCell class] forCellWithReuseIdentifier:@"RecommendCommodityCell"];
    
}
- (UIView * )HeaderView{
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.image = BCImage(购买成功);
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(24);
        make.centerX.equalTo(self.view).offset(-50);
        make.width.height.mas_equalTo(25);
    }];
    
    UILabel * MoneyLabel = [UILabel new];
    MoneyLabel.text = @"¥299.00 ";
    MoneyLabel.textColor = COLOR(51, 51, 51);
    MoneyLabel.font = Regular(15);
    [self.view addSubview:MoneyLabel];
    [MoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).offset(10);
        make.centerY.equalTo(imageView);
    }];
    UILabel * label = [[UILabel alloc] init];
    label.text = @"会员卡购买成功！";
    label.textColor = COLOR(58, 171, 53);
    label.font = Regular(12) ;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView);
        make.top.equalTo(imageView.mas_bottom).offset(10);
    }];
    
    UIView * LineView = [UIView new];
    LineView.backgroundColor = COLOR(229, 229, 229);
    [self.view addSubview:LineView];
    [LineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(label.mas_bottom).offset(17);
    }];
    
    
    
    for (int i = 0 ; i < 2; i++) {
        UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.view addSubview:btn];
        NSString * title = i == 0 ? @"去借款" : @"去购物";
        [btn setTitle:title forState:(UIControlStateNormal)];
        btn.adjustsImageWhenHighlighted = NO;
        [self.view addSubview:btn];
        btn.titleLabel.font = Regular(15);
        [btn setTitleColor:COLOR(51, 51, 51) forState:(UIControlStateNormal)];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(LineView);
            make.left.equalTo(self.view).offset(BCWidth / 2 * i);
            make.height.mas_equalTo(45);
            make.width.mas_equalTo(BCWidth / 2);
        }];
        
    }
    
    UIView * lineView2 = [UIView new];
    lineView2.backgroundColor = COLOR(229, 229, 229);
    [self.view addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(0.5);
        make.top.equalTo(LineView);
    }];
    
    UIView * LineView3  = [UIButton buttonWithType:(UIButtonTypeCustom)];
    LineView3.backgroundColor = COLOR(229, 229, 229);
    [self.view addSubview:LineView3];
    [LineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(8);
        make.top.equalTo(lineView2.mas_bottom);
    }];
    return LineView3;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    RecommendCommodityCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RecommendCommodityCell" forIndexPath:indexPath];
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.01;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.01;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((BCWidth - 1) / 2, 190);
}



@end

