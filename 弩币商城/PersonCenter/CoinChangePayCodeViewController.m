//
//  CoinChangePayCodeViewController.m
//  弩币商城
//
//  Created by Jack on 2019/2/28.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinChangePayCodeViewController.h"

@interface CoinChangePayCodeViewController ()<UITextFieldDelegate>
{
    
    UITextField *firstT,*secondT,*thirdT;
}
@end

@implementation CoinChangePayCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title= _isChangePay?@"修改交易密码":@"设置交易密码";
    [self  initView];
}

- (void)initView {
    
    
    
    NSArray *titleA;
    if (!_isChangePay) {
       
        titleA = @[@"请输入6位数字",@"请确认新密码"];
        
    } else{
        
        titleA = @[@"请输入原密码",@"请输入6位数字",@"请确认新密码"];
    }
    for ( int i = 0; i < titleA.count; i++) {
        
        
        UITextField *_countTextField = [[UITextField alloc] init];
        
        _countTextField.keyboardType = UIKeyboardTypeNumberPad;
        _countTextField.delegate = self;
        _countTextField.textColor = COLOR(102, 102, 102);
        _countTextField.placeholder = titleA[i];
        _countTextField.secureTextEntry = YES;
        _countTextField.font = Regular(15);
        
        
        UIImageView *leftI = [[UIImageView alloc]initWithFrame:CGRectMake(12, 1, 15, 19)];
         leftI.image = BCImage(密码 拷贝 2);
       
        if (titleA.count == 3) {
            
            if (i == 0) {
               leftI.image = BCImage(密码1);
                firstT = _countTextField;
            } else if ( i == 1) {
                
                secondT = _countTextField;
            } else {
                
                thirdT = _countTextField;
            }
            
        } else {
            
            if (i == 0) {
               
                firstT = _countTextField;
            } else if ( i == 1) {
                
                secondT = _countTextField;
            }
            
        }
        
        
        UIView *leftV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 47, 22)];
        [leftV addSubview:leftI];
        
        _countTextField.leftView = leftV;
        _countTextField.leftViewMode = UITextFieldViewModeAlways;
        
        [self.view addSubview:_countTextField];
        [_countTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(40);
            make.top.mas_equalTo(20 + i * 46);
            make.height.mas_equalTo(22);
            make.width.mas_equalTo(BCWidth - 80);
        }];
        
        
        //    分割线
        UIImageView *lineImage = [[UIImageView alloc] init];
        lineImage.backgroundColor = COLOR(242, 242, 242);
        
        [self.view addSubview:lineImage];
        [lineImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(40);
            make.top.equalTo(_countTextField.mas_bottom).offset(8);
            make.width.mas_equalTo(BCWidth - 80);
            make.height.mas_equalTo(1);
        }];
        
    }
    
    
    
    UIButton *backBtn1 = [[UIButton alloc] init];
    backBtn1.titleLabel.font = Regular(17);
    [backBtn1 setTitle:@"确认" forState:UIControlStateNormal];
    [backBtn1 setTitleColor:White forState:UIControlStateNormal];
    backBtn1.layer.cornerRadius = 20;
    
    backBtn1.backgroundColor = COLOR(227, 47, 33);
    [self.view addSubview:backBtn1];
    [backBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        if (!_isChangePay) {
            make.top.mas_equalTo(127);
        } else {
             make.top.mas_equalTo(180);
            
        }
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(250);
    }];
    
    [backBtn1 addtargetBlock:^(UIButton *button) {
        
        if (!_isChangePay) {//设置
            
            [KTooL HttpPostWithUrl:@"UserCenter/set_paypwd" parameters:@{@"paypwd":firstT.text,@"conform_paypwd":secondT.text} loadString:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                
                NSLog(@"===%@",responseObject);
                
                
                if (BCStatus) {
                    
                    VCToast(@"设置成功", 1);
                    [NOTIFICATION_CENTER postNotificationName:Reresh_UserInfo object:nil];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        int index = (int)[[self.navigationController viewControllers]indexOfObject:self];
                        if (index>2) {
                            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index-2)] animated:YES];
                        }else
                        {
                            [self.navigationController popToRootViewControllerAnimated:YES];
                        }
                        
                    });
                    
                } else {
                    
                    VCToast([responseObject objectNilForKey:@"msg"], 1);
                }
                
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                
            }];
            
        } else {
            
            
            
            [KTooL HttpPostWithUrl:@"UserCenter/reset_pwd" parameters:@{@"type":@"2",@"old_pwd":firstT.text,@"new_pwd":secondT.text,@"confirm_pwd":thirdT.text} loadString:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                
                NSLog(@"===%@",responseObject);
                
                
                if (BCStatus) {
                    
                    VCToast(@"修改成功", 1);
                   [NOTIFICATION_CENTER postNotificationName:Reresh_UserInfo object:nil];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        int index = (int)[[self.navigationController viewControllers]indexOfObject:self];
                        if (index>2) {
                            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index-2)] animated:YES];
                        }else
                        {
                            [self.navigationController popToRootViewControllerAnimated:YES];
                        }
                        
                    });
                    
                } else {
                    
                    VCToast([responseObject objectNilForKey:@"msg"], 1);
                }
                
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                
            }];
        }
        
        
    }];
}

#pragma mark textfield 代理
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    if (string.length <= 0) {
        return YES;
    }
    
    
    if (textField.text.length >= 6) {
        
        
        
        
        return NO;
        
        
        
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

@end
