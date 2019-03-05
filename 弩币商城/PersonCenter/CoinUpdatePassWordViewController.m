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
        [self.navigationController pushViewController:[CoinPassWordSucceedViewController new] animated:YES];
    }];
}

//
- (void)loadView{
    self.RootView = [[CoinUpdatePassWordView alloc] initWithFrame:BCBound];
    self.view = self.RootView;
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
