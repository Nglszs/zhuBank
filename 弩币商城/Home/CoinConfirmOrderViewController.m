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
#import "CoinInvoiceViewController.h"
@interface CoinConfirmOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableDictionary * DataDict;

@property (nonatomic,strong)UILabel * ActualPriceLabel;
@property (nonatomic,strong)UILabel * per_moneyLabel;
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
    [self SetReturnButton];
    [self Request];
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
    self.ActualPriceLabel = MoneyLabel;
    MoneyLabel.font = Regular(15);
   
    
    [view addSubview:MoneyLabel];
    [MoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(15);
        make.top.equalTo(view).offset(5);
        make.right.equalTo(view).offset(-SetX(150));
    }];
    UILabel * timeLabel = [UILabel new];
    timeLabel.font = Regular(10);
    timeLabel.textColor = COLOR(0, 0, 0);
    self.per_moneyLabel = timeLabel;
    [view addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(MoneyLabel);
        make.top.equalTo(MoneyLabel.mas_bottom).offset(3);
    }];
    
    UIButton * GoBuyButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [GoBuyButton setBackgroundColor:COLOR(254, 70, 70) forState:(UIControlStateNormal)];
    [GoBuyButton setTitle:@"提交分期订单" forState:(UIControlStateNormal)];
    GoBuyButton.adjustsImageWhenHighlighted = NO;
    GoBuyButton.titleLabel.font = MediumFont(15);
    [GoBuyButton addTarget:self action:@selector(submitOrder) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:GoBuyButton];
    [GoBuyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(view);
        make.width.mas_equalTo(SetX(130));
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
   
    [ConsentButton setBackgroundImage:BCImage(未选中) forState:(UIControlStateNormal)];
    [ConsentButton setBackgroundImage:BCImage(选中) forState:(UIControlStateSelected)];
    ConsentButton.adjustsImageWhenHighlighted = NO;
    [ConsentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(MoneyLabel);
        make.centerY.equalTo(view2);
        make.width.mas_equalTo(14);
        make.height.mas_equalTo(14);
    }];
    [ConsentButton addtargetBlock:^(UIButton *button) {
        button.selected = !button.selected;
    }];
    
    UILabel * AgreementLabel = [UILabel new];
    [view2 addSubview:AgreementLabel];
    
    NSMutableAttributedString *string3 = [[NSMutableAttributedString alloc] initWithString:@"同意委托服务协议、借款协议以及重要提示。" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    
    [string3 addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:137/255.0 blue:73/255.0 alpha:1.0]} range:NSMakeRange(2, 11)];
    
    [string3 addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:137/255.0 blue:73/255.0 alpha:1.0]} range:NSMakeRange(15, 4)];
    
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
        if (self.DataDict) {
            cell.dataDict = self.DataDict[@"address_info"];
        }
        cell.selectionStyle =0;
        return cell;
    }
    if (indexPath.section == 1) {
        CoinConfirmCommodityOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CoinConfirmCommodityOrderCell" forIndexPath:indexPath];
        
        cell.dataDict = self.DataDict[@"goods_info"];
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
            cell = [[CoinConfirmCommoditListCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"invoice" leftTitle:@"发票信息" leftTitleColor:COLOR(102, 102, 102) tagString:@"" rightStr:@"" rightStrColor:COLOR(153, 153, 153) isShowSelectImage:YES];
            cell.selectionStyle = 0;
         }
        if (self.DataDict) {
            cell.invoice_infoData = self.DataDict[@"invoice_info"];
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
       
        NSString * Identifier = [NSString stringWithFormat:@"Identifier%ld",indexPath.row];
        CoinConfirmCommoditListCell * cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
        if (cell == nil) {
            cell = [[CoinConfirmCommoditListCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:Identifier leftTitle:array[indexPath.row] leftTitleColor:COLOR(51, 51, 51) tagString:nil rightStr:nil rightStrColor:COLOR(254, 70, 70) isShowSelectImage:(indexPath.row <= 1)];
            cell.selectionStyle = 0;
        }
        NSDictionary * coupons_info;
        NSDictionary * order_info;
        if (self.DataDict) {
             coupons_info = self.DataDict[@"coupons_info"];
            order_info = self.DataDict[@"order_info"];
        }
        
        switch (indexPath.row) {
            case 0:
                if (coupons_info) {
                    cell.coupons_transfer = coupons_info[@"coupons_reduce"];
                    cell.coupons_reduce_id = coupons_info[@"coupons_reduce_id"];
                }
                
                
                break;
            case 1:
                if (coupons_info) {
                    cell.coupons_transfer = coupons_info[@"coupons_transfer"];
                    cell.coupons_reduce_id = coupons_info[@"coupons_transfer_id"];
                }
                break;
            case 2:
                if (order_info) {
                    cell.total_price = order_info[@"total_price"];
                }
                break;
            case 3:
                if (order_info) {
                    cell.transfer_price = order_info[@"transfer_price"];
                }
                
                break;
        }
        
        return cell;
        
    }
    
  
    
    return [UITableViewCell new];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 地址选择
    if (indexPath.section == 0 && indexPath.row == 0) {
        CoinSelectAddressViewController * vc = [CoinSelectAddressViewController new];
        WS(weakSelf);
        vc.address = ^(NSString *addressID, NSString *name, NSString *phone, NSString *address_area, NSString *address) {
            // 修改数据源刷新数据
            NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:self.DataDict[@"address_info"]];
            [dict setValue:addressID forKey:@"address_id"];
            [dict setValue:address forKey:@"address"];
            [dict setValue:address_area forKey:@"address_area"];
            [dict setValue:name forKey:@"consignee"];
            [dict setValue:phone forKey:@"mobile"];
            [weakSelf.DataDict setValue:dict forKey:@"address_info"];
            [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:(UITableViewRowAnimationNone)];
        };
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    // 发票信息
    if (indexPath.section == 2 && indexPath.row == 1) {
        CoinInvoiceViewController * vc = [CoinInvoiceViewController new];
        WS(weakSelf);
        vc.block = ^(NSString * _Nonnull invoice_rise, NSString * _Nonnull invoice_content) {
            NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:weakSelf.DataDict[@"invoice_info"]];
            [dict setObject:invoice_content forKey:@"invoice_content"];
            [dict setObject:invoice_rise forKey:@"invoice_rise"];
            [weakSelf.DataDict setObject:dict forKey:@"invoice_info"];
            NSIndexPath * index = [NSIndexPath indexPathForRow:1 inSection:2];
            [weakSelf.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:(UITableViewRowAnimationNone)];
        };
        
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

- (void)submitOrder{
    if (self.DataDict) {
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        dict[@"address_id"] = self.DataDict[@"address_info"][@"address_id"];
        dict[@"goods_id"] = self.DataDict[@"goods_info"][@"goods_id"];
        dict[@"goods_num"] = self.DataDict[@"goods_info"][@"num"];
        dict[@"item_id"] = self.DataDict[@"goods_info"][@"item_id"];
        dict[@"shou_pay"] = self.DataDict[@"order_info"][@"first_pay"];
        dict[@"per_money"] = self.DataDict[@"order_info"][@"per_money"];
        dict[@"qishu"] = self.DataDict[@"order_info"][@"periods"];
        dict[@"q_fenqi"] = self.DataDict[@"order_info"][@"q_fenqi"];
        dict[@"action"] = @"buy_now";
        dict[@"invoice_rise"] = self.DataDict[@"invoice_info"][@"invoice_rise"];
        dict[@"invoice_content"] = self.DataDict[@"invoice_info"][@"invoice_content"];
        [KTooL HttpPostWithUrl:@"Order/submit_order" parameters:dict loadString:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"%@",responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@",error.description);
        }];
    }
}

- (void)Request{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"q_fenqi"] = self.q_fenqi;
    dict[@"goods_id"] = self.goods_id;
    dict[@"item_id"] = self.item_id;
    dict[@"num"] = self.num;
    dict[@"periods"] = self.periods;
    dict[@"stages"] = self.stages;
    [KTooL HttpPostWithUrl:@"Order/confirm_order" parameters:dict loadString:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        if (BCStatus) {
            self.DataDict = [NSMutableDictionary dictionaryWithDictionary:responseObject[@"data"]];
            [self upFootView:self.DataDict[@"order_info"]];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (void)upFootView:(NSDictionary *)dataDict{
    if (!BCDictIsEmpty(dataDict)) {
        NSString * money = [NSString stringWithFormat:@"实付金额:  ￥%@",dataDict[@"total_price"]];
        NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:money];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:254/255.0 green:70/255.0 blue:70/255.0 alpha:1.0] range:NSMakeRange(5, string.length - 5)];
        self.ActualPriceLabel.attributedText = string;
        NSString * q_fenqi = dataDict[@"is_fenqi"];
        if ([q_fenqi integerValue] == 1) {
            self.per_moneyLabel.text = [NSString stringWithFormat:@"首付:¥%@  月供:¥%@ 期数:%@期",dataDict[@"first_pay"],dataDict[@"per_money"],dataDict[@"periods"]];
        }
    }
    
}

@end
