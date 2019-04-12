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
    if (self.address_id) {
       self.address_id = [NSString stringWithFormat:@"%@",self.address_id];
        self.RootView.address_id = self.address_id;
    }
    
    self.title = @"编辑/新建地址";
   
    [self.RootView.affirmButton addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
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
    
    [self showSystemAlertTitle:@"确定删除此地址吗？" message:nil cancelTitle:@"取消" confirmTitle:@"确定" cancel:nil confirm:^{
        
        [KTooL HttpPostWithUrl:@"Order/delete_address" parameters:@{@"address_id": self.address_id} loadString:@"正在删除" success:^(NSURLSessionDataTask *task, id responseObject) {
            if (BCStatus) {
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"UserAddressSuccess" object:nil];
                VCToast(@"删除成功", 1);
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                      [self.navigationController popViewControllerAnimated:YES];
                });
              
            }else{
                VCToast(BCMsg, 2);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
    }];
   
}

@end
