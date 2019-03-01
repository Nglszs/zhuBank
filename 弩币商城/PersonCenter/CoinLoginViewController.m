//
//  CoinLoginViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/2/25.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinLoginViewController.h"
#import "CoinLoginView.h"
#import "CoinRegisterViewController.h"

#import "CoinFindPassWordViewController.h"
@interface CoinLoginViewController ()
@property (nonatomic,strong)CoinLoginView * RootView;
@end

@implementation CoinLoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.RootView.RegisterButton addTarget:self action:@selector(GoRegisterButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.RootView.ForgetPasswordButton addTarget:self action:@selector(ForgetPasswordButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    
}

- (void)loadView{
    self.RootView = [[CoinLoginView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.RootView;
}


- (void)GoRegisterButtonAction:(UIButton *)button{
    CoinRegisterViewController * vc = [CoinRegisterViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)ForgetPasswordButtonAction{
    CoinLoginViewController * vc = [CoinLoginViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
