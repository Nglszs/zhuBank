//
//  CoinChangeSuccessViewController.m
//  弩币商城
//
//  Created by Jack on 2019/2/28.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinChangeSuccessViewController.h"
#import "CoinLoginViewController.h"
#import "BCNavigationViewController.h"
#import "CoinSetViewController.h"

@interface CoinChangeSuccessViewController ()

@end

@implementation CoinChangeSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    if (self.isChangePhone) {//修改手机号码成功
        
        
        [self initPhoneView];
        
        
    } else {//修改密码成功
       
        [self initCodeView];
        
    }
    
  
}

- (void)initPhoneView {
  
    UIImageView *leftI = [[UIImageView alloc]init];
    leftI.image = BCImage(组 2);
    [self.view addSubview:leftI];
    [leftI mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(32);
        
    }];
    
    
    UILabel *leftL = [[UILabel alloc] init];
    leftL.text = @"操作成功，等待时间：3s";
    leftL.textColor = COLOR(153, 153, 153);
    leftL.font = Regular(12);
    [self.view addSubview:leftL];
    [leftL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(leftI.mas_bottom).offset(LEFT_Margin);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(12);
        
    }];
  
    
    __block int time = 3;
    [NSTimer wwl_scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer *timer) {
        
        time--;
        leftL.text = [NSString stringWithFormat:@"操作成功，等待时间：%ds",time];
        if (time == 0) {
            [timer invalidate];
            
        }
        
    }];
    
    
//    两个按钮
    NSArray *titleA = @[@"返回上一页",@"返回首页"];
    for (int i = 0; i < 2; i ++) {
       
        
        UIButton *backBtn1 = [[UIButton alloc] init];
        backBtn1.titleLabel.font = Regular(17);
        [backBtn1 setTitle:titleA[i] forState:UIControlStateNormal];
        [backBtn1 setTitleColor:White forState:UIControlStateNormal];
        backBtn1.layer.cornerRadius = 8;
        backBtn1.tag = 100 + i;
        [backBtn1 addTarget:self action:@selector(clickPhone:) forControlEvents:UIControlEventTouchUpInside];
        backBtn1.backgroundColor = COLOR(227, 47, 33);
        [self.view addSubview:backBtn1];
        [backBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(leftL.mas_bottom).offset(40);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(120);
            make.left.mas_equalTo(40 + i*((BCWidth - 240)/2 + 120));
        }];
        
        
        
    }
    
}

#pragma mark 点击修改手机号成功按钮
- (void)clickPhone:(UIButton *)btn {
    
    
    if (btn.tag == 100) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } else {
        
        int index = (int)[[self.navigationController viewControllers]indexOfObject:self];
        
        
        CoinSetViewController *homeVC = [[CoinSetViewController alloc] init];
        UIViewController *target = nil;
        for (UIViewController * controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[homeVC class]]) {
                target = controller;
            }
        }
        if (target) {
            [self.navigationController popToViewController:target animated:YES];
        }
       
        
    }
}


#pragma mark 修改密码成功页面
- (void)initCodeView {
    
    UIImageView *leftI = [[UIImageView alloc]init];
    leftI.image = BCImage(组 2-1);
    [self.view addSubview:leftI];
    [leftI mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(32);
        
    }];
    
    
    UILabel *leftL = [[UILabel alloc] init];
    leftL.text = @"恭喜您，新密码设置成功！";
    leftL.textColor = COLOR(153, 153, 153);
    leftL.font = Regular(12);
    [self.view addSubview:leftL];
    [leftL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(leftI.mas_bottom).offset(LEFT_Margin);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(12);
        
    }];
    
    
    
    //    下一步
    UIButton *backBtn1 = [[UIButton alloc] init];
    backBtn1.titleLabel.font = Regular(17);
    [backBtn1 setTitle:@"立即登录" forState:UIControlStateNormal];
    [backBtn1 setTitleColor:White forState:UIControlStateNormal];
    backBtn1.layer.cornerRadius = 20;
    
    backBtn1.backgroundColor = COLOR(227, 47, 33);
    [self.view addSubview:backBtn1];
    [backBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(leftL.mas_bottom).offset(40);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(250);
    }];
    
    [backBtn1 addtargetBlock:^(UIButton *button) {
        
        [USER_DEFAULTS removeObjectForKey:USER_ID];
        [USER_DEFAULTS removeObjectForKey:USER_Token];
        [USER_DEFAULTS synchronize];
        
        CoinLoginViewController *workVC =  [[CoinLoginViewController alloc] init];
        NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:[self.tabBarController viewControllers]];
        BCNavigationViewController *workNav = [[BCNavigationViewController alloc] initWithRootViewController:workVC];
        workNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[[UIImage imageNamed:@"我的 (1)"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"我的2 (1)"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        int count = 2;
        if ([Tool AuditState]) {
            count = 3;
        }
        [arr replaceObjectAtIndex:count withObject:workNav];
        [self.tabBarController setViewControllers:arr];
         [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    
}
@end
