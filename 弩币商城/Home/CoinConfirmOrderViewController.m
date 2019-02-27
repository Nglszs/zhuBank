//
//  CoinConfirmOrderViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/2/27.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinConfirmOrderViewController.h"
#import "CoinConfirmOrderAddressCell.h"
#import "CoinConfirmCommodityOrderCell.h"
#import "CoinConfirmCommodityDistributionCell.h"
@interface CoinConfirmOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * tableView;

@end

@implementation CoinConfirmOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    [self initView];
}
- (void)initView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    [self.tableView registerClass:[CoinConfirmOrderAddressCell class] forCellReuseIdentifier:@"CoinConfirmOrderAddressCell"];
    [self.tableView registerClass:[CoinConfirmCommodityOrderCell class] forCellReuseIdentifier:@"CoinConfirmCommodityOrderCell"];
    [self.tableView registerClass:[CoinConfirmCommodityDistributionCell class] forCellReuseIdentifier:@"CoinConfirmCommodityDistributionCell"];
    self.navigationController.navigationBar.titleTextAttributes=
  @{NSForegroundColorAttributeName:COLOR(51, 51, 51),
    NSFontAttributeName:[UIFont systemFontOfSize:18]};
    self.tableView.tableFooterView = [UIView new];
  
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 3) {
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CoinConfirmOrderAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CoinConfirmOrderAddressCell" forIndexPath:indexPath];
        cell.selectionStyle =0;
        return cell;
    }
    if (indexPath.section == 1) {
        CoinConfirmCommodityOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CoinConfirmCommodityOrderCell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
        return cell;
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        CoinConfirmCommodityDistributionCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CoinConfirmCommodityDistributionCell"];
        cell.selectionStyle = 0;
        return cell;
    }
    
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 75;
    }else if (indexPath.section == 1){
        return 80;
    }else if (indexPath.section == 2 && indexPath.row == 0  ){
        return 65;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 31;
    }
    return 8;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [UIView new];
    view.backgroundColor = COLOR(245, 245, 245);
    if (section == 1) {
        UILabel * label = [[UILabel alloc] init];
        label.text = @"选择配送方式";
        label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size: 12];
        label.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.left.equalTo(view).offset(16);
        }];
    }
    return view;
}
@end
