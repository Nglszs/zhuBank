//
//  CoinCouponCanViewController.m
//  弩币商城
//
//  Created by Jack on 2019/3/1.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinCouponCanViewController.h"
#import "CoinCouponCanTableViewCell.h"

@interface CoinCouponCanViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CoinCouponCanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"本券可购买商品";
     [self initTableView];
}
// 初始化tableView
- (void)initTableView{
    UITableView * tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:(UITableViewStylePlain)];
    tabView.delegate = self;
    tabView.dataSource = self;
    tabView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tabView];
    [tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(0);
    }];
    
}

#pragma mark  tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CoinCouponCanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CoinSearchResultCell"];
    if (cell == nil) {
        cell = [[CoinCouponCanTableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"CoinSearchResultCell"];
    }
    cell.selectionStyle = 0;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

@end
