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

- (void)loadView{
    self.RootView = [[CoinUpdatePassWordView alloc] initWithFrame:BCBound];
    self.view = self.RootView;
}

- (void)Request{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"mobile"] = self.mobile;
    dict[@"password"] = self.RootView.password1.text;
    dict[@"confirm_pwd"] = self.RootView.password2.text;
    if (self.RootView.password1.text.length == 0 || self.RootView.password2.text.length == 0) {
        VCToast(@"请输入密码", 2);
        return;
    }
    if (![self.RootView.password1.text isEqualToString:self.RootView.password2.text]) {
        VCToast(@"两次密码不一致", 2);
        return;
    }
    [KTooL HttpPostWithUrl:@"User/set_login_pwd" parameters:dict loadString:@"正在修改" success:^(NSURLSessionDataTask *task, id responseObject) {
        if (BCStatus) {
            [self.navigationController pushViewController:[CoinPassWordSucceedViewController new] animated:YES];
        }else{
            VCToast(BCMsg, 2);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        VCToast(@"设置失败", 2);
    }];
    
}

@end
