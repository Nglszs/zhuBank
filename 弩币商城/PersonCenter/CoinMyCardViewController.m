//
//  CoinMyCardViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/1.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinMyCardViewController.h"
#import "CoinMyCardView.h"
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
}



@end
