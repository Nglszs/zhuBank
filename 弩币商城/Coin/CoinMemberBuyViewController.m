//
//  CoinMemberBuyViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/4.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinMemberBuyViewController.h"

@interface CoinMemberBuyViewController ()

@end

@implementation CoinMemberBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购买帑库金钻会员卡";
    [self SetNavTitleColor];
    [self SetReturnButton];
    [self initView];
}

- (void)initView{
    UILabel * MoneyLabel = [[UILabel alloc] init];
    MoneyLabel.text = @"¥299.00";
    MoneyLabel.textColor = COLOR(255, 87, 103);
    MoneyLabel.font = Regular(24);
    [self.view addSubview:MoneyLabel];
    [MoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(32);
    }];
    UILabel * titleLabel = [UILabel new];
    titleLabel.text = @"选择支付方式";
    titleLabel.textColor = COLOR(51, 51, 51);
    titleLabel.font = Regular(16);
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(LEFT_Margin);
        make.top.equalTo(MoneyLabel.mas_bottom).offset(40);
    }];
    
    for (int i = 0; i < 2; i++) {
        UIView * view = [UIView new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(LEFT_Margin);
            make.right.equalTo(self.view).offset(-LEFT_Margin);
            make.height.mas_equalTo(50);
            make.top.equalTo(titleLabel.mas_bottom).offset( (15 + 50 * i));
        }];
        UIView * LineView = [UIView new];
        LineView.backgroundColor = COLOR(229, 229, 229);
        [self.view addSubview:LineView];
        [LineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(view);
            make.height.mas_equalTo(0.5);
        }];
      
        if (i == 1) {
            LineView.hidden = YES;
        }
        
        UIView * LineView2 = [UIView new];
        LineView2.backgroundColor = COLOR(229, 229, 229);
        [self.view addSubview:LineView2];
        [LineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(view);
            make.height.mas_equalTo(0.5);
        }];
        
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:(i == 0 ? @"微信支付" :@"支付宝支付")];
        [view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.left.equalTo(titleLabel);
            make.width.height.mas_equalTo(22);
        }];
       
        UILabel * label = [UILabel new];
        label.text = (i == 0 ? @"微信支付" : @"支付宝支付");
        label.textColor = COLOR(102, 102, 102);
        label.font = Regular(16);
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).offset(10);
            make.centerY.equalTo(imageView);
        }];
        
        UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        btn.adjustsImageWhenHighlighted = NO;
        [btn setBackgroundImage:BCImage(未选中) forState:(UIControlStateNormal)];
         [btn setBackgroundImage:BCImage(选中) forState:(UIControlStateSelected)];
        [btn addTarget:self action:@selector(SelectBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.centerY.equalTo(view);
            make.width.height.mas_equalTo(17);
        }];
        
    }
    
    UIButton * payButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [payButton setTitle:@"去支付" forState:(UIControlStateNormal)];
    [self.view addSubview:payButton];
    payButton.titleLabel.font = Regular(16);
    [payButton setBackgroundColor:COLOR(0, 160, 233) forState:(UIControlStateNormal)];
    [payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(38);
        make.right.equalTo(self.view).offset(-38);
        make.top.equalTo(self.view).offset(255);
        make.height.mas_equalTo(40);
    }];
    payButton.adjustsImageWhenHighlighted = NO;
}
- (void)SelectBtnAction:(UIButton *)btn{
    
    btn.selected = !btn.selected;
}

@end
