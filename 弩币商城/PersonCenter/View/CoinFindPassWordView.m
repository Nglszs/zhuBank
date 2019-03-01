//
//  CoinFindPassWordView.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/1.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinFindPassWordView.h"

@interface CoinFindPassWordView()
@property (nonatomic,strong)UITextField * messageCodeField;
@property (nonatomic,strong)UIButton * codeButton;
@property (nonatomic,strong)NSTimer * countDownTimer;

@end
@implementation CoinFindPassWordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}
- (void)initView{
    self.backgroundColor = [UIColor whiteColor];
    UIImageView * BeginImageView = [UIImageView new];
    BeginImageView.image = [UIImage imageNamed:@"组4"];
    [self addSubview:BeginImageView];
    [BeginImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(SetX(41));
        make.top.equalTo(self).offset(SetY(41));
        make.width.height.mas_equalTo(21);
    }];
    UILabel * beginLabel = [UILabel new];
    [self addSubview:beginLabel];
    beginLabel.font = Regular(12);
    beginLabel.text = @"账号验证";
    beginLabel.textColor = COLOR(102, 102, 102);
    [self addSubview:beginLabel];
    
    [beginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(BeginImageView);
        make.top.equalTo(BeginImageView.mas_bottom).offset(10);
    }];
    
    
    
    UIImageView * CentreImageView = [UIImageView new];
    CentreImageView.image = [UIImage imageNamed:@"更新密码"];
    [self addSubview:CentreImageView];
    [CentreImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(SetY(41));
        make.width.height.mas_equalTo(21);
    }];
    UILabel * CenterLabel = [UILabel new];
    [self addSubview:CenterLabel];
    CenterLabel.font = Regular(12);
    CenterLabel.text = @"更新密码";
    CenterLabel.textColor = COLOR(102, 102, 102);
    [self addSubview:CenterLabel];
    
    [CenterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(CentreImageView);
        make.top.equalTo(BeginImageView.mas_bottom).offset(10);
    }];
    
    
    UIImageView * OverImageView = [UIImageView new];
    OverImageView.image = [UIImage imageNamed:@"更新密码"];
    [self addSubview:OverImageView];
    [OverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-SetX(41));
        make.top.equalTo(self).offset(SetY(41));
        make.width.height.mas_equalTo(21);
    }];
    UILabel * OverLabel = [UILabel new];
    [self addSubview:OverLabel];
    OverLabel.font = Regular(12);
    OverLabel.text = @"完成";
    OverLabel.textColor = COLOR(102, 102, 102);
    [self addSubview:OverLabel];
    
    [OverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(OverImageView);
        make.top.equalTo(BeginImageView.mas_bottom).offset(10);
    }];
    
    UIView * lineView = [UIView new];
   lineView.backgroundColor =  COLOR(217, 217, 217);
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(BeginImageView);
        make.right.equalTo(OverImageView);
        make.height.mas_equalTo(0.5);
    }];
    [self sendSubviewToBack:lineView];
    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.font = Regular(17);
    titleLabel.textColor = COLOR(102, 102, 102);
    titleLabel.text = @"账号验证";
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(CenterLabel.mas_bottom).offset(SetY(54));
    }];
    
    
    UITextField *_countTextField = [[UITextField alloc] init];
    
    _countTextField.keyboardType = UIKeyboardTypeNumberPad;
    _countTextField.delegate = self;
    _countTextField.textColor = COLOR(102, 102, 102);
    _countTextField.placeholder = @"请输入您的手机号码";
    
    _countTextField.font = Regular(15);
    
    
    UIImageView *leftI = [[UIImageView alloc]initWithFrame:CGRectMake(12, 0, 18, 22)];
    leftI.image = BCImage(手机);
    
    UIView *leftV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 47, 22)];
    [leftV addSubview:leftI];
    
    _countTextField.leftView = leftV;
    _countTextField.leftViewMode = UITextFieldViewModeAlways;
    
    [self addSubview:_countTextField];
    [_countTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(40);
        make.top.equalTo(titleLabel.mas_bottom).offset(14);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(BCWidth - 80);
    }];
    
    
    //    分割线
    UIImageView *lineImage = [[UIImageView alloc] init];
    lineImage.backgroundColor = COLOR(242, 242, 242);
    
    [self addSubview:lineImage];
    [lineImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(40);
        make.top.equalTo(_countTextField.mas_bottom).offset(4);
        make.width.mas_equalTo(BCWidth - 80);
        make.height.mas_equalTo(1);
    }];
    
    
    //    验证码
    UILabel *leftL = [[UILabel alloc] init];
    leftL.text = @"验证码：";
    leftL.textColor = COLOR(102, 102, 102);
    leftL.font = Regular(15);
    [self addSubview:leftL];
    [leftL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(lineImage.mas_bottom).offset(25);
        make.left.mas_equalTo(40);
        make.height.mas_equalTo(25);
        
    }];
    
    
    
    //  输入框
    _messageCodeField = [[UITextField alloc] init];
    _messageCodeField.placeholder = @"输入验证码";
    _messageCodeField.textColor = COLOR(102, 102, 102);
    _messageCodeField.font = Regular(15);
    _messageCodeField.delegate = self;
    _messageCodeField.autocorrectionType = UITextAutocorrectionTypeNo;
    _messageCodeField.keyboardType = UIKeyboardTypeNumberPad;
    _messageCodeField.layer.cornerRadius = 4;
    _messageCodeField.layer.borderWidth = 1;
    _messageCodeField.layer.borderColor = COLOR(153, 153, 153).CGColor;
    [_messageCodeField changePlaceholderFont:Regular(15)];
    [_messageCodeField changePlaceholderColor:Gray_Color];
    
    [self addSubview:_messageCodeField];
    
    [_messageCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(leftL);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(BCWidth - 140);
        make.left.mas_equalTo(leftL.mas_right).offset(5);
        
    }];
    
    
    UIView *rightV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 75, 22)];
    // 验证码按钮
    _codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _codeButton.frame = CGRectMake(0, 3.5, 60, 15);
    _codeButton.backgroundColor = ThemeColor;
    [_codeButton setTitleColor:COLOR(254, 36, 72) forState:UIControlStateNormal];
    [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    [_codeButton addTarget:self action:@selector(clickCodeButton) forControlEvents:UIControlEventTouchUpInside];
    _codeButton.titleLabel.font = Regular(10);
    _codeButton.layer.borderWidth = 1;
    _codeButton.layer.borderColor = COLOR(254, 36, 72).CGColor;
    _codeButton.layer.cornerRadius = 5;
    [rightV addSubview:_codeButton];
    
    _messageCodeField.rightViewMode = UITextFieldViewModeAlways;
    _messageCodeField.rightView = rightV;
    
    _messageCodeField.leftViewMode = UITextFieldViewModeAlways;
    _messageCodeField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    
    
    
    
    //    下一步
    UIButton * backBtn1 = [[UIButton alloc] init];
    backBtn1.titleLabel.font = Regular(17);
    [backBtn1 setTitle:@"下一步" forState:UIControlStateNormal];
    [backBtn1 setTitleColor:White forState:UIControlStateNormal];
    backBtn1.layer.cornerRadius = 20;
    
    backBtn1.backgroundColor = COLOR(227, 47, 33);
    [self addSubview:backBtn1];
    [backBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self->_messageCodeField.mas_bottom).offset(32);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(250);
    }];
    
    [backBtn1 addtargetBlock:^(UIButton *button) {
        
      
    }];
    
}

#pragma mark 点击验证码倒计时
- (void)clickCodeButton {
    
    
    //    if (![self isMobileNumber:_phoneField.text]) {
    //
    //
    //        VCToast(@"手机号码错误", 1);
    //
    //        return;
    //    }
    
    //    网络请求成功后调用下方代码
    [self changeTimeState];
    
    
    
}

- (void)changeTimeState {
    
    
    __block  NSInteger time = 59; //倒计时时间
    
    
    WS(weakSelf);
    
    //    [_codeButton setTitleColor:White forState:UIControlStateNormal];
    //    _codeButton.layer.borderColor = White.CGColor;
    _codeButton.userInteractionEnabled = NO;
    _countDownTimer = [NSTimer wwl_scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer *timer) {
        
        
        
        NSInteger seconds = time % 60;
        time --;
        
        
        [weakSelf.codeButton setTitle:[NSString stringWithFormat:@"%.2ld秒后重试", seconds] forState:UIControlStateNormal];
        
        
        if (time == 0) {
            //设置按钮的样式
            [weakSelf.countDownTimer invalidate];
            weakSelf.countDownTimer = nil;
            
            
            
            [weakSelf.codeButton setTitle:@"重新发送" forState:UIControlStateNormal];
            
            
            //            防止倒计时结束前修改了号码
            //            [self textValueChanged:nil];
            
        }
        
    }];
    
    
    [[NSRunLoop currentRunLoop]addTimer:_countDownTimer forMode:NSRunLoopCommonModes];
    [_countDownTimer fire];
    
}
#pragma mark textfield 代理
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    if (string.length <= 0) {
        return YES;
    }
    
    //禁止输入空格
    NSString *tem = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
    
    if (![string isEqualToString:tem]) {
        return NO;
    }
    
    
    
    //  只能输入数字
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *filtered =
    [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    
    
    
    return  [string isEqualToString:filtered];
    
    
    
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
    
}


@end
