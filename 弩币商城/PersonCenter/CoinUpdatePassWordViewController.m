//
//  CoinUpdatePassWordViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/4.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinUpdatePassWordViewController.h"
#import "CoinUpdatePassWordView.h"
#import "CoinPassWordSucceedViewController.h"
@interface CoinUpdatePassWordViewController ()
@property (nonatomic,strong)CoinUpdatePassWordView * RootView;
@end

@implementation CoinUpdatePassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更新密码";
    [self SetNavTitleColor];
    [self SetReturnButton];
    [self.RootView.UpDateButton addtargetBlock:^(UIButton *button) {
        [self Request];
        
    }];
}

//
- (void)loadView{
    self.RootView = [[CoinUpdatePassWordView alloc] initWithFrame:BCBound];
    self.view = self.RootView;
}

- (void)Request{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"mobile"] = self.mobile;
    dict[@"password"] = self.RootView.password1.text;
    dict[@"confirm_pwd"] = self.RootView.password2.text;
    [KTooL HttpPostWithUrl:@"User/set_login_pwd" parameters:dict loadString:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (BCStatus) {
            [self.navigationController pushViewController:[CoinPassWordSucceedViewController new] animated:YES];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

@end
