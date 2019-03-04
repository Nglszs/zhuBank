//
//  CoinMoneyViewController.m
//  弩币商城
//
//  Created by Jack on 2019/2/25.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinMoneyViewController.h"
#import "CoinBorrowMoneyViewController.h"
@interface CoinMoneyViewController ()

@end

@implementation CoinMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    self.title = @"帑库银票";
    [self SetNavTitleColor];
}

- (void)initView{
    
    UILabel *TitleLabel = [[UILabel alloc] init];
    
    TitleLabel.numberOfLines = 0;
    [self.view addSubview:TitleLabel];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"最高可借金额" attributes:@{NSFontAttributeName: Regular(12),NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
    
    TitleLabel.attributedText = string;
    [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(SetY(36));
    }];
    
    UILabel *MoneyLabel = [[UILabel alloc] init];
    
    MoneyLabel.numberOfLines = 0;
    [self.view addSubview:MoneyLabel];
    
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:@"￥5000" attributes:@{NSFontAttributeName: Regular(15),NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    
    [string2 addAttributes:@{NSFontAttributeName: Regular(24)} range:NSMakeRange(1, 4)];
    
    MoneyLabel.attributedText = string2;
    [MoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(TitleLabel);
        make.top.equalTo(TitleLabel.mas_bottom).offset(20);
    }];
    UILabel *FootLabel = [[UILabel alloc] init];
    
    FootLabel.numberOfLines = 0;
    [self.view addSubview:FootLabel];
    
    NSMutableAttributedString *string3 = [[NSMutableAttributedString alloc] initWithString:@"分期秒到账" attributes:@{NSFontAttributeName: Regular(12),NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
    
    FootLabel.attributedText = string3;
    [FootLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(MoneyLabel.mas_bottom).offset(10);
    }];
    
    UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.titleLabel.font = Regular(18);
    [btn setTitle:@"立即开通帑库金钻会员卡" forState:(UIControlStateNormal)];
    btn.adjustsImageWhenHighlighted = NO;
    [self.view addSubview:btn];
    btn.layer.cornerRadius = 5;
    btn.clipsToBounds = YES;
    btn.backgroundColor = COLOR(255, 0, 0);
    btn.titleLabel.font = Regular(18);
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(SetX(32));
        make.right.equalTo(self.view).offset(-SetX(32));
        make.height.mas_equalTo(45);
        make.top.equalTo(FootLabel.mas_bottom).offset(31);
    }];
    
    
    UIButton * AgreementButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [AgreementButton setTitleColor:COLOR(255, 0, 0) forState:(UIControlStateNormal)];
    [self.view addSubview:AgreementButton];
    AgreementButton.titleLabel.font = Regular(13);
    AgreementButton.adjustsImageWhenHighlighted = NO;
    [AgreementButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn);
        make.top.equalTo(btn.mas_bottom).offset(23);
    }];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:@"借款相关协议"];
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, str.length)];
    [str addAttribute:NSUnderlineColorAttributeName value:COLOR(255, 0, 0) range:NSMakeRange(0, str.length)];
    [AgreementButton setAttributedTitle:str forState:(UIControlStateNormal)];
    [str addAttribute:NSForegroundColorAttributeName value:COLOR(255, 0, 0) range:NSMakeRange(0, str.length)];
    
    UIButton * CooperationBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
 
    [self.view addSubview:CooperationBtn];
    CooperationBtn.titleLabel.font = Regular(13);
    CooperationBtn.adjustsImageWhenHighlighted = NO;
    [CooperationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(btn);
        make.top.equalTo(btn.mas_bottom).offset(23);
    }];
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc]initWithString:@"借款相关协议"];
    [str2 addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, str2.length)];
    [str2 addAttribute:NSUnderlineColorAttributeName value:COLOR(255, 0, 0) range:NSMakeRange(0, str.length)];
    [str2 addAttribute:NSForegroundColorAttributeName value:COLOR(255, 0, 0) range:NSMakeRange(0, str2.length)];
    [CooperationBtn setAttributedTitle:str2 forState:(UIControlStateNormal)];
    [self setNavitem:@"详情介绍" type:RightNavItem];
    self.navigationItem.rightBarButtonItem.tintColor = COLOR(255, 126, 0);
    
    [btn addtargetBlock:^(UIButton *button) {
        CoinBorrowMoneyViewController * vc = [[CoinBorrowMoneyViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
}

@end
