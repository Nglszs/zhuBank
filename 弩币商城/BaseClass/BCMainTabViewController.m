//
//  BCMainTabViewController.m
//  弩币商城
//
//  Created by Jack on 2019/2/25.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "BCMainTabViewController.h"
#import "CoinHomeViewController.h"
#import "CoinMoneyViewController.h"
#import "CoinClassfyViewController.h"
#import "CoinPersonViewController.h"
#import "BCNavigationViewController.h"


#import "CoinLoginViewController.h"

@interface BCMainTabViewController ()

@end

@implementation BCMainTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [[UITabBar appearance] setBarTintColor:ThemeColor];

    self.tabBar.translucent = NO;
    
    CoinHomeViewController *propertyVC = [[CoinHomeViewController alloc] init];
    BCNavigationViewController *propertyNav = [[BCNavigationViewController alloc] initWithRootViewController:propertyVC];
   
    propertyNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[[UIImage imageNamed:@"首页未选中状态"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"首页选中状态"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    
    
    
    
    CoinClassfyViewController *rentVC = [[CoinClassfyViewController alloc] init];
    BCNavigationViewController *rentNav = [[BCNavigationViewController alloc] initWithRootViewController:rentVC];
    rentNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"分类" image:[[UIImage imageNamed:@"icon_rent_normal@0.5x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"icon_rent_focus@0.5x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    
    
    
    CoinMoneyViewController *bussVC = [[CoinMoneyViewController alloc] init];
    BCNavigationViewController *bussNav = [[BCNavigationViewController alloc] initWithRootViewController:bussVC];
    bussNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"努库银票" image:[[UIImage imageNamed:@"icon_merchants_normal@0.5x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"icon_merchants_focus@0.5x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    
    CoinPersonViewController *workVC =  [[CoinPersonViewController alloc] init];
 
    
    BCNavigationViewController *workNav = [[BCNavigationViewController alloc] initWithRootViewController:workVC];
    workNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[[UIImage imageNamed:@"icon_workbench_normal@0.5x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"icon_workbench_focus@0.5x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    
    self.viewControllers = @[propertyNav,rentNav,bussNav,workNav];
    
    
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:TabTitleNormalColor,NSFontAttributeName:Text11Font} forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, 1)];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:TabTitleSeletedolor,NSFontAttributeName:Text11Font} forState:UIControlStateSelected];
    
    
    
}


@end
