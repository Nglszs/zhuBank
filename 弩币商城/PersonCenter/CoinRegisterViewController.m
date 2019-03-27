//
//  CoinRegisterViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/2/26.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinRegisterViewController.h"
#import "CoinRegisterView.h"
#import "CoinSearchViewController.h"
#import "BCNavigationViewController.h"
#import "CoinPersonViewController.h"
#import "CoinH5ViewController.h"
#import "CoinLoginViewController.h"
@interface CoinRegisterViewController ()
@property (nonatomic,strong)CoinRegisterView * RootView;
@property (nonatomic,copy)NSString * register_agreement;
@property (nonatomic,copy)NSString * secret_agreement;
@end

@implementation CoinRegisterViewController


-(void)loadView{
    self.RootView = [[CoinRegisterView alloc] initWithFrame:BCBound];
    self.view = self.RootView;
    [self requestProtocol];
    self.title = @"注册";
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.RootView.RegisterButton addtargetBlock:^(UIButton *button) {
        [self request];
     
    }];
    WS(weakSelf);
    [self.RootView.userProtocol addTapGestureWithBlock:^{
        //用户注册协议
        if (!BCStringIsEmpty(self.register_agreement)) {
            CoinH5ViewController * vc = [CoinH5ViewController new];
            vc.url = weakSelf.register_agreement;
            vc.titleStr = @"用户注册协议";
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        
    }];
    
    [self.RootView.privacyProtocol addTapGestureWithBlock:^{
        // 隐私保护协议
        if (!BCStringIsEmpty(self.secret_agreement)) {
            CoinH5ViewController * vc = [CoinH5ViewController new];
            vc.url = weakSelf.secret_agreement;
            vc.titleStr = @"隐私保护政策";
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    }];
    
  
}


- (void)requestProtocol{
    [KTooL HttpPostWithUrl:@"User/agreement" parameters:nil loadString:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (BCStatus) {
            self.register_agreement = responseObject[@"data"][@"register_agreement"];
            self.secret_agreement = responseObject[@"data"][@"secret_agreement"];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
- (void)request{
    if (![self isMobileNumber:self.RootView.PhoneNumberTF.text]) {
        VCToast(@"请输入正确的手机号", 2);
        return;
    }
    if (self.RootView.PassWordTF1.text.length <= 6 || self.RootView.PassWordTF1.text.length > 12) {
        VCToast(@"请输入6-12位登录密码", 2);
        return;
    }
    if (![self.RootView.PassWordTF1.text isEqualToString:self.RootView.PassWordTF2.text]) {
        VCToast(@"两次密码不一致", 2);
        return;
    }
    if (self.RootView.CodeTF.text.length == 0) {
        VCToast(@"请输入验证码", 2);
        return;
    }
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"verify_code"] = self.RootView.CodeTF.text;
    dict[@"password"] = self.RootView.PassWordTF1.text;
    dict[@"confirm_pwd"] = self.RootView.PassWordTF2.text;
    dict[@"phone_type"] = [BCManagerTool getCurrentDeviceModel];
     dict[@"system_version"] =  [[UIDevice currentDevice] systemVersion];
    dict[@"mobile"] = self.RootView.PhoneNumberTF.text;
    [KTooL HttpPostWithUrl:@"User/register" parameters:dict loadString:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (BCStatus) {
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
            
        } else {
            VCToast([responseObject objectForKey:@"msg"], 1);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
         VCToast(@"注册失败", 1);
    }];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

@end
