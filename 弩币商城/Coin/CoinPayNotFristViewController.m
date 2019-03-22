//
//  CoinPayNotFristViewController.m
//  弩币商城
//
//  Created by Jack on 2019/3/19.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinPayNotFristViewController.h"
#import "RecommendCommodityCell.h"

@implementation CoinPayNotFristViewController
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"购买成功";
    self.view.backgroundColor = White;
    [self initView];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem new];
    
}

- (void)initView {
    
    UIView *topV = [[UIView alloc] init];
    topV.backgroundColor = White;
    [self.view addSubview:topV];
    [topV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.mas_equalTo(0);
        make.width.mas_equalTo(BCWidth);
        make.height.mas_equalTo(188 + 45);
    }];
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.text = @"订单信息已提交审核";
    titleL.textColor = Gray_Color;
    titleL.font = Regular(14);
    [topV addSubview:titleL];
    
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(LEFT_Margin);
        make.centerX.equalTo(topV);
        make.height.mas_equalTo(14);
        
    }];
    
    
    NSArray *leftA = @[@"收货人姓名：",@"收货地址：",@"支付方式：",@"订单号："];
    NSArray *rightA = @[_name,_address,@"分期购",_orderNum];
    for (int i = 0; i < leftA.count; i ++) {
        
        
        UILabel *leftL = [[UILabel alloc] init];
        leftL.text = leftA[i];
        leftL.textColor = Gray_Color;
        leftL.font = Regular(13);
        [topV addSubview:leftL];
        [leftL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(titleL.mas_bottom).offset(20 + 36 * i);
            make.left.mas_equalTo(LEFT_Margin);
            
            
        }];
        
        
        
        UILabel *rightL = [[UILabel alloc] init];
        rightL.text = rightA[i];
        rightL.textColor = COLOR(153, 153, 153);
        rightL.font = Regular(13);
        [topV addSubview:rightL];
        [rightL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(-LEFT_Margin);
            make.top.mas_equalTo(leftL.mas_top);
            
        }];
        
    }
    
    
    
    //    支付和订单按钮
    UIButton *backBtn1 = [[UIButton alloc] init];
    backBtn1.titleLabel.font = Regular(13);
    [backBtn1 setTitle:@"回到首页" forState:UIControlStateNormal];
    [backBtn1 setTitleColor:TITLE_COLOR forState:UIControlStateNormal];

   
    [topV addSubview:backBtn1];
    [backBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(188);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(BCWidth/2);
    }];
    
    [backBtn1 addtargetBlock:^(UIButton *button) {
        
        
       
    }];
    
    UIButton *backBtn = [[UIButton alloc] init];
    backBtn.titleLabel.font = Regular(13);
    [backBtn setTitle:@"查看订单" forState:UIControlStateNormal];
    [backBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
  
    [topV addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BCWidth/2);
        make.top.mas_equalTo(188);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(BCWidth/2);
    }];
    
//    分割线
    
    UIImageView *lineImage = [[UIImageView alloc] init];
    lineImage.backgroundColor = COLOR(242, 242, 242);
    
    [topV addSubview:lineImage];
    [lineImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(LEFT_Margin);
        make.top.mas_equalTo(188);
        make.width.mas_equalTo(BCWidth - 30);
        make.height.mas_equalTo(1);
    }];
    
    
    UIImageView *lineImage1 = [[UIImageView alloc] init];
    lineImage1.backgroundColor = COLOR(242, 242, 242);
    
    [topV addSubview:lineImage1];
    [lineImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(BCWidth/2);
        make.top.mas_equalTo(188);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(45);
    }];
    
    
    
 //    热门推荐
    UIImageView *divideView = [[UIImageView alloc] init];
    divideView.backgroundColor = DIVI_COLOR;
    [self.view addSubview:divideView];
    [divideView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(topV.mas_bottom);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(TOP_Margin);
        make.width.mas_equalTo(BCWidth);
        
    }];
    
    UILabel *leftL = [[UILabel alloc] init];
    leftL.text = @"热门推荐";
    leftL.textColor = TITLE_COLOR;
    leftL.font = Regular(15);
    [self.view addSubview:leftL];
    [leftL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(divideView.mas_bottom);
        make.left.mas_equalTo(LEFT_Margin);
        make.height.mas_equalTo(40);
        
    }];
    

    UICollectionViewFlowLayout * flow = [UICollectionViewFlowLayout new];
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flow];
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.top.equalTo(leftL.mas_bottom);
    }];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[RecommendCommodityCell class] forCellWithReuseIdentifier:@"RecommendCommodityCell"];
    

    
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
