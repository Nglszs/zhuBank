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
@interface CoinRegisterViewController ()
@property (nonatomic,strong)CoinRegisterView * RootView;
@end

@implementation CoinRegisterViewController


-(void)loadView{
    self.RootView = [[CoinRegisterView alloc] initWithFrame:BCBound];
    self.view = self.RootView;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
 
    [self.RootView.RegisterButton addtargetBlock:^(UIButton *button) {
        CoinSearchViewController * vc = [CoinSearchViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
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
