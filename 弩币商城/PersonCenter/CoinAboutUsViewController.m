//
//  CoinAboutUsViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/1.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinAboutUsViewController.h"

@interface CoinAboutUsViewController ()

@end

@implementation CoinAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    [self SetReturnButton];
    [self SetNavTitleColor];
    [self initView];
}

- (void)initView{
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView * LogoImage = [UIImageView new];
    LogoImage.image = BCImage(22);
    [self.view addSubview:LogoImage];
    [LogoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(SetY(55));
        make.width.mas_equalTo(SetX(129));
        make.height.mas_equalTo(SetY(61));
    }];
    UILabel * versionsLabel = [UILabel new];
    versionsLabel.text = @"当前版本： V 1.0.0";
    versionsLabel.font = Regular(10);
    versionsLabel.textColor = COLOR(108, 108, 108);
    [self.view addSubview:versionsLabel];
    [versionsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(LogoImage.mas_bottom).offset(10);
    }];
    NSArray * array = @[@"帑库商城介绍",@"用户注册协议",@"隐私保护政策"];
    for (int i = 0; i < array.count; i++) {
        UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        btn.adjustsImageWhenHighlighted = NO;
        [self.view addSubview:btn];
        btn.tag = 1000 + i;
         CGFloat height = 40;
        CGFloat top = SetY(214) + i * height;
       
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(top);
            make.height.mas_equalTo(height);
            make.left.equalTo(self.view).offset(LEFT_Margin);
            make.right.equalTo(self.view).offset(-LEFT_Margin);
        }];
        UILabel * label = [[UILabel alloc] init];
        label.text = array[i];
        label.font = Regular(13);
        [btn addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.centerY.equalTo(btn);
        }];
        
        UIView * lineView = [UIView new];
        lineView.backgroundColor = COLOR(229, 229, 229);
        [btn addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(btn);
            make.height.mas_equalTo(0.5);
        }];
        
        UIImageView * select = [[UIImageView alloc] init];
        select.image = BCImage(查看更多);
        [btn addSubview:select];
        [select mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(btn);
            make.width.mas_equalTo(8)
            ;
            make.height.mas_equalTo(15);
            make.right.equalTo(btn);
        }];
    }
    UIView * lineView = [UIView new];
    lineView.backgroundColor = COLOR(229, 229, 229);
    
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(LEFT_Margin);
        make.right.equalTo(self.view).offset(-LEFT_Margin);
        make.top.equalTo(self.view).offset((SetY(214) + 3 * 40));
        make.height.mas_equalTo(0.5);
    }];
    
    UILabel * CopyrightLabel = [UILabel new];
    CopyrightLabel.textColor = COLOR(108, 108, 108);    CopyrightLabel.font = Regular(10);
    CopyrightLabel.text = @" CopyRight©2018-2019 江苏住银所互联网科技有限公司 版权所有";
    CopyrightLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:CopyrightLabel];
    [CopyrightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-SetX(65));
    }];
}

@end
