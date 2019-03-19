//
//  CoinLimitViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/6.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinLimitViewController.h"

@interface CoinLimitViewController ()
@property (nonatomic,strong) UILabel * cash_credit_left;
@property (nonatomic,strong)UILabel * cash_credit_limit;
@property (nonatomic,strong)UILabel * mall_credit_left;
@property (nonatomic,strong)UILabel * mall_credit_limit; // 购物总额度

@end

@implementation CoinLimitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"额度";
    [self SetNavTitleColor];
    [self SetReturnButton];
    [self initView];
    [self request];
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
        if (i == 0) {
            self.mall_credit_left = MoneyLabel;
        }else{
            self.cash_credit_left =  MoneyLabel;
        }
        
        MoneyLabel.textColor = COLOR(51, 51, 51);
        MoneyLabel.font = Regular(15);
        [view addSubview:MoneyLabel];
        [MoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(view);
            make.centerY.equalTo(titleLabel);
        }];
        
        UILabel * typeLabel = [UILabel new];
        if (i == 0) {
            self.mall_credit_limit = typeLabel;
        }else{
            self.cash_credit_limit = typeLabel;
        }
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
- (void)request{
    
    [KTooL HttpPostWithUrl:@"UserCenter/check_credit_limit" parameters:nil loadString:@"正在加载" success:^(NSURLSessionDataTask *task, id responseObject) {
        if (BCStatus) {
            self.mall_credit_limit.text = [NSString stringWithFormat:@"总额度：￥%@",responseObject[@"data"][@"mall_credit_limit"]];
            self.cash_credit_limit.text = [NSString stringWithFormat:@"总额度：￥%@",responseObject[@"data"][@"cash_credit_limit"]];
            
            self.mall_credit_left.text = [NSString stringWithFormat:@"￥%@",responseObject[@"data"][@"mall_credit_left"]];
            self.cash_credit_left.text = [NSString stringWithFormat:@"￥%@",responseObject[@"data"][@"cash_credit_left"]];
            
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

@end
