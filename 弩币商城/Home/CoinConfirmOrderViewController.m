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
#import "CoinMemberBuyViewController.h"
#import "CoinH5ViewController.h"
#import "CoinCertifyViewController.h"
#import "CoinOrderAllMoneyViewController.h"
#import "CoinPayMoneyOrderViewController.h"
#import "CoinPayNotFristViewController.h"
#import "CoinChangePhoneViewController.h"
#import "BCUseCouPonView.h"
#import "BCDealPasswordView.h"
#import "CoinChangeAddressViewController.h"

@interface CoinConfirmOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableDictionary * DataDict;

@property (nonatomic,strong)UILabel * ActualPriceLabel;
@property (nonatomic,strong)UILabel * per_moneyLabel;

@property (nonatomic,strong)UIButton * ConsentButton;
@property (nonatomic,strong)UIView * tempView;
@property (nonatomic,strong)UIButton * GoBuyButton;
@property (nonatomic,copy)NSString * phone;
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Request) name:@"UserAddressSuccess" object:nil];
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
    
    NSString * title = [self.q_fenqi intValue] == 1 ? @"提交分期订单" :@"提交订单";
    UIButton * GoBuyButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.GoBuyButton = GoBuyButton;
    [GoBuyButton setBackgroundColor:COLOR(254, 70, 70) forState:(UIControlStateNormal)];
    [GoBuyButton setTitle:title forState:(UIControlStateNormal)];
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
    self.tempView = view2;
    view2.hidden = YES;
    [ConsentButton setBackgroundImage:BCImage(未选中) forState:(UIControlStateNormal)];
    self.ConsentButton = ConsentButton;
    [ConsentButton setBackgroundImage:BCImage(选中) forState:(UIControlStateSelected)];
    ConsentButton.selected = NO;
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
    
    
    NSMutableAttributedString *string3 = [[NSMutableAttributedString alloc] initWithString:@"同意委托服务协议、" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    
    [string3 addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:137/255.0 blue:73/255.0 alpha:1.0]} range:NSMakeRange(2, 6)];
    
    AgreementLabel.userInteractionEnabled = YES;
    MJWeakSelf;
    [AgreementLabel addTapGestureWithBlock:^{
        [weakSelf pushH5Title:@"委托服务协议" url:self.DataDict[@"links"][@"entrustment_agreement_link"]];
    }];
    
    UILabel * label1 = [UILabel new];
    label1.textColor = COLOR(255, 137, 73);
    label1.text = @"借款协议";
    label1.font = Regular(14);
    label1.userInteractionEnabled = YES;
    [view2 addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(AgreementLabel.mas_right);
        make.centerY.equalTo(AgreementLabel);
    }];
    [label1 addTapGestureWithBlock:^{
        [weakSelf pushH5Title:@"借款协议" url:self.DataDict[@"links"][@"loan_agreement_link"]];
    }];
    
    AgreementLabel.attributedText = string3;
    [AgreementLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view2);
        make.left.equalTo(ConsentButton.mas_right).offset(7);
        
    }];
    
    UILabel * label2 = [UILabel new];
    
    NSMutableAttributedString *string4 = [[NSMutableAttributedString alloc] initWithString:@"以及重要提示。" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    
    [string4 addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:137/255.0 blue:73/255.0 alpha:1.0]} range:NSMakeRange(2, 4)];
    label2.attributedText = string4;
    [view2 addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_right);
        make.centerY.equalTo(label1);
    }];
    label2.userInteractionEnabled = YES;
    [label2 addTapGestureWithBlock:^{
         [weakSelf pushH5Title:@"重要提示" url:self.DataDict[@"links"][@"risk_warning_link"]];
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
        [cell.AddButton addTarget:self action:@selector(AddAddressAction:) forControlEvents:(UIControlEventTouchUpInside)];
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
            cell = [[CoinConfirmCommoditListCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"invoice" leftTitle:@"发票信息" leftTitleColor:COLOR(102, 102, 102) tagString:@"" rightStr:@"不开发票" rightStrColor:COLOR(153, 153, 153) isShowSelectImage:YES];
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
                    cell.coupons_transfer_num = coupons_info[@"coupons_transfer_num"];
                }
                
                
                break;
            case 1:
                if (coupons_info) {
                    cell.coupons_reduce = coupons_info[@"coupons_transfer"];
                    cell.coupons_reduce_id = coupons_info[@"coupons_transfer_id"];
                    cell.coupons_reduce_num = coupons_info[@"coupons_reduce_num"];
                }
                break;
            case 2:
                if (order_info) {
                    // 商品总价
                    cell.total_price = order_info[@"total_price_goods"];
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
            [weakSelf upFootView:self.DataDict[@"order_info"]];
        };
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    // 优惠券
    if (indexPath.section == 3 && indexPath.row == 0) {
        if (self.DataDict) {
          
            //0是现金券，1是运费q券
            BCUseCouPonView * view = [[BCUseCouPonView alloc] initWithFrame:CGRectMake(0, 0, BCWidth, BCHeight) andUserID:_goods_id withMoney:indexPath.row withItemID:self.item_id endNum:[self.num integerValue]];
            view.selectID = self.DataDict[@"coupons_info"][@"coupons_reduce_id"];
            view.backBlock = ^(id  _Nonnull result) {
                NSString * idString = result[@"id"];
                NSString * money = result[@"money"];
                NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:self.DataDict[@"coupons_info"]];
                
                [dict setObject:money forKey:@"coupons_reduce"];
                [dict setObject:idString forKey:@"coupons_reduce_id"];
                 [self.DataDict setObject:dict forKey:@"coupons_info"];
                 [self upFootView:self.DataDict[@"order_info"]];
                [self.tableView reloadData];
            };
            [self.view addSubview:view];
        }
        
    }
    
     // 运费抵扣券
    if (indexPath.section == 3 && indexPath.row == 1) {
        if (self.DataDict) {
            //0是现金券，1是运费q券
            BCUseCouPonView * view = [[BCUseCouPonView alloc] initWithFrame:CGRectMake(0, 0, BCWidth, BCHeight) andUserID:_goods_id withMoney:indexPath.row withItemID:self.item_id endNum:[self.num integerValue]];
            view.selectID = self.DataDict[@"coupons_info"][@"coupons_transfer_id"];
            MJWeakSelf;
            view.backBlock = ^(id  _Nonnull result) {
                NSString * idString = result[@"id"];
                NSString * money = result[@"money"];
                NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:self.DataDict[@"coupons_info"]];
                
                [dict setObject:money forKey:@"coupons_transfer"];
                [dict setObject:idString forKey:@"coupons_transfer_id"];
                [weakSelf.DataDict setObject:dict forKey:@"coupons_info"];
                  [self upFootView:weakSelf.DataDict[@"order_info"]];
                [self.tableView reloadData];
            };
            [self.view addSubview:view];
        }
        
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
        // 判断选择收货地址
        NSString * idS = [NSString stringWithFormat:@"%@",self.DataDict[@"address_info"][@"address_id"]];
        if (BCStringIsEmpty(idS)) {
            [SVProgressHUD showInfoWithStatus:@"请选择收货地址"];
            [SVProgressHUD dismissWithDelay:2];
            return;
        }
        
        if ([self.q_fenqi intValue] == 1) {
            // 判断同意协议
            if (!self.ConsentButton.selected) {
                [SVProgressHUD showInfoWithStatus:@"请同意委托服务协议、借款协议、以及重要提示"];
                [SVProgressHUD dismissWithDelay:2];
                return;
            }
            // 需要输入交易密码
            CGFloat m = [self.DataDict[@"order_info"][@"total_price_goods"] floatValue] - [self.DataDict[@"coupons_info"][@"coupons_reduce"] floatValue] - [self.DataDict[@"coupons_info"][@"coupons_transfer"] floatValue] + [self.DataDict[@"order_info"][@"transfer_price"] floatValue];
             BCDealPasswordView * view = [[BCDealPasswordView alloc] initWithFrame:BCBound money:[self decimalNumberString:m]];
            
            view.vc = self;
            MJWeakSelf;
            view.Password = ^(NSString * _Nonnull Password) {
                [weakSelf verificationPassword:Password];
            };
            [self.view addSubview:view];
         }else{
            [self ultimatelySubmitOrder];
        }
     }
}

#pragma mark  验证支付密码
- (void)verificationPassword:(NSString *)password{
    self.GoBuyButton.userInteractionEnabled = NO;
    [KTooL HttpPostWithUrl:@"Order/check_paypwd" parameters:@{@"paypwd":password} loadString:@"正在提交" success:^(NSURLSessionDataTask *task, id responseObject) {
        if (BCStatus) {
            
            [self ultimatelySubmitOrder];
        }else{
          self.GoBuyButton.userInteractionEnabled = YES;
            VCToast(BCMsg, 2);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        VCToast(@"支付失败", 2);
        self.GoBuyButton.userInteractionEnabled = YES;
    }];
}

#pragma mark  最终的提交订单
- (void)ultimatelySubmitOrder{
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"address_id"] = self.DataDict[@"address_info"][@"address_id"];
    dict[@"goods_id"] = self.DataDict[@"goods_info"][@"goods_id"];
    dict[@"goods_num"] = self.DataDict[@"goods_info"][@"num"];
    dict[@"item_id"] = self.DataDict[@"goods_info"][@"item_id"];
    dict[@"shou_pay"] = self.DataDict[@"order_info"][@"first_pay"];
    dict[@"per_money"] = self.DataDict[@"order_info"][@"per_money"];
    dict[@"qishu"] = self.DataDict[@"order_info"][@"periods"];
    
    dict[@"q_fenqi"] = self.DataDict[@"order_info"][@"is_fenqi"];
    dict[@"action"] = @"buy_now";
    dict[@"invoice_rise"] = self.DataDict[@"invoice_info"][@"invoice_rise"];
    dict[@"invoice_content"] = self.DataDict[@"invoice_info"][@"invoice_content"];
    
    dict[@"transfer_price"] = self.DataDict[@"order_info"][@"transfer_price"];
    dict[@"stages"] = self.DataDict[@"order_info"][@"stages"];
    CoinConfirmCommodityMessageCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:2]];
    NSString * str = cell.textView.text;
    if ([str isEqualToString:@"选填"]) {
        str = @"";
    }
    dict[@"user_note"] = str;
    NSDictionary * temp = self.DataDict[@"coupons_info"];
    [temp enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [dict setObject:obj forKey:key];
    }];
    
    
    // 关闭用户交互
    self.GoBuyButton.userInteractionEnabled = NO;
    [KTooL HttpPostWithUrl:@"Order/submit_order" parameters:dict loadString:@"正在提交" success:^(NSURLSessionDataTask *task, id responseObject) {
         self.GoBuyButton.userInteractionEnabled = YES;
        if (BCStatus) {
            [self goPay:responseObject];
        }else{
            VCToast(BCMsg, 2);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.GoBuyButton.userInteractionEnabled = YES;
        VCToast(@"提交失败", 2);
    }];
    
}

- (void)goPay:(NSDictionary *)dict{
  
    // 订单成功了，要判断商品状态   1 全款（CoinOrderAllMoneyViewController）   2 有首付分期（CoinPayMoneyOrderViewController ）  3 无首付分期（CoinPayNotFristViewController）
    
    if (!self.DataDict) {
        return;
    }
//    flag 标记(1：不分期   2：分期零首付  3：分期有首付)
    
    int flag = [dict[@"data"][@"flag"] intValue];
    if (flag == 1) {
        CoinOrderAllMoneyViewController * vc = [CoinOrderAllMoneyViewController new];
        vc.OrderNum = dict[@"data"][@"order_sn"];
        vc.Money = dict[@"data"][@"pay_amount"];
        vc.order_id = dict[@"data"][@"order_id"];
        vc.dataArray = dict[@"data"][@"hot_goods"];
        [self.navigationController pushViewController:vc animated:YES];
    }
  
    if (flag == 2) {
        CoinPayNotFristViewController * VC = [CoinPayNotFristViewController new];
        VC.name = dict[@"data"][@"consignee"];
        VC.address = dict[@"data"][@"address"];
        VC.orderNum = dict[@"data"][@"order_sn"];
        VC.dataArray = dict[@"data"][@"hot_goods"];
        VC.order_id = dict[@"data"][@"order_id"];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if (flag == 3) {
        CoinPayMoneyOrderViewController  * vc = [CoinPayMoneyOrderViewController new];
        vc.name = dict[@"data"][@"consignee"];
        vc.address = dict[@"data"][@"address"];;
        vc.orderNum = dict[@"data"][@"order_sn"];
        vc.money = dict[@"data"][@"pay_amount"];
        vc.order_id = dict[@"data"][@"order_id"];
         vc.dataArray = dict[@"data"][@"hot_goods"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
    
}


- (void)Request{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"q_fenqi"] = self.q_fenqi;
    dict[@"goods_id"] = self.goods_id;
    dict[@"item_id"] = self.item_id;
    dict[@"num"] = self.num;
    
    if (!BCStringIsEmpty(self.periods)) {
      NSCharacterSet * nonDigits =[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        int remainSecond =[[self.periods stringByTrimmingCharactersInSet:nonDigits] intValue];
        dict[@"periods"] = [NSString stringWithFormat:@"%d",remainSecond];
    }
    dict[@"stages"] = self.stages;
  
    [KTooL HttpPostWithUrl:@"Order/confirm_order" parameters:dict loadString:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([self disposeStatus:[responseObject[@"status"] intValue]]) {
            self.DataDict = [NSMutableDictionary dictionaryWithDictionary:responseObject[@"data"]];
            [self upFootView:self.DataDict[@"order_info"]];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (BOOL)disposeStatus:(int)status{
    //status:1成功 0:未登录 -1:请先购买会员卡 -2:不符合分期条件 -3:会员卡到期 -4:请先验证身份信息 -5:请先绑卡 -6:请先评估您的信用/您的信用评分已过期,请重新评估 -7:请先设置交易密码 -8:库存不足 -9:剩余额度不足,请调整首付比例
    NSString  * msg;
    if (status == 1) {
        return YES;
    }
    if (status == 0) {
        
    }
    if (status == -1) {
         CoinMemberBuyViewController * VC = [CoinMemberBuyViewController new];
            VC.type  = BRPayBuyMember;
            [self.navigationController pushViewController:VC animated:YES];
     }
    if (status == -2) {
        msg = @"不符合分期条件";
      
    }
    if (status == -3) {
        msg = @"会员卡到期";
    }
    if (status == -4) {
        CoinCertifyViewController * vc = [CoinCertifyViewController new];
        vc.indexType = 1;
        vc.isFenqi = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (status == -5) {
        CoinCertifyViewController * vc = [CoinCertifyViewController new];
        vc.indexType = 2;
        vc.isFenqi = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (status == -6) {
        CoinCertifyViewController * vc = [CoinCertifyViewController new];
        vc.indexType = 3;
        vc.isFenqi = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (status == -7) {
        CoinChangePhoneViewController * vc = [CoinChangePhoneViewController new];
        vc.isSetPay = YES;
        vc.phoneNum =  self.phone;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (status == -8) {
        msg = @"库存不足";
    }
    if (status == -9) {
        msg = @"剩余额度不足,请调整首付比例";
    }
    if (msg) {
        VCToast(msg, 2);
    }
    return NO;
    
}


- (void)upFootView:(NSDictionary *)dataDict{
    if (!BCDictIsEmpty(dataDict)) {
        CGFloat m = [dataDict[@"total_price_goods"] floatValue] - [self.DataDict[@"coupons_info"][@"coupons_reduce"] floatValue] - [self.DataDict[@"coupons_info"][@"coupons_transfer"] floatValue] + [dataDict[@"transfer_price"] floatValue];
        NSString * money = [NSString stringWithFormat:@"实付金额:  ￥%@",[self decimalNumberString:m]];
        NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:money];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:254/255.0 green:70/255.0 blue:70/255.0 alpha:1.0] range:NSMakeRange(5, string.length - 5)];
        self.ActualPriceLabel.attributedText = string;
        NSString * q_fenqi = dataDict[@"is_fenqi"];
        if ([q_fenqi integerValue] == 1) {
            self.per_moneyLabel.text = [NSString stringWithFormat:@"首付:¥%@  月供:¥%@ 期数:%@期",dataDict[@"first_pay"],dataDict[@"per_money"],dataDict[@"periods"]];
            self.tempView.hidden = NO;
        }
    }
    
}

- (void)pushH5Title:(NSString *)title url:(NSString *)url{
    CoinH5ViewController * vc = [CoinH5ViewController new];
    vc.titleStr = title;
    vc.url = url;
    [self.navigationController pushViewController:vc animated:YES];
}

/** 字符串小数格式化
 @return 小数字符串 */
- (NSString *)decimalNumberString:(CGFloat )str{
    
    NSString *numberString = [NSString stringWithFormat:@"%f",str];
    return [NSString stringWithFormat:@"%@",[NSDecimalNumber decimalNumberWithString:numberString]];
}


#pragma mark   添加收货地址
- (void)AddAddressAction:(UIButton *)btn{
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
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
