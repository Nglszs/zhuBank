//
//  CoinMemberSucceedViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/4.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinMemberSucceedViewController.h"
#import "RecommendCommodityCell.h"
#import "CoinGoodDetailViewController.h"
#import "CoinOrderDetailsViewController.h"

@interface CoinMemberSucceedViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UILabel * moneLabel;
@property (nonatomic,strong)UILabel * stringLabel;
@property (nonatomic,strong)UICollectionView * collectionView;
@end

@implementation CoinMemberSucceedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.type == BRPaySuccessBuyMember) {
         self.title = @"购买会员卡成功";
        [self request];
    }else if (self.type == BRPayPaymentSuccess){
        self.title = @"支付首付";
    }else if (self.type == BRPayAllMoneySuccess){
        self.title = @"支付成功";
    }else if (self.type == BRPayRepaySuccess){
        self.title = @"还款状态";
    }
    [self SetNavTitleColor];
    [self initView];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:(UIBarButtonItemStyleDone) target:self action:@selector(temp)];
}

- (void)temp{
    
}
- (void)initView{
    
UIView * tempView =     [self HeaderView];
    
    UICollectionViewFlowLayout * flow = [UICollectionViewFlowLayout new];
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flow];
    self.collectionView = collectionView;
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

- (void)setMoney:(NSString *)Money{
    _Money = Money;
  
    
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
    self.moneLabel = MoneyLabel;
    
    NSString * s1 = @"";
    if (self.type == BRPayPaymentSuccess) {
        s1 = @"支付首付成功";
    }else if (self.type == BRPayAllMoneySuccess){
        s1 = @"支付全款成功";
    }else if (self.type == BRPayRepaySuccess){
        s1 = @"还款成功";
    }
    _Money = [NSString stringWithFormat:@"%@",_Money];
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@ %@",_Money,s1]];
    self.moneLabel.textColor = COLOR(58, 171, 53);
    [string addAttribute:NSForegroundColorAttributeName value:COLOR(102, 102, 102) range:NSMakeRange(0, _Money.length + 1)];
  
    self.moneLabel.attributedText = string;
    
    UILabel * label = [[UILabel alloc] init];
    label.text = @"会员卡购买成功！";
    label.textColor = COLOR(58, 171, 53);
    label.font = Regular(12) ;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView);
        make.top.equalTo(imageView.mas_bottom).offset(10);
    }];
    self.stringLabel = label;
 
    label.hidden = YES;
    if (self.type == BRPaySuccessBuyMember) {
        label.hidden = NO;
    }
    if (self.type == BRPayRepaySuccess) {
        label.hidden = NO;
        label.text = @"请保持良好的还款习惯，珍惜个人信用。";
        label.textColor = COLOR(153, 153, 153);
        label.font = Regular(11);
    }
    
    UIView * LineView = [UIView new];
    LineView.backgroundColor = COLOR(229, 229, 229);
    [self.view addSubview:LineView];
    [LineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(label.mas_bottom).offset(17);
    }];
    
    
    NSArray * titles;
    if (self.type == BRPayPaymentSuccess || self.type == BRPayAllMoneySuccess || self.type == BRPayRepaySuccess) {
        titles = @[@"查看订单",@"回到首页"];
    }else{
        titles = @[@"去借钱",@"去购物"];
    }
    for (int i = 0 ; i < 2; i++) {
        UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.view addSubview:btn];
        NSString * title = titles[i];
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
        if (i == 0) {
             [btn addTarget:self action:@selector(leftBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        }else{
             [btn addTarget:self action:@selector(rightBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        }
       
        
        
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
    
    UIView * view2 = [UIView new];
    view2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(LineView3.mas_bottom);
        make.height.mas_equalTo(50);
    }];
    
    UILabel * title = [[UILabel alloc] init];
    title.text = @"热门推荐";
    title.textColor = COLOR(51, 51, 51);
    title.font = Regular(15);;
    [view2 addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view2);
        make.left.equalTo(view2).offset(LEFT_Margin);
    }];
    return view2;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    RecommendCommodityCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RecommendCommodityCell" forIndexPath:indexPath];
    cell.dataDict = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.01;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.01;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((BCWidth - 1) / 2, 210);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString * ids = self.dataArray[indexPath.row][@"goods_id"];
    CoinGoodDetailViewController * vc = [CoinGoodDetailViewController new];
    vc.goodID = ids;
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark   下面两个按钮点击事件
- (void)leftBtnAction:(UIButton *)btn{
    if (self.type == BRPaySuccessBuyMember) {
        // 去借钱
        self.tabBarController.selectedIndex = 2;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    if (self.type == BRPayPaymentSuccess || self.type == BRPayAllMoneySuccess) {
        //查看订单
        CoinOrderDetailsViewController * vc = [CoinOrderDetailsViewController new];
        vc.order_id = self.order_id;
        vc.type = BROrderNotEnable;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (self.type == BRPayRepaySuccess) {
        CoinOrderDetailsViewController * vc = [CoinOrderDetailsViewController new];
        vc.order_id = self.order_id;
        vc.type = BROrderFinsh;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)rightBtnAction:(UIButton *)btn{
    if (self.type == BRPaySuccessBuyMember) {
        // 去购物
        self.tabBarController.selectedIndex = 1;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    if (self.type == BRPayPaymentSuccess || self.type == BRPayAllMoneySuccess || self.type == BRPayRepaySuccess) {
        //回到首页
        self.tabBarController.selectedIndex = 0;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)request{
    [KTooL HttpPostWithUrl:@"CashLoan/buy_vip_success" parameters:nil loadString:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (BCStatus) {
            self.dataArray = responseObject[@"data"];
            [self.collectionView reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
@end

