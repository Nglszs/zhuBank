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
#import "CoinConfirmCommoditListCell.h"
#import "CoinConfirmCommodityMessageCell.h"
#import "CoinSelectAddressViewController.h"
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
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTableView];
    [self initFooterView];
}
- (void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:(UITableViewStyleGrouped)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-92);
    }];
    [self.tableView registerClass:[CoinConfirmOrderAddressCell class] forCellReuseIdentifier:@"CoinConfirmOrderAddressCell"];
    [self.tableView registerClass:[CoinConfirmCommodityOrderCell class] forCellReuseIdentifier:@"CoinConfirmCommodityOrderCell"];
    [self.tableView registerClass:[CoinConfirmCommodityDistributionCell class] forCellReuseIdentifier:@"CoinConfirmCommodityDistributionCell"];
    [self.tableView registerClass:[CoinConfirmCommodityMessageCell class] forCellReuseIdentifier:@"CoinConfirmCommodityMessageCell"]; self.navigationController.navigationBar.titleTextAttributes=
    @{NSForegroundColorAttributeName:COLOR(51, 51, 51),
      NSFontAttributeName:[UIFont systemFontOfSize:18]};
    self.tableView.tableFooterView = [UIView new];
    
}

- (void)initFooterView{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = COLOR(244, 244, 244);
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(49);
    }];
    
    UILabel * MoneyLabel = [[UILabel alloc] init];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"实付金额:    ￥5790" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    
    [string addAttributes:@{NSFontAttributeName: Regular(15)} range:NSMakeRange(8, 1)];
    
    [string addAttributes:@{NSFontAttributeName: Regular(15), NSForegroundColorAttributeName: [UIColor colorWithRed:254/255.0 green:70/255.0 blue:70/255.0 alpha:1.0]} range:NSMakeRange(9, 5)];
    
    MoneyLabel.attributedText = string;
    [view addSubview:MoneyLabel];
    [MoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(15);
        make.top.equalTo(view).offset(9);
        make.right.equalTo(view).offset(-SetX(150));
    }];
    UILabel * timeLabel = [UILabel new];
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:@"首付：¥0.00 月供：¥580.00 期数：12期" attributes:@{NSFontAttributeName: Regular(9),NSForegroundColorAttributeName: [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]}];
    
    timeLabel.attributedText = string2;
    [view addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(MoneyLabel);
        make.bottom.equalTo(MoneyLabel.mas_bottom).offset(13);
    }];
    
    UIButton * GoBuyButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [GoBuyButton setBackgroundColor:COLOR(254, 70, 70) forState:(UIControlStateNormal)];
    [GoBuyButton setTitle:@"提交分期订单" forState:(UIControlStateNormal)];
    GoBuyButton.titleLabel.font = MediumFont(15);
    [view addSubview:GoBuyButton];
    [GoBuyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(view);
        make.width.mas_equalTo(SetX(150));
    }];
    
    UIView * view2 = [UIView new];
    view2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(43);
        make.bottom.equalTo(view.mas_top);
    }];
    
    UIButton * ConsentButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [view2 addSubview:ConsentButton];
    ConsentButton.backgroundColor = [UIColor redColor];
    [ConsentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(MoneyLabel);
        make.centerY.equalTo(view2);
        make.width.mas_equalTo(14);
        make.height.mas_equalTo(14);
    }];
    
    UILabel * AgreementLabel = [UILabel new];
    [view2 addSubview:AgreementLabel];
    
    NSMutableAttributedString *string3 = [[NSMutableAttributedString alloc] initWithString:@"同意委托服务协议、借款协议以及重要提示。" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    
    [string3 addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:137/255.0 blue:73/255.0 alpha:1.0]} range:NSMakeRange(2, 11)];
    
    [string3 addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:137/255.0 blue:73/255.0 alpha:1.0]} range:NSMakeRange(15, 3)];
    
    AgreementLabel.attributedText = string3;
    [AgreementLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view2);
        make.left.equalTo(ConsentButton.mas_right).offset(7);
        make.right.equalTo(view2);
    }];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return 3;
    }
    if (section == 3) {
        return 4;
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
    
    // 发票信息
    if (indexPath.section == 2 && indexPath.row == 1) {
        CoinConfirmCommoditListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"invoice"];
        if (cell == nil) {
            cell = [[CoinConfirmCommoditListCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"invoice" leftTitle:@"发票信息" leftTitleColor:COLOR(102, 102, 102) tagString:@"" rightStr:@"纸质-个人" rightStrColor:COLOR(153, 153, 153) isShowSelectImage:YES];
            cell.selectionStyle = 0;
         }
        return cell;
    
    }
    if (indexPath.section == 2 && indexPath.row == 2) {
        CoinConfirmCommodityMessageCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CoinConfirmCommodityMessageCell"];
        cell.selectionStyle = 0;
        return cell;
    }
    
    
    // 优惠券
    if (indexPath.section == 3) {
        NSArray * array = @[@"优惠券",@"运费抵扣券",@"商品金额：",@"配送费用："];
        NSArray * tageStrArray = @[@" 已选1张 ",@" 已选1张 ",@"",@""];
        NSArray * rightArray = @[@"-￥300",@"-￥8",@"￥5788",@"￥10"];
        NSString * Identifier = [NSString stringWithFormat:@"Identifier%ld",indexPath.row];
        CoinConfirmCommoditListCell * cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
        if (cell == nil) {
            cell = [[CoinConfirmCommoditListCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:Identifier leftTitle:array[indexPath.row] leftTitleColor:COLOR(51, 51, 51) tagString:tageStrArray[indexPath.row] rightStr:rightArray[indexPath.row] rightStrColor:COLOR(254, 70, 70) isShowSelectImage:(indexPath.row <= 1)];
            cell.selectionStyle = 0;
        }
        return cell;
        
    }
    
  
    
    return [UITableViewCell new];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 地址选择
    if (indexPath.section == 0 && indexPath.row == 0) {
        CoinSelectAddressViewController * vc = [CoinSelectAddressViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 75;
    }else if (indexPath.section == 1){
        return 80;
    }else if (indexPath.section == 2 && indexPath.row == 0  ){
        return 65;
    }
    if (indexPath.section == 2 && indexPath.row == 2) {
        return 100;
    }
    return 40;
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
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
@end
