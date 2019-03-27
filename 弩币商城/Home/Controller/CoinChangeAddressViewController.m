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
    
    if (!BCStringIsEmpty(self.address_id)) {
        [self setNavitemImage:@"删除" type:(RightNavItem)];
    }
    
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

- (void)RightItemAction{
    [KTooL HttpPostWithUrl:@"Order/delete_address" parameters:@{@"address_id": self.address_id} loadString:@"正在删除" success:^(NSURLSessionDataTask *task, id responseObject) {
        if (BCStatus) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            VCToast(BCMsg, 2);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

@end
