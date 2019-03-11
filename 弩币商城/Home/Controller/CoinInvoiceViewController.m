//
//  CoinInvoiceViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/1.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinInvoiceViewController.h"
#import "CoinBindingCardViewController.h"
#import "CoinMyCardViewController.h"
@interface CoinInvoiceViewController ()

@end

@implementation CoinInvoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发票信息";
self.view.backgroundColor = [UIColor whiteColor];
    [self initView];
    [self SetReturnButton];
}

- (void)initView{
    
    UILabel * label = [UILabel new];
    label.text = @"发票抬头";
    label.textColor = COLOR(51, 51, 51);
    label.font = Regular(15);
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.top.equalTo(self.view).offset(17);
    }];
    UIView * LineView = [UIView new];
    LineView.backgroundColor = COLOR(229, 229, 229);
    [self.view addSubview:LineView];
    [LineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.right.equalTo(self.view).offset(-16);
        make.top.equalTo(label.mas_bottom).offset(12);
        make.height.mas_equalTo(0.5);
    }];
    
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"选择配送"]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(LineView);
        make.top.equalTo(LineView).offset(12);
        make.width.height.mas_equalTo(17);
    }];
    
    UILabel * personLabel = [UILabel new];
    personLabel.text = @"个人";
    personLabel.font = Regular(14);
    personLabel.textColor = COLOR(102, 102, 102);
    [self.view addSubview:personLabel];
    [personLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).offset(12);
        make.centerY.equalTo(imageView);
    }];
    
    UILabel * enterpriseLabel = [[UILabel alloc] init];
    enterpriseLabel.textColor = COLOR(255, 0, 24);
    enterpriseLabel.text = @"(如需开企业发票请联系客服)";
    enterpriseLabel.font = Regular(10);
    [self.view addSubview:enterpriseLabel];
    [enterpriseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView);
        make.top.equalTo(imageView.mas_bottom).offset(16);
    }];
    
    UIView * backgroundView = [UIView new];
    backgroundView.backgroundColor = COLOR(245, 245, 245);
    [self.view addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(enterpriseLabel.mas_bottom).offset(12);
        make.height.mas_equalTo(8);
    }];
    
    
    
    UILabel * label2 = [UILabel new];
    label2.text = @"发票内容";
    label2.textColor = COLOR(51, 51, 51);
    label2.font = Regular(15);
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.top.equalTo(backgroundView.mas_bottom).offset(17);
    }];
    UIView * LineView2 = [UIView new];
    LineView2.backgroundColor = COLOR(229, 229, 229);
    [self.view addSubview:LineView2];
    [LineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.right.equalTo(self.view).offset(-16);
        make.top.equalTo(label2.mas_bottom).offset(12);
        make.height.mas_equalTo(0.5);
    }];
    [self SetButton:16 title:@"商品明细"];
    [self SetButton:SetX(126) title:@"商品类别"];
    [self SetButton:SetX(235) title:@"不开发票"];
    UIButton * affirmButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [affirmButton setBackgroundColor:[UIColor colorWithRed:232/255.0 green:48/255.0 blue:35/255.0 alpha:1.0] forState:(UIControlStateNormal)];
    [affirmButton setTitle:@"确认" forState:(UIControlStateNormal)];
    [self.view addSubview:affirmButton];
    affirmButton.adjustsImageWhenHighlighted = NO;
    [affirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(32);
        make.right.equalTo(self.view).offset(-32);
        make.top.equalTo(self.view).offset(229);
        make.height.mas_equalTo(40);
    }];
    [affirmButton addTarget:self action:@selector(affirmButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}

- (void)affirmButtonAction:(UIButton *)btn{
    CoinMyCardViewController * vc = [CoinMyCardViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)SetButton:(CGFloat)left title:(NSString *)title{
    UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setBackgroundImage:[UIImage imageNamed:@"未选中"] forState:(UIControlStateNormal)];
    [btn setBackgroundImage:[UIImage imageNamed:@"选中"] forState:(UIControlStateSelected)];
    btn.adjustsImageWhenHighlighted = NO;
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(left);
        make.top.equalTo(self.view).offset(188);
    }];
    
    UILabel * label = [[UILabel alloc] init];
    label.text = title;
    label.textColor = COLOR(102, 102, 102);
    label.font = Regular(14);
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn.mas_right).offset(10);
        make.centerY.equalTo(btn);
    }];
    [btn addtargetBlock:^(UIButton *button) {
        btn.selected = !btn.selected;
    }];
    
}
@end
