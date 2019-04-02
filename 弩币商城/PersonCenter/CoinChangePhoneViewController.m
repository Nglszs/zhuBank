//
//  CoinChangePhoneViewController.m
//  弩币商城
//
//  Created by Jack on 2019/2/28.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinChangePhoneViewController.h"
#import "CoinChangePasswordViewController.h"
#import "CoinChangeSuccessViewController.h"
#import "CoinChangePayCodeViewController.h"


@interface CoinChangePhoneViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *phoneField,*messageCodeField;

@property (nonatomic, strong) UIButton *codeButton;//验证码按钮


@property (nonatomic, strong) NSTimer *countDownTimer;//定时器
@end

@implementation CoinChangePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initView];
    
}

- (void)initView {
   
    
    UILabel *titleL = [[UILabel alloc] init];
    if (_isChangePhone) {
          titleL.text = @"修改绑定手机号码";
    } else {
        
        if (_isSetPay) {
            titleL.text = @"短信设置交易密码";
        } else {
            
             titleL.text = @"短信修改交易密码";
        }
        
        
    }
  
      self.navigationItem.title = titleL.text;
    titleL.textColor = TITLE_COLOR;
    titleL.font = Regular(15);
    [self.view addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(20);
        
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(15);
    }];
    
    
    
   UITextField *_countTextField = [[UITextField alloc] init];
    
    _countTextField.keyboardType = UIKeyboardTypeNumberPad;
    _countTextField.delegate = self;
    _countTextField.textColor = COLOR(102, 102, 102);
    
    _phoneField = _countTextField;
    _countTextField.font = Regular(15);
   
    if (!_isChangePhone) {//如果是交易密码，则吧手机号码直接传入
        
        _countTextField.text = _phoneNum;
    } else {
        _countTextField.placeholder = @"请输入您的手机号码";
    }
    
    UIImageView *leftI = [[UIImageView alloc]initWithFrame:CGRectMake(12, 0, 18, 22)];
    leftI.image = BCImage(手机);
    
    UIView *leftV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 47, 22)];
    [leftV addSubview:leftI];
    
    _countTextField.leftView = leftV;
    _countTextField.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:_countTextField];
    [_countTextField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(40);
        make.top.equalTo(titleL.mas_bottom).offset(14);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(BCWidth - 80);
    }];
    
    
//    分割线
    UIImageView *lineImage = [[UIImageView alloc] init];
    lineImage.backgroundColor = COLOR(242, 242, 242);
    
    [self.view addSubview:lineImage];
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
    [self.view addSubview:leftL];
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
    
    [self.view addSubview:_messageCodeField];
    
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
    UIButton *backBtn1 = [[UIButton alloc] init];
    backBtn1.titleLabel.font = Regular(17);
    [backBtn1 setTitle:@"下一步" forState:UIControlStateNormal];
    [backBtn1 setTitleColor:White forState:UIControlStateNormal];
    backBtn1.layer.cornerRadius = 20;
    
    backBtn1.backgroundColor = COLOR(227, 47, 33);
    [self.view addSubview:backBtn1];
    [backBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_messageCodeField.mas_bottom).offset(32);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(250);
    }];
    
    [backBtn1 addtargetBlock:^(UIButton *button) {
        
        if (_phoneField.text.length <= 0) {
            
            
            VCToast(@"手机号码不能为空", 1);
            
            return;
        }
        
        if (![Tool isMobileNumber:_phoneField.text]) {
            VCToast(@"手机号码错误", 1);
            return;
        }
        
        
        if (_messageCodeField.text.length <= 0) {
           
            VCToast(@"验证码不能为空", 1);
            
            return;
        }
        
        
        if (_isChangePhone) {//修改手机号码
            [KTooL HttpPostWithUrl:@"UserCenter/reset_mobile" parameters:@{@"new_mobile":_phoneField.text,@"verify_code":_messageCodeField.text} loadString:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                
                NSLog(@"===%@",responseObject);
                
                
                if (BCStatus) {
                    
                    CoinChangeSuccessViewController *vc = [[CoinChangeSuccessViewController alloc] init];
                    vc.isChangePhone = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                } else {
                    
                    VCToast([responseObject objectNilForKey:@"msg"], 1);
                }
                
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                
            }];
            
        }else {
            
            
            [KTooL HttpPostWithUrl:@"User/check_sms" parameters:@{@"mobile":_phoneField.text,@"verify_code":_messageCodeField.text,@"action":@"2"} loadString:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                
                NSLog(@"===%@",responseObject);
                
                
                if (BCStatus) {
                    
                    CoinChangePayCodeViewController *vc = [[CoinChangePayCodeViewController alloc] init];
                  
                    vc.isChangePay = !_isSetPay;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                } else {
                    
                    VCToast([responseObject objectNilForKey:@"msg"], 1);
                }
                
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                
            }];
            
           
        }
       
       
        
    }];
    
}

#pragma mark 点击验证码倒计时
- (void)clickCodeButton {
    
    
    if (_phoneField.text.length <= 0) {


        VCToast(@"手机号码不能为空", 1);

        return;
    }
    
    if (![Tool isMobileNumber:_phoneField.text]) {
         VCToast(@"手机号码错误", 1);
        return;
    }
    
    //    网络请求成功后调用下方代码
    [self.view endEditing:YES];
    MJWeakSelf;
    [BCManagerTool loadTencentCaptcha:self.view callback:^(NSString *Ticket, NSString *Randstr) {
        if (!BCStringIsEmpty(Ticket) && !BCStringIsEmpty(Randstr)) {
            [KTooL GetCodeWithMobile:self.phoneField.text action:2 Ticket:Ticket randstr:Randstr success:^(BOOL isSucces) {
                if (isSucces) {
                    [weakSelf changeTimeState];
                }
            }];
        }
        
    }];
   
   
    
    
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
          
            
            weakSelf.codeButton.userInteractionEnabled = YES;
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
    
    
    if (textField == _phoneField) {
        
        if (textField.text.length >= 11) {
            return NO;
        }
    }
    
    //  只能输入数字
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *filtered =
    [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    
    
    
    return  [string isEqualToString:filtered];
    
    
    
}

@end
