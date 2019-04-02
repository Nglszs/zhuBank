//
//  BCReturnMoneyView.m
//  弩币商城
//
//  Created by Jack on 2019/3/28.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "BCReturnMoneyView.h"

@implementation BCReturnMoneyView

- (instancetype)initWithFrame:(CGRect)frame money:(NSString *)money{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.money = money;
        [self initView];
    }
    return self;
}

- (void)initView{
    //背景
    UIView *backView = [[UIView alloc]initWithFrame:BCBound];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.5;
    [self addSubview:backView];
    
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backView);
        make.centerY.equalTo(backView).offset(-100);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(230);
    }];
    
    UILabel * titleLabel = [UILabel new];
    titleLabel.text = @"请输入支付短信验证码";
    titleLabel.font = Regular(15);
    [view addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(view).offset(20);
    }];
    
    UIButton * closeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [closeBtn setBackgroundImage:BCImage(取消) forState:(UIControlStateNormal)];
    [view addSubview:closeBtn];
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(15);
        make.right.equalTo(view).offset(-15);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    [closeBtn addtargetBlock:^(UIButton *button) {
        [self removeFromSuperview];
    }];
    UILabel * label = [[UILabel alloc] init];
    label.text = @"借款金额";
    label.textColor = COLOR(155, 156, 157);
    label.font = Regular(13);
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        
    }];
    
    UILabel * MoneyLabel = [UILabel new];
    MoneyLabel.textColor = COLOR(238, 111, 46);
    MoneyLabel.font = Regular(15);
    MoneyLabel.text = [NSString stringWithFormat:@"￥%@",self.money];
    [view addSubview:MoneyLabel];
    [MoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(label.mas_bottom).offset(10);
    }];
    
    UIView * TFView = [[UIView alloc] init];
    TFView.layer.borderWidth = 0.5;
    TFView.layer.borderColor = COLOR(220, 220, 220).CGColor;
    [view addSubview:TFView];
    
    [TFView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(30);
        make.right.equalTo(view).offset(-30);
        make.top.equalTo(MoneyLabel.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
    }];
    
    
    
    UITextField * passwordTF = [UITextField new];
    self.passwordTF = passwordTF;
    passwordTF.delegate = self;
    passwordTF.placeholder = @"请输入支付短信验证码";
    passwordTF.font = Regular(13);
    passwordTF.secureTextEntry = YES;
    [TFView addSubview:passwordTF];
    [passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TFView).offset(2);
        make.right.equalTo(TFView).offset(-5);
        make.centerY.equalTo(TFView);
    }];
    
    UIButton * submitButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [submitButton setTitle:@"确认还款" forState:(UIControlStateNormal)];
    submitButton.backgroundColor = COLOR(241, 156, 56);
    submitButton.layer.cornerRadius = 5;
    submitButton.clipsToBounds = YES;
    submitButton.titleLabel.font = Regular(15);
    [view addSubview:submitButton];
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view).offset(-20);
        make.height.mas_equalTo(30);
        make.centerX.equalTo(view);
        make.width.mas_equalTo(125);
    }];
    
    _submitB = submitButton;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (string.length <= 0) {
        return YES;
    }
    
    //禁止输入空格
    NSString *tem = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
    
    if (![string isEqualToString:tem]) {
        return NO;
    }
    
    
    if (textField.text.length >= 6) {
        return NO;
    }
   
    
    //  只能输入数字
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *filtered =
    [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    
    
    
    return  [string isEqualToString:filtered];
    
    
    
}
@end
