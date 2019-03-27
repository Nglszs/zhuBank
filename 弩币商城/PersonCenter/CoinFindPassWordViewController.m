//
//  CoinFindPassWordViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/1.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinFindPassWordViewController.h"
#import "CoinFindPassWordView.h"
#import "CoinUpdatePassWordViewController.h"
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
    [self SetReturnButton];
    [self.RootView.btn addTarget:self action:@selector(GoSetPassword) forControlEvents:(UIControlEventTouchUpInside)];
}
- (void)GoSetPassword{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    if (self.RootView.messageCodeField.text.length == 0) {
        VCToast(@"请输入验证码", 2);
        return;
    }
    dict[@"mobile"] = self.RootView.PhoneTF.text;
    dict[@"action"] =  @"2";
    dict[@"verify_code"] = self.RootView.messageCodeField.text;
    [KTooL HttpPostWithUrl:@"User/check_sms" parameters:dict loadString:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (BCStatus) {
            CoinUpdatePassWordViewController * vc = [CoinUpdatePassWordViewController new];
            vc.mobile = self.RootView.PhoneTF.text;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
   
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


@end
