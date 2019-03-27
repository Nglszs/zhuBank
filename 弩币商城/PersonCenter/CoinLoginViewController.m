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
#import "CoinPersonViewController.h"

#import "CoinFindPassWordViewController.h"
#import "BCNavigationViewController.h"
@interface CoinLoginViewController ()
@property (nonatomic,strong)CoinLoginView * RootView;
@end

@implementation CoinLoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.RootView.RegisterButton addTarget:self action:@selector(GoRegisterButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.RootView.ForgetPasswordButton addTarget:self action:@selector(ForgetPasswordButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.RootView.LoginButton addTarget:self action:@selector(LoginButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    
}

- (void)viewWillAppear:(BOOL)animated{
     [super viewWillAppear:animated];
    // 判断是不是一级控制器
    if (![self.navigationController.viewControllers[0] isKindOfClass:[CoinLoginViewController class]]) {
        self.title = @"登录";
        return;
    }
   
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)loadView{
    self.RootView = [[CoinLoginView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.RootView;
}


- (void)GoRegisterButtonAction:(UIButton *)button{
    CoinRegisterViewController * vc = [CoinRegisterViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)ForgetPasswordButtonAction{
    CoinFindPassWordViewController * vc = [CoinFindPassWordViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)LoginButtonAction{
    if (![self isMobileNumber:self.RootView.UserNameTF.text]) {
        VCToast(@"请输入正确的手机号", 2);
        return;
    }
    if (self.RootView.PasswordTF.text.length < 0 || self.RootView.PasswordTF.text.length > 16   ) {
        VCToast(@"请输入6-16位密码", 2);
        return;
    }
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"mobile"] = self.RootView.UserNameTF.text;
    dict[@"password"] = self.RootView.PasswordTF.text;
    dict[@"phone_type"] = [BCManagerTool getCurrentDeviceModel];
    dict[@"system_version"] =  [[UIDevice currentDevice] systemVersion];
    [KTooL HttpPostWithUrl:@"User/login" parameters:dict loadString:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (BCStatus) {
            
            [NOTIFICATION_CENTER postNotificationName:Login_Success object:nil];
            NSString *  token = responseObject[@"data"][@"token"];
            NSString *  user_id =  responseObject[@"data"][@"user_id"];
            [[NSUserDefaults standardUserDefaults] setObject:token forKey:USER_Token];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",user_id] forKey:USER_ID];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            if (![self.navigationController.viewControllers[0] isKindOfClass:[CoinLoginViewController class]]) {
                [self.navigationController popViewControllerAnimated:YES];
                return;
            }
            
            
             CoinPersonViewController *workVC =  [[CoinPersonViewController alloc] init];
            NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:[self.tabBarController viewControllers]];
            BCNavigationViewController *workNav = [[BCNavigationViewController alloc] initWithRootViewController:workVC];
            workNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[[UIImage imageNamed:@"我的 (1)"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"我的2 (1)"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [arr replaceObjectAtIndex:3 withObject:workNav];
            [self.tabBarController setViewControllers:arr];
        }else{
            VCToast(BCMsg, 2);
            
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}


@end
