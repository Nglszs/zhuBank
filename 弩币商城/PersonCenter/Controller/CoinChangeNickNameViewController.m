//
//  CoinChangeNickNameViewController.m
//  弩币商城
//
//  Created by Jack on 2019/3/1.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinChangeNickNameViewController.h"

@interface CoinChangeNickNameViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *messageCodeField;
@end

@implementation CoinChangeNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改昵称";
    
    [self initView];
}

- (void)initView {
    
 
    UILabel *leftL = [[UILabel alloc] init];
    leftL.text = @"昵 称：";
    leftL.textColor = COLOR(102, 102, 102);
    leftL.font = Regular(15);
    [self.view addSubview:leftL];
    [leftL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(28);
        make.left.mas_equalTo(60);
        make.height.mas_equalTo(25);
        
    }];
    
    
    
    //  输入框
    _messageCodeField = [[UITextField alloc] init];
    _messageCodeField.textColor = COLOR(102, 102, 102);
    _messageCodeField.font = Regular(15);
    _messageCodeField.delegate = self;
    _messageCodeField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    _messageCodeField.layer.cornerRadius = 4;
    _messageCodeField.layer.borderWidth = 1;
    _messageCodeField.layer.borderColor = COLOR(153, 153, 153).CGColor;
    [_messageCodeField changePlaceholderFont:Regular(15)];
    [_messageCodeField changePlaceholderColor:Gray_Color];
    
    [self.view addSubview:_messageCodeField];
    
    [_messageCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(leftL);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(165);
        make.left.mas_equalTo(leftL.mas_right).offset(5);
        
    }];
    
    
    
    UIButton *backBtn1 = [[UIButton alloc] init];
    backBtn1.titleLabel.font = Regular(17);
    [backBtn1 setTitle:@"确认修改" forState:UIControlStateNormal];
    [backBtn1 setTitleColor:White forState:UIControlStateNormal];
    backBtn1.layer.cornerRadius = 17;
    
    backBtn1.backgroundColor = COLOR(255, 0, 0);
    [self.view addSubview:backBtn1];
    [backBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_messageCodeField.mas_bottom).offset(40);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(185);
    }];
    
    [backBtn1 addtargetBlock:^(UIButton *button) {
        
        if ( _messageCodeField.text.length <= 0) {
            
            VCToast(@"昵称不能为空", 1);
            return ;
        }
       
        [KTooL HttpPostWithUrl:@"UserCenter/reset_nickname" parameters:@{@"nickname":_messageCodeField.text} loadString:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
              if (BCStatus) {
                
                VCToast(@"修改成功", 1);
                [self.view endEditing:YES];
                [NOTIFICATION_CENTER postNotificationName:Reresh_UserInfo object:nil];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
            } else {
                VCToast(BCMsg, 2);
                
            }
            
        } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
            
        }];
        
    }];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
