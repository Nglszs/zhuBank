//
//  CoinLimitViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/6.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinLimitViewController.h"

@interface CoinLimitViewController ()

@end

@implementation CoinLimitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"额度";
    [self SetNavTitleColor];
    [self SetReturnButton];
    [self initView];
}

- (void)initView{
    
    for (int i = 0; i < 2; i++) {
        UIView * view = [[UIView alloc] init];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(32);
            make.right.equalTo(self.view).offset(-32);
            make.height.mas_equalTo(68);
            make.top.equalTo(self.view).offset(68 * i);
        }];
        
        UIView * LineView = [UIView new];
        LineView.backgroundColor = COLOR(235, 235, 235);
        [view addSubview:LineView];
        [LineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(view);
            make.height.mas_equalTo(0.5);
        }];
        
        UILabel * titleLabel = [UILabel new];
        titleLabel.text = (i == 0 ? @"购物可用额度" :@"借款可用额度");
        titleLabel.textColor = COLOR(51, 51, 51);
        titleLabel.font = Regular(15);
        [view addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view);
            make.top.equalTo(view).offset(16);
        }];
        
        UILabel * MoneyLabel = [UILabel new];
        MoneyLabel.text = @"￥5600";
        MoneyLabel.textColor = COLOR(51, 51, 51);
        MoneyLabel.font = Regular(15);
        [view addSubview:MoneyLabel];
        [MoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(view);
            make.centerY.equalTo(titleLabel);
        }];
        
        UILabel * typeLabel = [UILabel new];
        typeLabel.text = @"总额度：￥6000";
        typeLabel.textColor = COLOR(153, 153, 153);
        typeLabel.font = Regular(13);
        [view addSubview:typeLabel];
        [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view);
            make.bottom.equalTo(view).offset(-8);
        }];
    }
    
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = COLOR(221, 221, 221);
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(0.5);
    }];
    
}

@end
