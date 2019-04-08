//
//  CoinLoginView.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/2/25.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinLoginView.h"


@interface CoinLoginView()<UITextFieldDelegate>
@property (nonatomic,strong)UIImageView * BackgroundImageView;
@property (nonatomic,strong)UIImageView * LogoImageView;


@end

@implementation CoinLoginView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self SetUI];
    }
    return self;
   
}

- (void)SetUI{
    self.BackgroundImageView = [UIImageView new];
    self.BackgroundImageView.image = [UIImage imageNamed:@"bj"];
    [self addSubview:self.BackgroundImageView];
    [self.BackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(SetY(220));
    }];
    
    self.LogoImageView = [UIImageView new];
    self.LogoImageView.image = [UIImage imageNamed:@"图标"];
    [self.BackgroundImageView addSubview:self.LogoImageView];
    [self.LogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.BackgroundImageView);
        make.width.height.mas_equalTo(SetX(68));
    }];
    
    UIView * userNameLineView = [UIView new];
    userNameLineView.backgroundColor = COLOR(153, 153, 153);
    [self addSubview:userNameLineView];
    
    [userNameLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.BackgroundImageView.mas_bottom).offset(SetY(60));
        make.width.mas_equalTo(SetX(285));
        make.height.mas_equalTo(0.5);
    }];
    
    UIImageView * UserNameLogoImageView = [UIImageView new];
    [self addSubview:UserNameLogoImageView];
    UserNameLogoImageView.image = [UIImage imageNamed:@"用户名"];
    [UserNameLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(userNameLineView).offset(-8);
        make.left.equalTo(userNameLineView).offset(6);
        make.width.height.mas_equalTo(18);
    }];
    
    self.UserNameTF = [UITextField new];
    [self addSubview:self.UserNameTF];
    self.UserNameTF.placeholder = @"请输入手机号";
    [self.UserNameTF setValue:COLOR(153, 153, 153) forKeyPath:@"_placeholderLabel.textColor"];
    [self.UserNameTF setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [self.UserNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(UserNameLogoImageView.mas_right).offset(10);
        make.right.equalTo(userNameLineView);
        make.centerY.equalTo(UserNameLogoImageView);
    }];
    self.UserNameTF.keyboardType =  UIKeyboardTypeNumberPad;
    self.UserNameTF.delegate = self;
    UIView * PasswordLineView = [UIView new];
    [self addSubview:PasswordLineView];
    PasswordLineView.backgroundColor = userNameLineView.backgroundColor;
    [PasswordLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(userNameLineView);
        make.top.equalTo(userNameLineView).offset(SetY(51));
        
    }];
    
    UIImageView * PasswordLogoImageView = [[UIImageView alloc] init];
    PasswordLogoImageView.image = [UIImage imageNamed:@"密码"];
    [self addSubview:PasswordLogoImageView];
    [PasswordLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(UserNameLogoImageView);
        make.centerX.equalTo(UserNameLogoImageView);
        make.width.mas_equalTo(14); make.bottom.equalTo(PasswordLineView.mas_top).offset(-8);
    }];
    
    self.PasswordTF = [UITextField new];
    [self addSubview:self.PasswordTF];
    
    self.PasswordTF.placeholder = @"请输入密码";
    [self.PasswordTF setValue:COLOR(153, 153, 153) forKeyPath:@"_placeholderLabel.textColor"];
    [self.PasswordTF setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    self.PasswordTF.secureTextEntry = YES;
    self.PasswordTF.delegate = self;
    [self.PasswordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.UserNameTF);
        make.right.equalTo(self.UserNameTF).offset(-50);
         make.centerY.equalTo(PasswordLogoImageView);
    }];
    
    UIButton * showPW = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [showPW setBackgroundImage:BCImage(闭眼) forState:(UIControlStateNormal)];
    [showPW setBackgroundImage:BCImage(睁眼) forState:(UIControlStateSelected)];
    showPW.adjustsImageWhenHighlighted = NO;
    [self addSubview:showPW];
    [showPW addtargetBlock:^(UIButton *button) {
        button.selected = !button.selected;
        self.PasswordTF.secureTextEntry = !button.selected;
    }];
    self.PasswordTF.delegate = self;
    
    [showPW mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.PasswordTF);
        make.left.equalTo(self.PasswordTF.mas_right).offset(20);
    }];
    
    self.LoginButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self addSubview:self.LoginButton];
    [self.LoginButton setBackgroundImage:[UIImage imageNamed:@"登录"] forState:(UIControlStateNormal)];
    [self.LoginButton setBackgroundImage:[UIImage imageNamed:@"登录"] forState:(UIControlStateSelected)];
    
    [self.LoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.mas_equalTo(SetX(230));
        make.height.mas_equalTo(SetY(45));
        make.top.equalTo(self).offset(SetY(377));
    }];
    
    self.RegisterButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.RegisterButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.RegisterButton];
    [self.RegisterButton setTitleColor:COLOR(51, 51, 51) forState:(UIControlStateNormal)];
     [self.RegisterButton setTitleColor:COLOR(51, 51, 51) forState:(UIControlStateSelected)];
    [self.RegisterButton setTitle:@"快速注册" forState:(UIControlStateNormal)];
    [self.RegisterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(PasswordLineView);
        make.top.equalTo(self.LoginButton.mas_bottom).offset(15);
        
    }];
    
    
    self.ForgetPasswordButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.ForgetPasswordButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.ForgetPasswordButton];
    [self.ForgetPasswordButton setTitleColor:COLOR(51, 51, 51) forState:(UIControlStateNormal)];
    [self.ForgetPasswordButton setTitleColor:COLOR(51, 51, 51) forState:(UIControlStateSelected)];
    [self.ForgetPasswordButton setTitle:@"忘记密码" forState:(UIControlStateNormal)];
    [self.ForgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(PasswordLineView);
        make.top.equalTo(self.LoginButton.mas_bottom).offset(15);
        
    }];
    self.LoginButton.adjustsImageWhenHighlighted = NO;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (textField == self.UserNameTF) {
        if (![self isMobileNumber:self.UserNameTF.text]) {
            ViewToast(@"请输入正确的手机号", 2);
        }
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.UserNameTF) {
        NSString * string2 = [NSString stringWithFormat:@"%@%@",textField.text,string];
        if (string2.length == 11 && ![self isMobileNumber:string2]) {
            ViewToast(@"请输入正确的手机号", 2);
        }
        if (string2.length > 11) {
            return NO;
        }
        NSString * s1 = @"1234567890";
        return [s1 rangeOfString:string].location != NSNotFound;
    }
    
    if (textField == self.PasswordTF) {
        NSString * s1 = @"qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890";
        return [s1 rangeOfString:string].location != NSNotFound;
    }
  return YES;
}

@end
