//
//  CoinPayMoneyOrderViewController.m
//  弩币商城
//
//  Created by Jack on 2019/3/19.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinPayMoneyOrderViewController.h"
#import "CoinMemberBuyViewController.h"

@implementation CoinPayMoneyOrderViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"购买成功";
    self.view.backgroundColor = DIVI_COLOR;
    [self initView];
    
}

- (void)initView {
    
    UIView *topV = [[UIView alloc] init];
    topV.backgroundColor = White;
    [self.view addSubview:topV];
    [topV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.mas_equalTo(0);
        make.width.mas_equalTo(BCWidth);
        make.height.mas_equalTo(188);
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
    backBtn1.titleLabel.font = Regular(16);
    [backBtn1 setTitle:@"支付首付" forState:UIControlStateNormal];
    [backBtn1 setTitleColor:White forState:UIControlStateNormal];
    backBtn1.layer.cornerRadius = 5;
    backBtn1.backgroundColor = COLOR(0, 160, 233);
    [self.view addSubview:backBtn1];
    [backBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.top.equalTo(topV.mas_bottom).offset(20);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(BCWidth - 80);
    }];
    
    [backBtn1 addtargetBlock:^(UIButton *button) {
       
        
        CoinMemberBuyViewController *VC = [[CoinMemberBuyViewController alloc] init];
        VC.type = BRPayBuyCommodity;
        VC.titleString = @"支付首付";
        VC.IdStr =_orderNum;
        VC.Money = _money;
        [self.navigationController pushViewController:VC animated:YES];
    }];
    
    UIButton *backBtn = [[UIButton alloc] init];
    backBtn.titleLabel.font = Regular(16);
    [backBtn setTitle:@"查看订单" forState:UIControlStateNormal];
    [backBtn setTitleColor:Gray_Color forState:UIControlStateNormal];
    backBtn.layer.cornerRadius = 5;
    backBtn.backgroundColor = White;
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.top.equalTo(backBtn1.mas_bottom).offset(20);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(BCWidth - 80);
    }];
    
}
@end
