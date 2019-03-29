//
//  CoinCertifyViewController.m
//  弩币商城
//
//  Created by Jack on 2019/3/6.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinCertifyViewController.h"
#import "FOSAuthController.h"

#import "CoinBindingCardViewController.h"


@interface CoinCertifyViewController ()<UIScrollViewDelegate,UITextFieldDelegate>
{
    BOOL isSuccess;//是否认证成功
    UIButton *selectedBtn;
    UITextField *nameF,*numberF,*addressF,*cardNumF,*phoneF,*codeF;
    NSString *llToken;//连连需要的
    NSDictionary *dataDic;
}

@property (nonatomic, strong) UIView *headView;//头部标签
@property (nonatomic, strong) UIScrollView *backScrollView;
@property (nonatomic, strong) UIButton *codeButton;//验证码按钮

@property (nonatomic, strong) NSTimer *countDownTimer;//定时器
@end

@implementation CoinCertifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"身份验证";
   
    llToken = @"";
    
    [self.view addSubview:self.headView];
    [self.view addSubview:self.backScrollView];
    
    
    [self initView];
    [self initSecondView];
    [self initThirdView];
   
    
    if (_indexType == 2) {//直接去银行卡界面
        
       [self.backScrollView setContentOffset:CGPointMake(BCWidth * _indexType, 0) animated:NO];
        
          [self getBindCard];
    }
    
    if (_indexType == 3) {
        [self TestISSuccess];
    }
   
    
 
    
}

- (void)initView {
    
    
    UIView *backV = [[UIView alloc] init];
    backV.backgroundColor  = White;
    [self.backScrollView addSubview:backV];
    [backV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.mas_equalTo(0);
        make.height.mas_equalTo(self.view.mas_height);
        make.width.mas_equalTo(BCWidth);
    }];
   
    NSArray *titleA = @[@"真实姓名：",@"身份证号：",@"户籍地址："];
     NSArray *titleA1 = @[@"请输入您的姓名",@"请输入您的身份证号",@"请输入您的户籍所在地"];
    
    
    for (int i = 0; i < titleA.count; i ++) {
        
        
        UILabel *titleL = [[UILabel alloc] init];
        
        titleL.text = titleA[i];
        titleL.textColor = TITLE_COLOR;
        titleL.font = Regular(14);
        [backV addSubview:titleL];
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(20 + i*(50));
            
            make.left.mas_equalTo(LEFT_Margin);
            make.height.mas_equalTo(14);
        }];
        
        
        
        UITextField *_countTextField = [[UITextField alloc] init];
        

        _countTextField.delegate = self;
        _countTextField.textColor = TITLE_COLOR;
        _countTextField.placeholder = titleA1[i];
    
        _countTextField.font = Regular(14);
        [backV addSubview:_countTextField];
        [_countTextField mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.height.equalTo(titleL);
            make.width.mas_equalTo(250); make.left.equalTo(titleL.mas_right).offset(TOP_Margin);
            
        }];
        
        if (i == 0) {
            nameF = _countTextField;
        } else if (i == 1){
            
            numberF = _countTextField;
        } else {
            addressF = _countTextField;
        }
        
        
        UIImageView *lineImage = [[UIImageView alloc] init];
        lineImage.backgroundColor = COLOR(238, 238, 238);
        
        [backV addSubview:lineImage];
        [lineImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(LEFT_Margin);
            make.right.mas_equalTo(-LEFT_Margin);
            make.top.mas_equalTo((i + 1)*(50));
            
            make.height.mas_equalTo(1);
        }];
        
    }
    
    
    
    UIButton *backBtn1 = [[UIButton alloc] init];
    backBtn1.titleLabel.font = Regular(18);
    [backBtn1 setTitle:@"下一步" forState:UIControlStateNormal];
    [backBtn1 setTitleColor:White forState:UIControlStateNormal];
    backBtn1.layer.cornerRadius = 5;
    backBtn1.backgroundColor = COLOR(255, 141, 29);
    [backV addSubview:backBtn1];
    [backBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(LEFT_Margin);
        make.top.mas_equalTo(188);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(BCWidth - 30);
    }];
    [backBtn1 addTarget:self action:@selector(getData) forControlEvents:UIControlEventTouchUpInside];

    
    
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
    
    if (textField==numberF) {
        
        if (textField.text.length >=18) {
            return NO;
        }
    }
    
    return YES;
}
#pragma mark 验证个人信息
- (void)getData {
    
    if (nameF.text.length <= 0) {
        VCToast(@"姓名不能为空", 1);
        
        return;
    }
    
    if (numberF.text.length <= 0) {
        VCToast(@"身份证号不能为空", 1);
        
        return;
    }
    
    
    if (addressF.text.length <= 0) {
        VCToast(@"地址不能为空", 1);
        
        return;
    }
    [KTooL HttpPostWithUrl:@"MaterialVerify/identity_verify" parameters:@{@"name":nameF.text,@"idcard":numberF.text,@"address":addressF.text,@"reg_from":@"3"} loadString:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSLog(@"===%@",responseObject);
        
        
        if (BCStatus) {
            
            FOSAuthController *VC =  [FOSAuthController new];
            VC.params = @{@"name":nameF.text,@"cardNo":numberF.text};
            [self.navigationController pushViewController:VC animated:YES];
            VC.backBlock = ^(id  _Nonnull result) {//成功之后跳转
                
                if ([result isEqualToString:@"1"]) {
                     [self.backScrollView setContentOffset:CGPointMake(BCWidth, 0) animated:YES];
                } 
               
            };
            
//
            
        } else {
              VCToast(@"身份验证失败", 1);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
       
        VCToast(@"验证失败", 1);
    }];
}

- (void)initSecondView {
    
    
    UIView *backV = [[UIView alloc] init];
    backV.backgroundColor  = White;
    [self.backScrollView addSubview:backV];
    [backV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(BCWidth);
        make.height.mas_equalTo(self.view.mas_height);
        make.width.mas_equalTo(BCWidth);
    }];
    
    UIImageView *leftI = [[UIImageView alloc]init];
    leftI.image = BCImage(组 3);
    [backV addSubview:leftI];
    [leftI mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(60);
        make.top.mas_equalTo(34);
        
    }];
    
    
    UILabel *leftL = [[UILabel alloc] init];
    leftL.text = @"您的信息一致，人脸识别认证成功";
    leftL.textColor = COLOR(18, 213, 41);
    leftL.font = Regular(13);
    [backV addSubview:leftL];
    [leftL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(leftI);
        make.left.equalTo(leftI.mas_right).offset(TOP_Margin);
        make.height.mas_equalTo(13);
        
    }];
    
    
    UILabel *leftL1 = [[UILabel alloc] init];
    leftL1.text = @"此次比对分数是88.86分。";
    leftL1.textColor = COLOR(188, 188, 188);
//    leftL1.font = Regular(13);
//    [backV addSubview:leftL1];
//    [leftL1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(leftI.mas_bottom).offset(5);
//        make.centerX.equalTo(backV);
//        make.height.mas_equalTo(13);
//        
//    }];
    
    
    
    UIButton *backBtn1 = [[UIButton alloc] init];
    backBtn1.titleLabel.font = Regular(18);
    [backBtn1 setTitle:@"下一步" forState:UIControlStateNormal];
    [backBtn1 setTitleColor:White forState:UIControlStateNormal];
    backBtn1.layer.cornerRadius = 5;
    backBtn1.backgroundColor = COLOR(255, 141, 29);
    [backV addSubview:backBtn1];
    [backBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(LEFT_Margin);
        make.top.mas_equalTo(138);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(BCWidth - 30);
    }];
    
    [backBtn1 addtargetBlock:^(UIButton *button) {
        
        [self.backScrollView setContentOffset:CGPointMake(BCWidth * 2, 0) animated:YES];
          [self getBindCard];
    }];
    
    
}


#pragma mark 绑卡展示页面
- (void)getBindCard {
    
    [KTooL HttpPostWithUrl:@"MaterialVerify/card_bind" parameters:nil loadString:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSLog(@"===%@",responseObject);
        
        
        if (BCStatus) {
            UILabel *leftL = [self.backScrollView viewWithTag:1000];
            leftL.text = [NSString stringWithFormat:@"请使用持卡人(%@)的储蓄卡，完成绑卡认证",[[responseObject objectNilForKey:@"data"] objectNilForKey:@"name"]];
           UILabel *priceL =  [self.backScrollView viewWithTag:2000];
            [priceL addTapGestureWithBlock:^{
            
                CoinH5ViewController *VC = [[CoinH5ViewController alloc] init];
                VC.titleStr = @"银行代扣授权书";
                VC.url = [[responseObject objectNilForKey:@"data"] objectNilForKey:@"withhold"];
                [self.navigationController pushViewController:VC animated:YES];
            }];
            
            
        } else {
            
            VCToast(@"获取绑卡信息失败", 1);
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        VCToast(@"获取绑卡信息失败", 1);
    }];
}

- (void)initThirdView {
    
   
    
    UIView *backV = [[UIView alloc] init];
    backV.backgroundColor  = White;
    [self.backScrollView addSubview:backV];
    [backV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(BCWidth * 2);
        make.height.mas_equalTo(self.view.mas_height);
        make.width.mas_equalTo(BCWidth);
    }];
    
    UIImageView *divideView = [[UIImageView alloc] init];
    divideView.backgroundColor = COLOR(238, 238, 238);
    [backV addSubview:divideView];
    [divideView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(26);
        make.width.mas_equalTo(BCWidth);
        
    }];
    
    
    UILabel *leftL = [[UILabel alloc] init];
    leftL.text = @"请使用持卡人(刘*华)的储蓄卡，完成绑卡认证";
    leftL.tag = 1000;
    leftL.textColor = COLOR(188, 188, 188);
    leftL.font = Regular(10);
    [backV addSubview:leftL];
    [leftL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(LEFT_Margin);
        make.height.mas_equalTo(26);
        
    }];
    
    NSString *useStr;
    if (_isFenqi) {//如果是分期
        
        useStr = @"分期购买商品";
        
    } else {
        
       useStr = @"帑库银票借款";
    }
    
    NSArray *titleA = @[@"绑卡用途：",@"银行卡号：",@"银行卡预留手机号：",@"手机短信验证码："];
    NSArray *titleA1 = @[useStr,@"请输入本人银行卡号",@"请输入您的预留手机号",@"请输入手机短信验证码"];
    
    
    for (int i = 0; i < titleA.count; i ++) {
        
        
        UILabel *titleL = [[UILabel alloc] init];
        
        titleL.text = titleA[i];
        titleL.textColor = TITLE_COLOR;
        titleL.font = Regular(12);
        titleL.textAlignment = NSTextAlignmentRight;
        [backV addSubview:titleL];
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(divideView.mas_bottom).offset(20 + i*(50));
            make.width.mas_equalTo(120);
            make.left.mas_equalTo(LEFT_Margin);
            make.height.mas_equalTo(12);
        }];
        
        
        if (i == 0) {
            
            UIButton *backBtn= [[UIButton alloc] init];
            
            [backBtn setTitle:[titleA1 objectAtIndex:i] forState:UIControlStateNormal];
            [backBtn setTitleColor:COLOR(167, 167, 167) forState:UIControlStateNormal];
            backBtn.titleLabel.font = Regular12Font;
            backBtn.contentHorizontalAlignment = 2;
//            [backBtn setImage:BCImage(查看更多) forState:UIControlStateNormal];
            [backV addSubview:backBtn];
            
            [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.equalTo(titleL);
                make.left.mas_equalTo(BCWidth - 100 - LEFT_Margin);
                make.height.mas_equalTo(40);
                make.width.mas_equalTo(100);
            }];
            [backBtn imagePositionStyle:ImagePositionStyleRight spacing:7];
            
        } else {
        
        UITextField *_countTextField = [[UITextField alloc] init];
        
        //        _countTextField.keyboardType = UIKeyboardTypeNumberPad;
        //        _countTextField.delegate = self;
        _countTextField.textColor = TITLE_COLOR;
        _countTextField.placeholder = titleA1[i];
            [_countTextField changePlaceholderFont:Regular(12)];
        _countTextField.font = Regular(15);
          
        [backV addSubview:_countTextField];
        [_countTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.height.equalTo(titleL);
            make.width.mas_equalTo(200); make.left.equalTo(titleL.mas_right).offset(5);
            
        }];
            
            
            if (i == 1) {
              
                cardNumF = _countTextField;
                UIButton *exitButton=[UIButton buttonWithType:UIButtonTypeCustom];
                [exitButton setImage:[UIImage imageNamed:@"组 4"] forState:UIControlStateNormal];
                
                [backV addSubview:exitButton];
                
                [exitButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.centerY.equalTo(titleL);
                    make.right.mas_equalTo(-LEFT_Margin);
                    make.width.height.mas_equalTo(15);
                }];
                [exitButton addtargetBlock:^(UIButton *button) {
                   
                    CoinBindingCardViewController *vc = [CoinBindingCardViewController new];
                    vc.type = _isFenqi?1:2;
                    [self.navigationController pushViewController:vc animated:YES];
                }];
                
            }
            
            if (i == 2) {
                
                phoneF = _countTextField;
            }
            
            if (i == 3) {
                codeF = _countTextField;
                // 验证码按钮
                _codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
               
                _codeButton.backgroundColor = ThemeColor;
                [_codeButton setTitleColor:COLOR(255, 141, 29) forState:UIControlStateNormal];
                [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                
                [_codeButton addTarget:self action:@selector(clickCodeButton) forControlEvents:UIControlEventTouchUpInside];
                _codeButton.titleLabel.font = Regular(10);
                _codeButton.layer.borderWidth = 1;
                _codeButton.layer.borderColor = COLOR(255, 141, 29).CGColor;
                _codeButton.layer.cornerRadius = 5;
                [backV addSubview:_codeButton];
                [_codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
                   
                    make.centerY.equalTo(titleL);
                    make.right.mas_equalTo(-LEFT_Margin);
                    make.width.mas_equalTo(60);
                    make.height.mas_equalTo(15);
                }];
                
                
                
            }
        
        }
        
        
        UIImageView *lineImage = [[UIImageView alloc] init];
        lineImage.backgroundColor = COLOR(238, 238, 238);
        
        [backV addSubview:lineImage];
        [lineImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(LEFT_Margin);
            make.right.mas_equalTo(-LEFT_Margin);
            make.top.mas_equalTo(26 + (i + 1)*(50));
            
            make.height.mas_equalTo(1);
        }];
        
        
        
        
        
    }
    
    
    
//    协议
    
    UIButton *exitButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [exitButton setImage:[UIImage imageNamed:@"形状 1"] forState:UIControlStateSelected];
    exitButton.tag = 3000;
    exitButton.layer.borderWidth = 1;
    exitButton.layer.borderColor =COLOR(255, 141, 29).CGColor;
    [exitButton setEnlargeEdge:10];
   exitButton.layer.cornerRadius = 2;
    [backV addSubview:exitButton];
    
    [exitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(divideView.mas_bottom).offset(215);
        make.left.mas_equalTo(LEFT_Margin);
        make.width.height.mas_equalTo(10);
    }];
    
    [exitButton addtargetBlock:^(UIButton *button) {
       
        button.selected = !button.selected;
    }];
    
    
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"我已阅读并同意开通银行卡代扣服务"];
    NSDictionary * firstAttributes = @{ NSForegroundColorAttributeName:COLOR(255, 141, 29)};
    [str setAttributes:firstAttributes range:NSMakeRange(9,str.length - 9)];
    
    UILabel *priceL = [[UILabel alloc] init];
    priceL.tag = 2000;
    priceL.textColor = TITLE_COLOR;
    priceL.font = Regular(10);
    priceL.attributedText = str;
    [backV addSubview:priceL];
    [priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(exitButton);
        make.left.equalTo(exitButton.mas_right).offset(5);
        make.height.mas_equalTo(10);
    }];
    
    
    UIButton *backBtn1 = [[UIButton alloc] init];
    backBtn1.titleLabel.font = Regular(18);
    [backBtn1 setTitle:@"下一步" forState:UIControlStateNormal];
    [backBtn1 setTitleColor:White forState:UIControlStateNormal];
    backBtn1.layer.cornerRadius = 5;
    backBtn1.backgroundColor = COLOR(255, 141, 29);
    [backV addSubview:backBtn1];
    [backBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(LEFT_Margin);
        make.top.equalTo(priceL.mas_bottom).offset(36);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(BCWidth - 30);
    }];
    
    [backBtn1 addTarget:self action:@selector(clickBindCard) forControlEvents:UIControlEventTouchUpInside];
    
   
    
}

#pragma mark 绑定银行卡信息
- (void)clickBindCard {
    if (cardNumF.text.length <= 0) {
        VCToast(@"卡号不能为空", 1);
        
        return;
    }
    
    if (phoneF.text.length <= 0) {
        VCToast(@"预留手机号不能为空", 1);
        
        return;
    }
   
    if (codeF.text.length <= 0) {
        VCToast(@"验证码不能为空", 1);
        
        return;
    }
    
    UIButton *seleBtn = [self.backScrollView viewWithTag:3000];
    if (!seleBtn.selected) {
        VCToast(@"请选中左下角的协议", 1);
        
        return;
    }
   
    
    NSInteger type;
    if (_isFenqi) {
        type = 1;
    } else {
        
        type = 2;
    }
    
    if (BCStringIsEmpty(llToken)) {
        llToken = @"";
    }
    [KTooL HttpPostWithUrl:@"MaterialVerify/card_verify_sms" parameters:@{@"type":@(type),@"ll_token":llToken,@"verify_code":codeF.text} loadString:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSLog(@"===%@",responseObject);
        
        
        if (BCStatus) {
            
            [self TestISSuccess];
            
        } else {
            
            VCToast(@"验证绑卡短信失败", 1);
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        VCToast(@"验证绑卡短信失败", 1);
    }];
}

#pragma mark 发送短信验证码
- (void)clickCodeButton {
    
   
    [self.view endEditing:YES];
    
    if (cardNumF.text.length <= 0) {
        VCToast(@"卡号不能为空", 1);
        
        return;
    }
    
    if (![Tool isBankard:cardNumF.text]) {
        VCToast(@"银行卡号不正确", 1);
        
        return;
        
    }
    if (phoneF.text.length <= 0) {
        VCToast(@"预留手机号不能为空", 1);
        
        return;
    }
    
    if (![Tool isMobileNumber:phoneF.text]) {
        VCToast(@"手机号码格式不正确", 1);
        
        return;
    }
    
    NSInteger type;
    if (_isFenqi) {
        type = 1;
    } else {
        
        type = 2;
    }
    
    [KTooL HttpPostWithUrl:@"MaterialVerify/card_send_sms" parameters:@{@"type":@(type),@"bank_card":cardNumF.text,@"bank_mobile":phoneF.text} loadString:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSLog(@"===%@",responseObject);
        
        
        if (BCStatus) {
            
            llToken = [[responseObject objectNilForKey:@"data"] objectNilForKey:@"ll_token"];
            VCToast([responseObject objectNilForKey:@"msg"], 1);
            [self changeTimeState];
            
        } else {
            
            VCToast([responseObject objectNilForKey:@"data"], 1);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
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
            
            
            
            [weakSelf.codeButton setTitle:@"重新发送" forState:UIControlStateNormal];
            
             weakSelf.codeButton.userInteractionEnabled = YES;
            //            防止倒计时结束前修改了号码
            //            [self textValueChanged:nil];
            
        }
        
    }];
    
    
//    [[NSRunLoop currentRunLoop]addTimer:_countDownTimer forMode:NSRunLoopCommonModes];
//    [_countDownTimer fire];
    
}


#pragma mark 验证信息是否通过
- (void)TestISSuccess {
    
    
    [KTooL HttpPostWithUrl:@"MaterialVerify/Credit" parameters:nil loadString:@"您的信用正在评估中,请稍后..." success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSLog(@"===%@",responseObject);
        
        dataDic = [responseObject objectNilForKey:@"data"];
        
        if (BCStatus) {
             isSuccess = YES;
            
            
        } else {
            
            isSuccess = NO;
        }
        
        [self initFourView];
        
        [self.backScrollView setContentOffset:CGPointMake(BCWidth * 3, 0) animated:YES];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
         isSuccess = NO;
    }];
    
}
- (void)initFourView {
    
   
    
    UIView *backV = [[UIView alloc] init];
    backV.backgroundColor  = White;
    [self.backScrollView addSubview:backV];
    [backV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(BCWidth * 3);
        make.height.mas_equalTo(180);
        make.width.mas_equalTo(BCWidth);
    }];
    
    
    UIImageView *leftI = [[UIImageView alloc]init];
   
    [backV addSubview:leftI];
    [leftI mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(70);
        make.top.mas_equalTo(34);
        
    }];
    
    
    UILabel *leftL = [[UILabel alloc] init];
   
    leftL.textColor = COLOR(18, 213, 41);
    leftL.font = Regular(15);
    [backV addSubview:leftL];
    [leftL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(leftI);
        make.left.equalTo(leftI.mas_right).offset(TOP_Margin);
        make.height.mas_equalTo(13);
        
    }];
    
    
    
    
    
    
//    按钮
    UIImageView *lineImage = [[UIImageView alloc] init];
    lineImage.backgroundColor = COLOR(242, 242, 242);
    
    [backV addSubview:lineImage];
    [lineImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(LEFT_Margin);
        make.top.mas_equalTo(133);
        make.width.mas_equalTo(BCWidth - 30);
        make.height.mas_equalTo(1);
    }];
    
   
    UIButton *cancelButton = [[UIButton alloc]init];
    [cancelButton setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    cancelButton.titleLabel.font = Regular(13);
    [cancelButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.tag = 0;
    [backV addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(BCWidth/2);
        make.top.mas_equalTo(lineImage.mas_bottom);
        make.height.mas_equalTo(45);
    }];
    
    
   UIButton *sureButton = [[UIButton alloc]init];
    [sureButton setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    sureButton.titleLabel.font = Regular(13);
    sureButton.tag = 1;
    [backV addSubview: sureButton];
    [sureButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(BCWidth/2);
        make.width.mas_equalTo(BCWidth/2);
        make.top.mas_equalTo(lineImage.mas_bottom);
        make.height.mas_equalTo(45);
        
    }];
    
    UIImageView *lineImage1 = [[UIImageView alloc] init];
    lineImage1.backgroundColor = COLOR(242, 242, 242);
    
    [backV addSubview:lineImage1];
    [lineImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(BCWidth/2);
         make.top.mas_equalTo(lineImage.mas_bottom);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(45);
    }];
    
    if (isSuccess) {
        leftI.image = BCImage(组 3);
        leftL.text = @"恭喜您信用认证通过，您获得";
        
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"帑库银票借款额度：¥%@",[dataDic objectNilForKey:@"cash_credit_limit"] ]];
        NSDictionary * firstAttributes = @{NSForegroundColorAttributeName:COLOR(255, 0, 0)};
        [str setAttributes:firstAttributes range:NSMakeRange(9,str.length - 9)];
        
        UILabel *priceL = [[UILabel alloc] init];
        
        priceL.textColor = COLOR(102, 102, 102);
        priceL.font = Regular(13);
        priceL.attributedText = str;
        [backV addSubview:priceL];
        [priceL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(backV);
            make.top.equalTo(leftI.mas_bottom).offset(15);
            make.height.mas_equalTo(13);
        }];
        
        
        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"分期购物额度：¥%@",[dataDic objectNilForKey:@"mall_credit_limit"] ]];
        NSDictionary * firstAttributes1 = @{NSForegroundColorAttributeName:COLOR(255, 0, 0)};
        [str1 setAttributes:firstAttributes1 range:NSMakeRange(7,str1.length - 7)];
        
        UILabel *leftL1 = [[UILabel alloc] init];
        
        leftL1.textColor = COLOR(102, 102, 102);
        leftL1.font = Regular(13);
        leftL1.attributedText = str1;
        [backV addSubview:leftL1];
        [leftL1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(priceL.mas_bottom).offset(10);
            make.centerX.equalTo(backV);
            make.height.mas_equalTo(13);
            
        }];
        
        [cancelButton setTitle:@"去借款" forState:UIControlStateNormal];
        [sureButton setTitle:@"去分期购物" forState:UIControlStateNormal];
    } else {
        
        leftI.image = BCImage(抱歉);
        leftL.text = @"抱歉，您的信用认证未通过审核！";
        leftL.textColor = COLOR(255, 50, 50);
        
        
        UILabel *priceL = [[UILabel alloc] init];
        priceL.numberOfLines = 0;
        priceL.textColor = COLOR(153, 153, 153);
        priceL.font = Regular(11);
        priceL.text = @"您可以尝试拨打客服热线400-618-8803，解决您的问题或回答疑问。";
        [backV addSubview:priceL];
        [priceL mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(leftI.mas_bottom).offset(15);
            make.centerX.equalTo(backV);
            make.width.mas_equalTo(250);
            make.height.mas_equalTo(35);
        }];
        
        
        [cancelButton setTitle:@"拨打客服电话" forState:UIControlStateNormal];
        [sureButton setTitle:@"去领取会员福利" forState:UIControlStateNormal];
    }
    
    
    
    
}
#pragma mark 信用认证
- (void)clickButton:(UIButton *)btn {
    
    if (isSuccess) {//通过的情况
        
        
        if (btn.tag == 0) {//借款
            
            self.tabBarController.selectedIndex = 2;
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else {//分期
            
            self.tabBarController.selectedIndex = 1;
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
        
    } else {
        
        if (btn.tag == 0) {//去领会员福利
            
            NSMutableString *str= [[NSMutableString alloc]initWithFormat:@"tel:%@",@"400-618-8803"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        } else {//分期
            
            self.tabBarController.selectedIndex = 1;
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
        
    }
    
}

#pragma mark 点击顶部按钮
- (void)clickTopButton:(UIButton *)btn {
    
    if (btn!= selectedBtn) {
        
        selectedBtn.selected = NO;
        btn.selected = YES;
        selectedBtn = btn;
        
    }else{
        
        selectedBtn.selected = YES;
    }
    
    
    
}
#pragma mark 懒加载加载需要的视图
- (UIView *)headView {
    if (!_headView) {
        
        
        
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , BCWidth, 40)];
        
        _headView.backgroundColor = COLOR(255, 141, 29);
        
        
        
        
        
        NSArray *titleArr1 = @[@"身份验证",@"人脸识别",@"绑卡认证",@"信用认证"];
        for(int i = 0; i < titleArr1.count; i++) {
            UIButton *segmentButton1 = [[UIButton alloc] init];
            
            segmentButton1.titleLabel.font = Regular(13);
            [segmentButton1 setTitle:titleArr1[i] forState:UIControlStateNormal];
            [segmentButton1 setTitleColor:COLOR(188, 188, 188) forState:UIControlStateNormal];
            [segmentButton1 setTitleColor:White forState:UIControlStateSelected];
            
           
            segmentButton1.tag = 200 + i;
            
            [_headView addSubview:segmentButton1];
            [segmentButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(((BCWidth - 55*4 - 30)/3 + 55) * i + LEFT_Margin);
                make.top.mas_equalTo(0);
                make.width.mas_equalTo(55);
                make.height.mas_equalTo(40);
            }];
            
            if (i == 0) {
               
                segmentButton1.selected = YES;
                selectedBtn = segmentButton1;
            }
            
        }
        
        
        
        
        
        
        
        //           滑竿
        
        
        
    }
    
    return _headView;
}


- (UIScrollView *)backScrollView {
    
    if (!_backScrollView) {
        
        
        _backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40  , BCWidth, BCHeight - 40 )];
        _backScrollView.delegate = self;
        _backScrollView.scrollEnabled = NO;
        _backScrollView.pagingEnabled = YES;
        _backScrollView.bounces = NO;
        _backScrollView.showsVerticalScrollIndicator = NO;
        _backScrollView.backgroundColor = DIVI_COLOR;
        _backScrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_backScrollView];
        _backScrollView.contentSize = CGSizeMake(BCWidth*4, BCHeight - 130 -BCNaviHeight);
        
        
    }
    
    return _backScrollView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    
    //     点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    
    UIButton *btn = [self.headView viewWithTag:200 + index];
    
    [self clickTopButton:btn];
    
}
@end
