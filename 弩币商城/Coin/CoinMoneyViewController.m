//
//  CoinMoneyViewController.m
//  弩币商城
//
//  Created by Jack on 2019/2/25.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinMoneyViewController.h"
#import "CoinBorrowMoneyViewController.h"
#import "CoinH5ViewController.h"
#import "CoinCooperationCompanyViewController.h"
#import "CoinCertifyViewController.h"
@interface CoinMoneyViewController ()

@property (nonatomic,strong)UILabel * tips1;
@property (nonatomic,strong)UILabel * MoneyLabel;
@property (nonatomic,strong)UIButton * tips2Button;
@property (nonatomic,strong)NSString * details;
@property (nonatomic,strong)NSString * load_url;
@property (nonatomic,strong)NSDictionary * join_org;

// 1:去登录;2:不可点击不跳转;3:去购买会员;4:去审核身份;5:去绑卡;6:去信用认证;7:去借款
@property (nonatomic,copy)NSString * url;
@end

@implementation CoinMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    self.title = @"帑库银票";
    [self SetNavTitleColor];
    [self request];
}

- (void)initView{
    
    UILabel *TitleLabel = [[UILabel alloc] init];
    
    TitleLabel.numberOfLines = 0;
    [self.view addSubview:TitleLabel];
    
   
    TitleLabel.font = Regular(12);
    TitleLabel.textColor = COLOR(102, 102, 102);
    self.tips1 = TitleLabel;
    [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(SetY(36));
    }];
    
    UILabel *MoneyLabel = [[UILabel alloc] init];
    
    MoneyLabel.numberOfLines = 0;
    self.MoneyLabel = MoneyLabel;
    [self.view addSubview:MoneyLabel];
    
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:@"￥0" attributes:@{NSFontAttributeName: Regular(15),NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    
    [string2 addAttributes:@{NSFontAttributeName: Regular(24)} range:NSMakeRange(1, string2.length - 1)];
    
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
    [btn setTitle:@"" forState:(UIControlStateNormal)];
    self.tips2Button = btn;
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
    
    [AgreementButton addtargetBlock:^(UIButton *button) {
        CoinH5ViewController * vc = [CoinH5ViewController new];
        vc.titleStr = @"借款相关协议";
        vc.url = self.load_url;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [str addAttribute:NSForegroundColorAttributeName value:COLOR(255, 0, 0) range:NSMakeRange(0, str.length)];
    
    UIButton * CooperationBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
 
    [self.view addSubview:CooperationBtn];
    CooperationBtn.titleLabel.font = Regular(13);
    CooperationBtn.adjustsImageWhenHighlighted = NO;
    [CooperationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(btn);
        make.top.equalTo(btn.mas_bottom).offset(23);
    }];
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc]initWithString:@"合作的放款金融机构"];
    [str2 addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, str2.length)];
    [str2 addAttribute:NSUnderlineColorAttributeName value:COLOR(255, 0, 0) range:NSMakeRange(0, str.length)];
    [str2 addAttribute:NSForegroundColorAttributeName value:COLOR(255, 0, 0) range:NSMakeRange(0, str2.length)];
    [CooperationBtn setAttributedTitle:str2 forState:(UIControlStateNormal)];
    [CooperationBtn addtargetBlock:^(UIButton *button) {
        CoinCooperationCompanyViewController * vc = [CoinCooperationCompanyViewController new];
        vc.DataDict = self.join_org;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self setNavitem:@"详情介绍" type:RightNavItem];
    self.navigationItem.rightBarButtonItem.tintColor = COLOR(255, 126, 0);
    
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}

- (void)request{
    [KTooL HttpPostWithUrl:@"CashLoan/index" parameters:nil loadString:@"正在加载" success:^(NSURLSessionDataTask *task, id responseObject) {
        if (BCStatus) {
            [self upDataUI:responseObject[@"data"]];
        }
        NSLog(@"====%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (void)upDataUI:(NSDictionary *)dict{
    self.tips1 = dict[@"tips1"];
    [self.tips2Button setTitle:dict[@"tips2"] forState:(UIControlStateNormal)];
    
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",dict[@"amount"]] attributes:@{NSFontAttributeName: Regular(15),NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    
    [string2 addAttributes:@{NSFontAttributeName: Regular(24)} range:NSMakeRange(1, string2.length - 1)];
    
    self.MoneyLabel.attributedText = string2;
    self.load_url = dict[@"load_url"];
    self.details = dict[@"details"];
    self.url =  dict[@"url"];
    self.join_org = dict[@"join_org"];
}

- (void)RightItemAction{
    
    CoinH5ViewController * vc = [CoinH5ViewController new];
    vc.titleStr = @"详情介绍";
    vc.url = self.details;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)btnAction:(UIButton *)btn{
//    CoinBorrowMoneyViewController * vc = [[CoinBorrowMoneyViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    
    if (self.url) {
        
        NSInteger type = [self.url integerValue];
        
        if (type == 1) {
            // 去登录
            
        } else if (type == 2) {
            // 不可点击
            
        }else if (type == 3) {
            // 去购买会员
            
        }else if (type == 4) {
            // 去审核身份
            CoinCertifyViewController * vc = [CoinCertifyViewController new];
            vc.indexType = 1;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (type == 5) {
            // 去绑卡
            CoinCertifyViewController * vc = [CoinCertifyViewController new];
            vc.indexType = 2;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (type == 6) {
             // 去信用认证
            CoinCertifyViewController * vc = [CoinCertifyViewController new];
            vc.indexType = 3;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (type == 7) {
            // 去借款
            
        }
       
        
        
    }
    
    
    
}

@end
