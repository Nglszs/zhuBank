//
//  CoinReturnBrowseViewController.m
//  弩币商城
//
//  Created by Jack on 2019/3/5.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinReturnBrowseViewController.h"

@interface CoinReturnBrowseViewController ()
{
    NSDictionary *dataDic;
    UILabel *sizeL;
    UILabel *leftL1;
    UILabel *leftL2;
}
@property (nonatomic,strong)UIImageView * CommodityImage;
@property (nonatomic,strong)UILabel * CommodityNameLabel;

@end

@implementation CoinReturnBrowseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"还款唐库银票";
    [self initView];
    [self getData];
}
- (void)getData {
    [KTooL HttpPostWithUrl:@"CashLoan/repay_page" parameters:@{@"loan_id":_ID} loadString:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSLog(@"===%@",responseObject);
        
        
        if (BCStatus) {
            
            dataDic = [responseObject objectNilForKey:@"data"];
            
            self.CommodityNameLabel.text = [dataDic objectNilForKey:@"bank_name"];
            
            sizeL.text = [NSString stringWithFormat:@"该卡本次最多可还款%@元",[dataDic objectForKey:@"max_money"]];
            
            
            leftL1.text = [NSString stringWithFormat:@"¥%@",[dataDic objectForKey:@"repay_total"]];
            
            leftL2.text = [NSString stringWithFormat:@"(其中本金+利息+服务费:%@元，逾期费:%@元)",[dataDic objectForKey:@"benxi"],[dataDic objectForKey:@"overdue_pay"]];
            
        } else {
            
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
        NSLog(@"");
    }];
    
}
- (void)initView {
    
    
    
//
    
    UIView *bottomV = [[UIView alloc] init];
    bottomV.backgroundColor = White;
    [self.view addSubview:bottomV];
    [bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.mas_equalTo(0);
        
        make.width.mas_equalTo(BCWidth);
        make.height.mas_equalTo(70);
    }];
    
    
    self.CommodityImage = [UIImageView new];
    self.CommodityImage.backgroundColor = [UIColor grayColor];
    [bottomV addSubview:self.CommodityImage];
    [self.CommodityImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(bottomV);
        make.left.mas_equalTo(LEFT_Margin);
        
        make.width.height.mas_equalTo(40);
    }];
    
    self.CommodityNameLabel = [UILabel new];
    
    self.CommodityNameLabel.text = @"贵州茅乡酒  M10浓香型白酒 52度送礼白";
    self.CommodityNameLabel.textColor = TITLE_COLOR;
    self.CommodityNameLabel.font = Regular(15);
    [bottomV addSubview:self.CommodityNameLabel];
    [self.CommodityNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.CommodityImage.mas_right).offset(17);
        make.top.mas_equalTo(self.CommodityImage.mas_top);
        make.right.mas_equalTo(-30);
        
    }];
    
    
    sizeL = [[UILabel alloc] init];
    sizeL.textColor = COLOR(153, 153, 153);
    sizeL.font = Regular(13);
    sizeL.text = @"该卡本次最多可还款10000.00元";
    [bottomV addSubview:sizeL];
    [sizeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.CommodityNameLabel.mas_left);
        make.bottom.mas_equalTo(self.CommodityImage.mas_bottom);
        make.height.mas_equalTo(14);
    }];
    
    UIImageView *divideView = [[UIImageView alloc] init];
    divideView.backgroundColor = DIVI_COLOR;
    [self.view addSubview:divideView];
    [divideView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(70);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(TOP_Margin);
        make.width.mas_equalTo(BCWidth);
        
    }];
    
    
//    借款
    
    UILabel *leftL = [[UILabel alloc] init];
        leftL.text = @"本次应还金额(元)";
        leftL.textColor = TITLE_COLOR;
        leftL.font = Regular(15);
        [self.view addSubview:leftL];
        [leftL mas_makeConstraints:^(MASConstraintMaker *make) {
    
            make.top.equalTo(divideView.mas_bottom).offset(LEFT_Margin);
            make.left.mas_equalTo(LEFT_Margin);
            make.height.mas_equalTo(15);
    
        }];
    
    
    leftL1 = [[UILabel alloc] init];
    leftL1.text = @"¥4050.00";
    leftL1.textColor = COLOR(252, 148, 37);
    leftL1.font = Regular(20);
    [self.view addSubview:leftL1];
    [leftL1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(leftL.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(20);
        
    }];
    
    
    leftL2 = [[UILabel alloc] init];
    
    leftL2.textColor = COLOR(153, 153, 153);
    leftL2.font = Regular(10);
    [self.view addSubview:leftL2];
    [leftL2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(leftL1.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(10);
        
    }];
    
    UIButton *backBtn1 = [[UIButton alloc] init];
    backBtn1.titleLabel.font = Regular(18);
    [backBtn1 setTitle:@"立即还款" forState:UIControlStateNormal];
    [backBtn1 setTitleColor:White forState:UIControlStateNormal];
    backBtn1.layer.cornerRadius = 5;
    backBtn1.backgroundColor = COLOR(255, 141, 29);
    [self.view addSubview:backBtn1];
    [backBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(LEFT_Margin);
        make.top.equalTo(leftL2.mas_bottom).offset(28);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(BCWidth - 30);
    }];
    
   
}

@end
