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
    self.address_id = [NSString stringWithFormat:@"%@",self.address_id];
    self.title = @"编辑/新建地址";
    [self SetNavTitleColor];
    [self.RootView.affirmButton addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.RootView.address_id = self.address_id;
    
}

- (void)loadView{
    self.RootView = [[CoinChangeAddressView alloc] initWithFrame:BCBound];
    self.view = self.RootView;
}


- (void)buttonAction:(UIButton *)btn{
   
    if (BCStringIsEmpty(self.address_id)) {
        WS(weakSelf);
        [self.RootView AddAddress:^(BOOL isSucceed) {
            if (isSucceed) {
                  [weakSelf.navigationController popViewControllerAnimated:YES];
            }
          
        }];
    }else{
         WS(weakSelf);
        self.RootView.address_id =  self.address_id;
        [self.RootView EditAddress:^(BOOL isSucceed) {
            if (isSucceed) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
}
@end
