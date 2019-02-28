//
//  CoinChangeAddressViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/2/28.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinChangeAddressViewController.h"
#import "CoinChangeAddressView.h"
@interface CoinChangeAddressViewController ()
@property (nonatomic,strong)CoinChangeAddressView * RootView;
@end

@implementation CoinChangeAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑/新建地址";
}

- (void)loadView{
    self.RootView = [[CoinChangeAddressView alloc] initWithFrame:BCBound];
    self.view = self.RootView;
}


@end
