//
//  CoinRegisterView.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/2/26.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinRegisterView.h"
@interface CoinRegisterView()
@property (nonatomic,strong)UIImageView * BackgroundImageView;
@property (nonatomic,strong)UIImageView * LogoImageView;

@property (nonatomic,strong)UITextField * PhoneNumberTF;
@property (nonatomic,strong)UITextField * CodeTF;
@property (nonatomic,strong)UITextField * PassWordTF1;
@property (nonatomic,strong)UITextField * PassWordTF2;
@property (nonatomic,strong)UIButton * GetCodeButton;


@end
@implementation CoinRegisterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self SetUI];
    }
    return self;
}

- (void)SetUI{
    self.backgroundColor = [UIColor whiteColor];
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
    self.PhoneNumberTF = [UITextField new];
    self.PhoneNumberTF.keyboardType = UIKeyboardTypeNumberPad;
    [self SetTextField:self.PhoneNumberTF leftImage:@"手机" placeholdeStr:@"请输入手机号" belowLineY:SetY(278)];
    self.CodeTF = [UITextField new];
      self.CodeTF.keyboardType = UIKeyboardTypeNumberPad;
    [self SetTextField:self.CodeTF leftImage:@"验证" placeholdeStr:@"请输入验证码" belowLineY:SetY(329)];
    
    
    self.PassWordTF1 = [UITextField new];
    self.PassWordTF1.secureTextEntry = YES;
    [self SetTextField:self.PassWordTF1 leftImage:@"密码" placeholdeStr:@"请输入6-16位登录密码" belowLineY:SetY(379)];
    
    self.PassWordTF2 = [UITextField new];
    self.PassWordTF2.secureTextEntry = YES;
    [self SetTextField:self.PassWordTF2 leftImage:@"密码" placeholdeStr:@"确认密码" belowLineY:SetY(430)];
    
    self.RegisterButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.RegisterButton setBackgroundImage:[UIImage imageNamed:@"注册"] forState:(UIControlStateNormal)];
    self.RegisterButton.adjustsImageWhenHighlighted = NO;
    [self addSubview:self.RegisterButton];
    [self.RegisterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(SetX(45));
        make.right.equalTo(self).offset(SetX(-45));
        make.height.mas_offset(SetY(45));
        make.top.equalTo(self).offset(SetY(447));
    }];
    
    
    UILabel *label = [[UILabel alloc] init];
    
    label.numberOfLines = 0;
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
make.top.equalTo(self.RegisterButton.mas_bottom).offset(11);
    }];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"注册即视为同意《用户注册协议》《隐私保护政策》" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Regular" size: 11],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
    
    [string addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:227/255.0 green:47/255.0 blue:33/255.0 alpha:1.0]} range:NSMakeRange(7, 7)];
    [string addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:227/255.0 green:47/255.0 blue:33/255.0 alpha:1.0]} range:NSMakeRange(14, 1)];
    
    [string addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:227/255.0 green:47/255.0 blue:33/255.0 alpha:1.0]} range:NSMakeRange(15, 1)];
    
    [string addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:227/255.0 green:47/255.0 blue:33/255.0 alpha:1.0]} range:NSMakeRange(16, 7)];
    label.attributedText = string;
}

- (void)SetTextField:(UITextField *)textField leftImage:(NSString *)imageName placeholdeStr:(NSString *)placeholdeStr belowLineY:(CGFloat)belowLineY{
    UIView * BGView = [UIView new];
    [self addSubview:BGView];
    [BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(SetX(45));
        make.right.equalTo(self).offset(SetX(-45));
        make.height.mas_equalTo(SetY(51));
        make.bottom.equalTo(self.mas_top).offset(belowLineY);
    }];
    
    UIView * lineView = [UIView new];
    lineView.backgroundColor = COLOR(153, 153, 153);
    [BGView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(BGView);
        make.height.mas_equalTo(0.5);
    }];
    UIImageView *  imageView = [UIImageView new];
    [BGView addSubview:imageView];
    imageView.image = [UIImage imageNamed:imageName];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(BGView).offset(10);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(18);
        make.bottom.equalTo(BGView).offset(-13);
    }];
    [BGView addSubview:textField];
    textField.placeholder = placeholdeStr;
    [textField setValue:COLOR(153, 153, 153) forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).offset(10);
        make.right.equalTo(BGView);
        make.centerY.equalTo(imageView);
    }];
    
    if (textField == self.CodeTF) {
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(BGView).offset(-100);
        }];
        
        self.GetCodeButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [BGView addSubview:self.GetCodeButton];
        [self.GetCodeButton setBackgroundImage:[UIImage imageNamed:@"获取验证码"] forState:(UIControlStateNormal)];
        self.GetCodeButton.adjustsImageWhenHighlighted = NO;
        
        [self.GetCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(imageView);
            make.right.equalTo(BGView).offset(-5);
        }];
        [self.GetCodeButton addTarget:self action:@selector(GetCodeAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
}

- (void)GetCodeAction:(UIButton *)btn{
    [self endEditing:YES];
    if (![self isPhoneNumber:self.PhoneNumberTF.text]) {
        return;
    }
    
}

- (BOOL)isPhoneNumber:(NSString *)string{
    NSString *mobileRegex = @"[1][34578][0-9]{9}";
    NSPredicate *mobilePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileRegex];
    return [mobilePredicate evaluateWithObject:string];
}

@end
