//
//  CoinPassWordSucceedViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/4.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinPassWordSucceedViewController.h"
#import "CoinLoginViewController.h"
#import "BCNavigationViewController.h"
@interface CoinPassWordSucceedViewController ()

@end

@implementation CoinPassWordSucceedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"密码重置成功";
    [self SetNavTitleColor];
    [self SetReturnButton];
    [self initUI];
}

- (void)initUI{
    UIImageView * imageView = [[UIImageView alloc] initWithImage:BCImage(选择配送)];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.height.mas_equalTo(44);
        make.top.equalTo(self.view).offset(60);
    }];
    UILabel *label = [[UILabel alloc] init];
    
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"恭喜您，新密码设置成功！" attributes:@{NSFontAttributeName: Regular(15),NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
    
    label.attributedText = string;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageView);
        make.top.equalTo(imageView.mas_bottom).offset(20);
        
    }];
    UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:@"立即登录" forState:(UIControlStateNormal)];
    btn.layer.cornerRadius = 20;
    btn.clipsToBounds = YES;
    btn.backgroundColor = COLOR(255, 0, 0);
    [self.view addSubview:btn];
    [btn addtargetBlock:^(UIButton *button) {
        [USER_DEFAULTS removeObjectForKey:USER_ID];
        [USER_DEFAULTS removeObjectForKey:USER_Token];
        [USER_DEFAULTS synchronize];
        
        CoinLoginViewController *workVC =  [[CoinLoginViewController alloc] init];
        NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:[self.tabBarController viewControllers]];
        BCNavigationViewController *workNav = [[BCNavigationViewController alloc] initWithRootViewController:workVC];
        workNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[[UIImage imageNamed:@"我的 (1)"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"我的2 (1)"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [arr replaceObjectAtIndex:3 withObject:workNav];
        [self.tabBarController setViewControllers:arr];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(label);
        make.top.equalTo(label.mas_bottom).offset(40);
        make.left.equalTo(self.view).offset(SetX(74));
        make.right.equalTo(self.view).offset(-SetX(74));
        make.height.mas_equalTo(40);
    }];
}


@end
