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
@interface CoinLoginViewController ()
@property (nonatomic,strong)CoinLoginView * RootView;
@end

@implementation CoinLoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.RootView.RegisterButton addTarget:self action:@selector(GoRegisterButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)loadView{
    self.RootView = [[CoinLoginView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.RootView;
}


- (void)GoRegisterButtonAction:(UIButton *)button{
    CoinRegisterViewController * vc = [CoinRegisterViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
