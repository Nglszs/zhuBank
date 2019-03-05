//
//  CoinBrowseStatusViewController.m
//  弩币商城
//
//  Created by Jack on 2019/3/5.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinBrowseStatusViewController.h"
#import "CoinBrowseRecordViewController.h"
@interface CoinBrowseStatusViewController ()

@end

@implementation CoinBrowseStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"借款申请成功";
    
    
    [self initView];
    
    
}

- (void)initView {
    
//    申请金额
    UIView *topV = [[UIView alloc] init];
    [self.view addSubview:topV];
    [topV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.mas_equalTo(0);
        make.width.mas_equalTo(BCWidth);
        make.height.mas_equalTo(60);
    }];
    
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"申请金额：¥4000.00"];
    NSDictionary * firstAttributes = @{ NSFontAttributeName:Regular14Font};
    [str setAttributes:firstAttributes range:NSMakeRange(0,5)];
    
    UILabel *priceL = [[UILabel alloc] init];
    priceL.textAlignment = NSTextAlignmentCenter;
    priceL.textColor = COLOR(252, 148, 37);
    priceL.font = Regular(19);
    priceL.attributedText = str;
    [topV addSubview:priceL];
    [priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(32);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(BCWidth);
    }];
    
    
    
    UIImageView *divideView = [[UIImageView alloc] init];
    divideView.backgroundColor = DIVI_COLOR;
    [self.view addSubview:divideView];
    [divideView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(65);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(TOP_Margin);
        make.width.mas_equalTo(BCWidth);
        
    }];
    
    
    
//   借款 状态
    NSArray *titleA = @[@"申请成功",@"银行处理中",@"到账成功"];
    for (int i  = 0; i < 3; i++) {
        
        
        UIButton *activityBtn = [UIButton new];
     
        activityBtn.layer.borderWidth = 1;
        activityBtn.layer.borderColor = COLOR(252, 148, 37).CGColor;
        activityBtn.tag = 100 + i;
        activityBtn.layer.cornerRadius = 6;
        [self.view addSubview:activityBtn];
        
        
        [activityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(divideView.mas_bottom).offset(20);
            make.left.mas_equalTo(53 + i*((BCWidth - 106 - 36)/2 + 12));
            
            make.size.mas_equalTo(CGSizeMake(12, 12));
        }];
        
        
        if (i < 2) {
            UIButton *activityBtn1 = [UIButton new];
            activityBtn1.tag = 200+i;
            activityBtn1.layer.borderWidth = 1;
            activityBtn1.layer.borderColor = COLOR(252, 148, 37).CGColor;
         
            [self.view addSubview:activityBtn1];
            
            
            [activityBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(activityBtn);
                make.left.equalTo(activityBtn.mas_right).offset(-1);
                
                make.size.mas_equalTo(CGSizeMake((BCWidth - 106 - 36)/2 + 1, 5));
            }];
            
            
            
            
            
            
        }
        
        
        UILabel *titleL = [[UILabel alloc] init];
        titleL.text = titleA[i];
        titleL.textColor = COLOR(251, 82, 24);
        titleL.font = Regular(11);
        [self.view addSubview:titleL];
        
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(activityBtn.mas_bottom).offset(3);
            make.centerX.equalTo(activityBtn);
            make.height.mas_equalTo(12);
            
        }];
        
        //        商品价格
        UILabel *moneyL = [[UILabel alloc] init];
        moneyL.numberOfLines = 0;
        moneyL.textAlignment = NSTextAlignmentCenter;
        moneyL.text = @"2019-02-02 12:12:12";
        moneyL.textColor = COLOR(153, 153, 153);
        moneyL.font = Regular(9);
        [self.view addSubview:moneyL];
        [moneyL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(titleL);
            make.top.equalTo(titleL.mas_bottom).offset(5);
           
            make.width.mas_equalTo(55);
        }];
        
        
    }
    
    
//    借款进度设置
    for (int i = 0; i < 2; i ++) {
        
        UIButton *btn = [self.view viewWithTag:100 + i];
       btn.backgroundColor = COLOR(252, 148, 37);
    }
        
    UIButton *btn = [self.view viewWithTag:200];
    btn.backgroundColor = COLOR(252, 148, 37);
    
  
//    借款人信息
    
    NSArray *leftA = @[@"收款帐户",@"借款期限",@"到期还款金额"];
    for (int i = 0; i < leftA.count; i ++) {
        
        
        UILabel *leftL = [[UILabel alloc] init];
        leftL.text = leftA[i];
        leftL.textColor = COLOR(153, 153, 153);
        leftL.font = Regular(12);
        [self.view addSubview:leftL];
        [leftL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(divideView.mas_bottom).offset(100 + 36 * i);
            make.left.mas_equalTo(LEFT_Margin);
            make.height.mas_equalTo(36);
            make.width.mas_equalTo(72);
        }];
        
        
        
        UILabel *rightL = [[UILabel alloc] init];
        rightL.text = @"工商银行(尾号1717)    刘*华";
        rightL.textColor = COLOR(153, 153, 153);
        rightL.font = Regular(12);
        [self.view addSubview:rightL];
        [rightL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(leftL.mas_right).offset(TOP_Margin);
            make.top.mas_equalTo(leftL.mas_top);
            make.height.mas_equalTo(36);
        }];
        
        
        
       
        
    }
    
//    分割线
    
    for (int i = 0; i < 4; i ++) {
        UIImageView *lineImage = [[UIImageView alloc] init];
        lineImage.backgroundColor = COLOR(242, 242, 242);
        
        [self.view addSubview:lineImage];
        [lineImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(LEFT_Margin);
            make.top.equalTo(divideView.mas_bottom).offset(100 + i* 36);
            make.width.mas_equalTo(BCWidth - 30);
            make.height.mas_equalTo(1);
        }];
    }
    
    
    UIButton *backBtn1 = [[UIButton alloc] init];
    backBtn1.titleLabel.font = Regular(18);
    [backBtn1 setTitle:@"查看我的借款记录" forState:UIControlStateNormal];
    [backBtn1 setTitleColor:White forState:UIControlStateNormal];
    backBtn1.layer.cornerRadius = 5;
    backBtn1.backgroundColor = COLOR(255, 141, 29);
    [self.view addSubview:backBtn1];
    [backBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(32);
        make.top.equalTo(divideView.mas_bottom).offset(256);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(BCWidth - 64);
    }];
    
    [backBtn1 addtargetBlock:^(UIButton *button) {
        
        [self.navigationController pushViewController:[CoinBrowseRecordViewController new] animated:YES];
    }];
}
@end
