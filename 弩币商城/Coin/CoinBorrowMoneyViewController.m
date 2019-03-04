//
//  CoinBorrowMoneyViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/4.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinBorrowMoneyViewController.h"
#import "BorrowMoneyReasonView.h"
#import "CoinMemberBuyViewController.h"
@interface CoinBorrowMoneyViewController ()

@end

@implementation CoinBorrowMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"帑库银票";
    [self SetNavTitleColor];
    [self SetReturnButton];
    [self initView];
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
}
- (void)goBuy:(UIButton *)btn{
    CoinMemberBuyViewController * vc = [CoinMemberBuyViewController new];
    [self.navigationController pushViewController:vc animated:YES];
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
            label.text = @[@"30",@"30",@"请选择",@"¥2870.00"][i];
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
            TF.font = Regular(15);
            [TF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(BGView).offset(10);
                make.top.bottom.equalTo(BGView);
                
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
        //获取状态栏的rect
        CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
        //获取导航栏的rect
        CGRect navRect = self.navigationController.navigationBar.frame;
        BorrowMoneyReasonView * view = [[BorrowMoneyReasonView alloc] initWithFrame:CGRectMake(0, BCHeight, BCWidth, BCHeight + statusRect.size.height + navRect.size.height)];
        [[UIApplication sharedApplication].keyWindow addSubview:view];
        [UIView animateWithDuration:0.25 animations:^{
            view.top = - (statusRect.size.height + navRect.size.height);
        }];
    }
    
}

@end
