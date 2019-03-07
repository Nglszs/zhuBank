//
//  CoinNotDevelopViewController.m
//  弩币商城
//
//  Created by Jack on 2019/3/7.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinNotDevelopViewController.h"

@interface CoinNotDevelopViewController ()

@end

@implementation CoinNotDevelopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"尽请期待";
    
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:BCImage(组 1 拷贝)];
   

    [self.view addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(100);
        make.centerX.equalTo(self.view);
       
        
    }];
    
    
    //        商品标题
    UILabel *titleL = [[UILabel alloc] init];
    titleL.text = @"程序员小哥哥正在努力开发中，敬请期待~";
    titleL.textColor = TITLE_COLOR;
 
    titleL.font = Regular(15);
    [self.view addSubview:titleL];
    
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(imageV.mas_bottom).offset(40);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(15);
        
    }];
    
    //
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
