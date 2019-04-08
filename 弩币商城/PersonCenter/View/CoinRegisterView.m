//
//  CoinRegisterView.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/2/26.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinRegisterView.h"
@interface CoinRegisterView()<UITextFieldDelegate>
@property (nonatomic,strong)UIImageView * BackgroundImageView;
@property (nonatomic,strong)UIImageView * LogoImageView;
@property (nonatomic,strong)NSTimer * countDownTimer;

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
    self.PhoneNumberTF.delegate = self;
    self.PhoneNumberTF.keyboardType = UIKeyboardTypeNumberPad;
    [self SetTextField:self.PhoneNumberTF leftImage:@"手机" placeholdeStr:@"请输入手机号" belowLineY:SetY(278)];
    self.CodeTF = [UITextField new];
      self.CodeTF.keyboardType = UIKeyboardTypeNumberPad;
    [self SetTextField:self.CodeTF leftImage:@"验证" placeholdeStr:@"请输入验证码" belowLineY:SetY(329)];
    
    
    self.PassWordTF1 = [UITextField new];
    self.PassWordTF1.secureTextEntry = YES;
    self.PassWordTF1.delegate = self;
    [self SetTextField:self.PassWordTF1 leftImage:@"密码" placeholdeStr:@"请输入6-16位登录密码" belowLineY:SetY(379)];
    
    self.PassWordTF2 = [UITextField new];
    self.PassWordTF2.secureTextEntry = YES;
    self.PassWordTF2.delegate = self;
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
        make.centerX.equalTo(self).offset(-90);
 make.top.equalTo(self.RegisterButton.mas_bottom).offset(11);
    }];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"注册即视为同意" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Regular" size: 11],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
    label.attributedText = string;
    
    UILabel * label1 = [UILabel new];
    label1.text = @"《用户注册协议》";
    label1.textColor = COLOR(227, 47, 33);
    label1.font = Regular(11);
    [self addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label);
        make.left.equalTo(label.mas_right);
    }];
    
    
    UILabel * label2 = [UILabel new];
    label2.text = @"《隐私保护政策》";
    label2.textColor = COLOR(227, 47, 33);
    label2.font = Regular(11);
    [self addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label);
        make.left.equalTo(label1.mas_right);
    }];
    label1.userInteractionEnabled = YES;
    label2.userInteractionEnabled = YES;
    self.userProtocol = label1;
    self.privacyProtocol = label2;
    [self.PhoneNumberTF addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    
}
- (void)textFieldChanged:(UITextField*)textField{
    
    if (textField.text.length > 11) {
        textField.text = [textField.text substringToIndex:11];
    }
    
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
        [_GetCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.GetCodeButton.adjustsImageWhenHighlighted = NO;
        
        [self.GetCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(imageView);
            make.right.equalTo(BGView).offset(-5);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(15);
        }];
        [self.GetCodeButton addTarget:self action:@selector(GetCodeAction:) forControlEvents:(UIControlEventTouchUpInside)];
        _GetCodeButton.backgroundColor = ThemeColor;
        [_GetCodeButton setTitleColor:COLOR(255, 141, 29) forState:(UIControlStateNormal)];
        _GetCodeButton.titleLabel.font = Regular(10);
        _GetCodeButton.layer.borderWidth = 1;
        _GetCodeButton.layer.borderColor = COLOR(255, 141, 29).CGColor;
        _GetCodeButton.layer.cornerRadius = 5;
    }
    
}

- (void)GetCodeAction:(UIButton *)btn{
    [self endEditing:YES];
    if (self.PhoneNumberTF.text.length == 0) {
        ViewToast(@"请输入手机号", 2);
        return;
    }
    if (![self isPhoneNumber:self.PhoneNumberTF.text]) {
        ViewToast(@"请输入正确的手机号", 2);
        return;
    }
    
    // 调取滑动验证
    MJWeakSelf;
    [BCManagerTool loadTencentCaptcha:self callback:^(NSString *Ticket, NSString *Randstr) {
        if (!BCStringIsEmpty(Ticket) && !BCStringIsEmpty(Randstr)) {
            
            [KTooL GetCodeWithMobile:self.PhoneNumberTF.text action:1 Ticket:Ticket randstr:Randstr success:^(BOOL isSucces) {
                if (isSucces) {
                    [weakSelf changeTimeState];
                }else{
                    ViewToast(@"该手机号码已注册", 2);
                }
            }];
            
        }
       
    }];
    
    
}

- (BOOL)isPhoneNumber:(NSString *)string{
    NSString *mobileRegex = @"[1][34578][0-9]{9}";
    NSPredicate *mobilePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileRegex];
    return [mobilePredicate evaluateWithObject:string];
}


- (void)changeTimeState {
    
    
    __block  NSInteger time = 59; //倒计时时间
    
    
    WS(weakSelf);
    
    //    [_codeButton setTitleColor:White forState:UIControlStateNormal];
    //    _codeButton.layer.borderColor = White.CGColor;
    _GetCodeButton.userInteractionEnabled = NO;
    _countDownTimer = [NSTimer wwl_scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer *timer) {
        
        NSInteger seconds = time % 60;
        time --;
        
        
        [weakSelf.GetCodeButton setTitle:[NSString stringWithFormat:@"%.2ld秒后重试", seconds] forState:UIControlStateNormal];
        
        
        if (time == 0) {
            //设置按钮的样式
            [weakSelf.countDownTimer invalidate];
            weakSelf.countDownTimer = nil;
             [weakSelf.GetCodeButton setTitle:@"重新发送" forState:UIControlStateNormal];
           _GetCodeButton.userInteractionEnabled = YES;
        }
        
    }];
    
    
    [[NSRunLoop currentRunLoop]addTimer:_countDownTimer forMode:NSRunLoopCommonModes];
    [_countDownTimer fire];
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.PhoneNumberTF) {
        //  只能输入数字
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
        NSString *filtered =
        [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return  [string isEqualToString:filtered];
    }
    
    
    if (textField == self.PassWordTF1 || textField == self.PassWordTF2) {
        NSString * s1 = @"qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890";
        return [s1 rangeOfString:string].location != NSNotFound;
    }
    return YES;
   
}
@end
