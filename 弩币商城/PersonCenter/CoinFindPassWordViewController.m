//
//  CoinFindPassWordViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/1.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinFindPassWordViewController.h"
#import "CoinFindPassWordView.h"
@interface CoinFindPassWordViewController ()
@property (nonatomic,strong)CoinFindPassWordView * RootView;
@end

@implementation CoinFindPassWordViewController

- (void)loadView{
    self.RootView = [[CoinFindPassWordView alloc] initWithFrame:BCBound];
    self.view = self.RootView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    [self SetNavTitleColor];
}


@end
