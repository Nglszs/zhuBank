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
    [KTooL HttpPostWithUrl:@"UserCenter/add_bankcard" parameters:nil loadString:@"正在加载" success:^(NSURLSessionDataTask *task, id responseObject) {
        
//        status 1：需要去购买会员；2：需要先身份认证；3：去绑卡
        int status = [responseObject[@"status"] intValue];
        if (status == 1) {
            CoinMemberBuyViewController * vc = [CoinMemberBuyViewController new];
            vc.type = BRPayBuyMember;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (status == 2) {
            CoinCertifyViewController * vc = [CoinCertifyViewController new];
            vc.indexType = 1;
            if (isRepayment == NO) {
                vc.isFenqi = YES;
            }
            [self.navigationController pushViewController:vc animated:YES];
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
