//
//  BCNavigationViewController.m
//  映币
//
//  Created by Jack on 2018/12/11.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "BCNavigationViewController.h"

@interface BCNavigationViewController ()

@end

@implementation BCNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    修改导航栏样式
    self.navigationBar.barTintColor = ThemeColor;
    self.navigationBar.translucent = NO;
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:19],NSForegroundColorAttributeName:TITLE_COLOR}];
    
//    self.interactivePopGestureRecognizer.delegate = self;
    
   
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count >= 1)
    {
        viewController.hidesBottomBarWhenPushed = YES;
        
       
       
    }
    [super pushViewController:viewController animated:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
