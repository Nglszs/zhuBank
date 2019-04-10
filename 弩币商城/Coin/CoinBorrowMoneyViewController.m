//
//  CoinBorrowMoneyViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/4.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinBorrowMoneyViewController.h"
#import "BorrowMoneyReasonView.h"
#import "CoinBrowseStatusViewController.h"

@interface CoinBorrowMoneyViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)NSArray * dayArray;
@property (nonatomic,strong)NSArray * reasonAyyay;
@property (nonatomic,strong)UITextField * moneyTF;
@property (nonatomic,strong)UILabel * dayLabel;
@property (nonatomic,strong)UILabel * reasonLabel;
@property (nonatomic,strong)UILabel * MoneyLabel;
@end

@implementation CoinBorrowMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"糖库借呗";
    [self SetNavTitleColor];
    [self SetReturnButton];
    [self initView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)initView{
    self.view.backgroundColor = [UIColor whiteColor];
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = COLOR(221, 221, 221);
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(0.5);
    }];
    [self SetLists];
    
    UIButton * footButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [footButton setTitle:@"立即借款" forState:(UIControlStateNormal)];
    [self.view addSubview:footButton];
    footButton.backgroundColor = COLOR(255, 0, 0);
    [footButton mas_makeConstraints:^(MASConstraintMaker *make) {make.left.equalTo(self.view).offset(32);
        make.right.equalTo(self.view).offset(-32);
        make.top.equalTo(self.view).offset((50 * 4 + 30));
        make.height.mas_equalTo(40);
        
    }];
    [footButton addTarget:self action:@selector(goBuy:) forControlEvents:(UIControlEventTouchUpInside)];
    [self request];
}
- (void)goBuy:(UIButton *)btn{
        if ([self.moneyTF.text intValue] == 0) {
            VCToast(@"借款金额不能为0", 2);
            return;
        }
//    if ([self.moneyTF.text intValue] < 500) {
//        VCToast(@"借款金额不能小于500", 2);
//        return;
//    }
    if ([self.dayLabel.text isEqualToString:@"请选择"]) {
        VCToast(@"请选择借款天数", 2);
        return;
    }
    if ([self.reasonLabel.text isEqualToString:@"请选择"]) {
        VCToast(@"请选择借款用途", 2);
        return;
    }
    UIAlertController * aler = [UIAlertController alertControllerWithTitle:@"交易密码" message:@"请输入交易密码" preferredStyle:(UIAlertControllerStyleAlert)];
 __block   UITextField * TF;
    [aler addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入交易密码";
        textField.secureTextEntry = YES;
        TF = textField;
    }];
    UIAlertAction * a1 = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        dict[@"amount"] = self.moneyTF.text;
        dict[@"days"] = self.dayLabel.text;
        dict[@"use"] = self.reasonLabel.text;
        dict[@"repay_amount"] = [self.MoneyLabel.text substringFromIndex:1];
        dict[@"password"] = TF.text;
        [KTooL HttpPostWithUrl:@"CashLoan/confirm_loan" parameters:dict loadString:@"正在提交" success:^(NSURLSessionDataTask *task, id responseObject) {
            
            int status = [responseObject[@"status"] intValue];
            if (status == 1) {
                CoinBrowseStatusViewController * VC = [CoinBrowseStatusViewController new];
                VC.isBrowse = YES;
                [self.navigationController pushViewController:VC animated:YES];
            }else{
                VCToast(BCMsg, 2);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
    }];
    UIAlertAction * a2 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [aler addAction:a1];
    [aler addAction:a2];
    [self presentViewController:aler animated:YES completion:^{
        
    }];
    
  
//    [self.navigationController pushViewController:[CoinBrowseStatusViewController new] animated:YES];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
  
    NSString * str = [NSString stringWithFormat:@"%@%@",textField.text,string];
    //匹配以0开头的数字
    NSPredicate * predicate0 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[0][0-9]+$"];
    //匹配两位小数、整数
    NSPredicate * predicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^(([1-9]{1}[0-9]*|[0]))$"];
    return ![predicate0 evaluateWithObject:str] && [predicate1 evaluateWithObject:str] ? YES : NO;
}
- (void)textFieldTextDidChange{
    if (self.moneyTF.text.length > 8) {
        self.moneyTF.text = [self.moneyTF.text substringToIndex:8];
    }
     [self requestMoney];
    
}

- (void)requestMoney{
    if (!BCStringIsEmpty(self.moneyTF.text) || ![self.dayLabel.text isEqualToString:@"请选择"]) {
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        dict[@"days"] = self.dayLabel.text;
        dict[@"amount"] = self.moneyTF.text;
        [KTooL HttpPostWithUrl:@"CashLoan/calculat_money" parameters:dict loadString:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            if (BCStatus) {
                self.MoneyLabel.text = [NSString stringWithFormat:@"￥%@",responseObject[@"data"][@"repay_total"]];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }
    
}

- (void)SetLists{
    NSArray * array = @[@"借款金额(元)：",@"借款期限(天)：",@"借款用途：",@"到期应还："];
    CGFloat height = 50;
    
    for (int i = 0; i < array.count; i++) {
        UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        btn.adjustsImageWhenHighlighted = NO;
        [self.view addSubview:btn];
        
        btn.tag = 1000 + i;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(LEFT_Margin);
            make.right.equalTo(self.view).offset(-LEFT_Margin);
            make.top.equalTo(self.view).offset(i * height);
            make.height.mas_equalTo(height);
            
        }];
        
        UIView * lineView = [[UIView alloc] init];
        lineView.backgroundColor = COLOR(235, 235, 235);
        [self.view addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(btn);
            make.height.mas_equalTo(0.5);
        }];
        
        UILabel * label = [[UILabel alloc] init];
        label.font = Regular(15);
        label.text = array[i];
        label.textColor = COLOR(51, 51, 51);
        [btn addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.top.equalTo(btn);
        }];
        
        UIImageView * rightImage = [[UIImageView alloc] init];
        rightImage.image = [UIImage imageNamed:@"查看更多"];
        [btn addSubview:rightImage];
        [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.centerY.equalTo(btn);
            make.width.mas_equalTo(8);
            make.height.mas_equalTo(13);
        }];
        
        CGFloat right = 13;
        if (i == 0 || i == 3) {
            rightImage.hidden = YES;
            right = 0;
        }
        
        if (i != 0) {
            UILabel * label = [UILabel new];
            label.text = @[@"30",@"请选择",@"请选择",@""][i];
            if (i == 1) {
                self.dayLabel = label;
            }
            if (i == 2) {
                self.reasonLabel = label;
            }
            if (i== 3) {
                self.MoneyLabel = label;
            }
            label.font = Regular(15);
            label.textColor = COLOR(102, 102, 102);
            [btn addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(btn).offset(-right);
                make.centerY.equalTo(btn);
            }];
        }else{
            
            UIView * BGView = [[UIView alloc] init];
            BGView.layer.borderColor = COLOR(221, 221, 221).CGColor;
            BGView.layer.borderWidth = 0.5;
            [btn addSubview:BGView];
            [BGView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(label.mas_right).offset(5);
                make.right.equalTo(btn);
                make.height.mas_equalTo(25);
                make.centerY.equalTo(btn);
            }];
            
            UITextField * TF = [[UITextField alloc] init];
            TF.keyboardType = UIKeyboardTypeNumberPad;
            [btn addSubview:TF];
            self.moneyTF = TF;
            self.moneyTF.delegate = self;
            TF.font = Regular(15);
            [TF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(BGView).offset(10);
                make.top.bottom.equalTo(BGView);
                make.width.mas_equalTo(120);
               }];
            [BGView addTapGestureWithBlock:^{
                [TF becomeFirstResponder];
            }];
        }
        
        
    }
    
    
}
- (void)btnAction:(UIButton *)btn{
    NSInteger tag = btn.tag - 1000;
    // 借款用途
    if (tag == 2) {
        [self.view endEditing:YES];
        //获取状态栏的rect
        CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
        //获取导航栏的rect
        CGRect navRect = self.navigationController.navigationBar.frame;
        BorrowMoneyReasonView * view = [[BorrowMoneyReasonView alloc] initWithFrame:CGRectMake(0, BCHeight, BCWidth, BCHeight + statusRect.size.height + navRect.size.height) withData:self.reasonAyyay];
        MJWeakSelf;
        view.use = ^(NSString * _Nonnull use) {
            weakSelf.reasonLabel.text = use;
            [weakSelf requestMoney];
        };
        [[UIApplication sharedApplication].keyWindow addSubview:view];
        [UIView animateWithDuration:0.25 animations:^{
            view.top = - (statusRect.size.height + navRect.size.height);
        }];
    }
    
    if (tag == 1) {
        [self.view endEditing:YES];
        if (self.dayArray) {
            UIAlertController * aler = [UIAlertController alertControllerWithTitle:@"借款天数" message:@"请选择借款天数" preferredStyle:(UIAlertControllerStyleAlert)];
            for (int i = 0; i < self.dayArray.count; i++) {
                NSString * str = [NSString stringWithFormat:@"%@",self.dayArray[i][@"days"]];
                UIAlertAction * a = [UIAlertAction actionWithTitle:str style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    self.dayLabel.text = action.title;
                    [self requestMoney];
                }];
                [aler addAction:a];
            }
            [self presentViewController:aler animated:YES completion:^{
                
            }];
        }
       
    }
}

- (void)request{
    [KTooL HttpPostWithUrl:@"CashLoan/loan_page" parameters:nil loadString:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (BCStatus) {
            self.dayArray = responseObject[@"data"][@"days"];
            self.reasonAyyay = responseObject[@"data"][@"use"];
            NSString * money  = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"money"]];
            if (BCStringIsEmpty(money)) {
                money = @"";
            }
            if ([money containsString:@"."]) {
                money = [NSString stringWithFormat:@"%d",[money intValue]];
            }
            self.moneyTF.text = money;
        }else{
            VCToast(BCMsg, 2);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
