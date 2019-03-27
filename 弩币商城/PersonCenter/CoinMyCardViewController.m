//
//  CoinMyCardViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/1.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinMyCardViewController.h"
#import "CoinMyCardView.h"
#import "CoinMemberBuyViewController.h"
#import "CoinCertifyViewController.h"
@interface CoinMyCardViewController ()
@property (nonatomic,strong)CoinMyCardView * RootView;
@end

@implementation CoinMyCardViewController

- (void)loadView{
    self.RootView = [[CoinMyCardView alloc] initWithFrame:BCBound];
    self.view = self.RootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的银行卡";
    [self SetReturnButton];
    MJWeakSelf;
    [self.RootView.PayView addTapGestureWithBlock:^{
        // 添加分期购物银行卡
        [weakSelf add_bankcard:NO];
    }];
    
    [self.RootView.RepaymentView addTapGestureWithBlock:^{
        // 添加
        [weakSelf add_bankcard:YES];
    }];
}

- (void)add_bankcard:(BOOL)isRepayment{
    [KTooL HttpPostWithUrl:@"UserCenter/add_bankcard" parameters:nil loadString:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        
//        status 1：需要去购买会员；2：需要先身份认证；3：去绑卡
        int status = [responseObject[@"status"] intValue];
        if (status == 1) {
            UIAlertController * aler = [UIAlertController alertControllerWithTitle:@"您需要先购买会员" message:@"绑卡前需要购买努库金钻会员" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction * a1 = [UIAlertAction actionWithTitle:@"去购买" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                CoinMemberBuyViewController * vc = [CoinMemberBuyViewController new];
                vc.type = BRPayBuyMember;
                [self.navigationController pushViewController:vc animated:YES];
            }];
            UIAlertAction * a2 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
             
            }];
             [aler addAction:a2];
            [aler addAction:a1];
           
            [self presentViewController:aler animated:YES completion:nil];
           
        }
        
        if (status == 2) {
            UIAlertController * aler = [UIAlertController alertControllerWithTitle:@"您需要先进行身份验证" message:@"绑卡前需要进行身份验证" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction * a1 = [UIAlertAction actionWithTitle:@"去验证" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                CoinCertifyViewController * vc = [CoinCertifyViewController new];
                vc.indexType = 1;
                if (isRepayment == NO) {
                    vc.isFenqi = YES;
                }
                [self.navigationController pushViewController:vc animated:YES];
            }];
            UIAlertAction * a2 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
             [aler addAction:a2];
            [aler addAction:a1];
           
            [self presentViewController:aler animated:YES completion:nil];
        }
        
        if (status == 3) {
            CoinCertifyViewController * vc = [CoinCertifyViewController new];
            vc.indexType = 2;
            if (isRepayment == NO) {
                vc.isFenqi = YES;
            }
            [self.navigationController pushViewController:vc animated:YES];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}


@end
