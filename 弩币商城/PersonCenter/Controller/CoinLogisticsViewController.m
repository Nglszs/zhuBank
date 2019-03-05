//
//  CoinLogisticsViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/5.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinLogisticsViewController.h"

@interface CoinLogisticsViewController ()

@end

@implementation CoinLogisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查看物流信息";
    [self SetNavTitleColor];
    [self SetReturnButton];
    [self initView];
}
- (void)initView{
    for (int i = 0 ; i < 2; i++) {
        UILabel * leftLabel = [UILabel new];
        UILabel * rightLabel = [UILabel new];
        leftLabel.text = i == 0 ? @"运单编号" :@"国内承运人";
        leftLabel.textColor = COLOR(102, 102, 102);
        leftLabel.font = Regular(13);
        rightLabel.text = i == 0 ? @"201910102011402110221" :@"申通快递";
        rightLabel.textColor = COLOR(102, 102, 102);
        rightLabel.font = Regular(13);
        
        [self.view addSubview:leftLabel];
        [self.view addSubview:rightLabel];
        [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(LEFT_Margin);
            make.top.equalTo(self.view).offset(30 * i + 10 * (i + 1));
            make.height.mas_equalTo(30);
            
        }];
        
        [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view).offset(-LEFT_Margin);
            make.top.equalTo(self.view).offset(30 * i + 10 * (i + 1));
            make.height.mas_equalTo(30);
        }];
    }
    
}
@end
