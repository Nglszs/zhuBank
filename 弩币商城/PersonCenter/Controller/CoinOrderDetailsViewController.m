//
//  CoinOrderDetailsViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/5.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinOrderDetailsViewController.h"
#import "CoinConfirmCommodityOrderCell.h"
#import "CoinLogisticsViewController.h"
#import "SVProgressHUD.h"
#import "CoinMemberBuyViewController.h"
#import "CoinOrderAllMoneyViewController.h"
#import "CoinPayMoneyOrderViewController.h"
#import "CoinH5ViewController.h"
#import "CoinPayNotFristViewController.h"
#import "CoinGoodDetailViewController.h"
#import "CoinOrderSuccessViewController.h"
@interface CoinOrderDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSDictionary * dataDict;
@end

@implementation CoinOrderDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    [self initView];
    [self SetNavTitleColor];
    [self SetReturnButton];
    [self request];
    self.type = BROrderFinsh;
}

- (void)initView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:(UITableViewStyleGrouped)];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[CoinConfirmCommodityOrderCell class] forCellReuseIdentifier:@"CoinConfirmCommodityOrderCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.type == BROrderNotEnable) {
        return 4;
    }
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * titles = self.type == BROrderNotEnable? @[@[],@[@"支付方式",@"配送信息"],@[@"发票类型",@"发票抬头",@"纳税人识别号",@"买家留言"],@[@"下单时间",@"商品总价",@"运费",@"实付金额",@"优惠券"]] : @[@[],@[@"订单编号",@"下单时间",@"收货地址",@"收货人",@"支付方式",@"配送方式",@"买家留言"],@[@"商品总价",@"运费",@"实付金额",@"优惠券"]];
    if (section == 0) {
        return 1;
    }
    return [titles[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }
    if (self.type == BROrderNotEnable) {
        if (indexPath.section == 2 && indexPath.row == 3) {
            if (!self.dataDict) {
                return 40;
            }
            return [self widthOfString:self.dataDict[@"order_info"][@"user_note"]];
        }
    }else{
        if (!self.dataDict) {
            return 40;
        }
        if (indexPath.section == 1 && indexPath.row == 6) {
        return [self widthOfString:self.dataDict[@"order_info"][@"user_note"]];;
        }
    }
    return 40;
}

- (CGFloat)widthOfString:(NSString *)string{
    
    NSDictionary *dic = @{NSFontAttributeName:Regular(13)};  //指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake(BCWidth - 100, 0)/*计算宽度时要确定高度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.height + 15;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CoinConfirmCommodityOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CoinConfirmCommodityOrderCell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
        cell.dataDict = self.dataDict[@"goods_info"];
        return cell;
    }
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    NSArray * titles = self.type == BROrderNotEnable? @[@[],@[@"支付方式",@"配送信息"],@[@"发票类型",@"发票抬头",@"纳税人识别号",@"买家留言"],@[@"下单时间",@"商品总价",@"运费",@"实付金额",@"优惠券"]] : @[@[],@[@"订单编号",@"下单时间",@"收货地址",@"收货人",@"支付方式",@"配送方式",@"买家留言"],@[@"商品总价",@"运费",@"实付金额",@"优惠券"]];
    cell.textLabel.text = titles[indexPath.section][indexPath.row];
    cell.textLabel.font = Regular(13);
    cell.detailTextLabel.font = Regular(13);
    cell.textLabel.textColor = COLOR(102, 102, 102);
    cell.selectionStyle = 0;
    cell.detailTextLabel.text = [self detailTextLabelText:indexPath];
    cell.detailTextLabel.numberOfLines = 0;
    return cell;
}

- (NSString *)detailTextLabelText:(NSIndexPath *)index{
    if (!self.dataDict) {
        return @"";
    }
    NSString * str = @"";
    
    NSDictionary * dict = self.dataDict[@"order_info"];
    if (index.section == 1) {
        switch (index.row) {
            case 0:
                str = dict[@"order_sn"];
                break;
            case 1:
                str = dict[@"add_time"];
                break;
            case 2:
                str = dict[@"address"];
                break;
            case 3:
                str = dict[@"consignee"];
                break;
            case 4:
                str = dict[@"pay_name"];
                break;
            case 5:
                 str = dict[@"shipping_name"];
                break;
            case 6:
                str = dict[@"user_note"];
                break;
        }
    }
    if (index.section == 2 ) {
        switch (index.row) {
            case 0:
                  str = dict[@"total_amount"];
                break;
            case 1:
                  str = [NSString stringWithFormat:@"￥%@",dict[@"shipping_price"]];
                break;
            case 2:
                  str = [NSString stringWithFormat:@"￥%@",dict[@"order_amount"]];
                break;
                case 3:
                 str = [NSString stringWithFormat:@"-￥%@",dict[@"coupon_price"]];
                break;
            
        }
    }
    
    if (self.type == BROrderNotEnable) {
        if (index.section == 1) {
            switch (index.row) {
                case 0:
                    str = dict[@"pay_name"];
                    break;
                    
                default:
                    str = dict[@"shipping_name"];
                    break;
            }
        }
        
        if (index.section == 2) {
            switch (index.row) {
                case 0:
                    str = dict[@"invoice_desc"];
                    break;
                case 1:
                    str = dict[@"invoice_title"];
                    break;
                case 2:
                    str = @"";
                    break;
                case 3:
                    str = dict[@"user_note"];
                    break;
            }
        }
        
        if (index.section == 3) {
            switch (index.row) {
                case 0:
                    str = dict[@"add_time"];
                    break;
                case 1:
                    str = [NSString stringWithFormat:@"￥%@",dict[@"total_amount"]];
                    break;
                case 2:
                    str = [NSString stringWithFormat:@"￥%@",dict[@"shipping_price"]];
                    break;
                case 3:
                      str = [NSString stringWithFormat:@"￥%@",dict[@"order_amount"]];
                    break;
                    
                case 4:
                    str = [NSString stringWithFormat:@"-￥%@",dict[@"coupon_price"]];
                    break;
            }
        }
    }
    return str;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.type == BROrderNotPay) {
        if (section == 0) {
            return 60;
        }
        if (section == 2) {
            return 40;
        }
    }
    
    if (self.type == BROrderNotEnable) {
        if (section == 0) {
            return 60;
        }
        if (section == 3) {
            return 40;
        }
    }
    
    if (section == 2 && self.type == BROrderFinsh) {
        return 40;
    }
   
    
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [self returnFootView:section];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.type == BROrderNotEnable) {
        if (section == 0) {
            return 110;
        }
        return 0.01;
    }
    if (section != 0) {
        return 38;
    }
    
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self returnHeaderView:section];
}

- (UIView *)returnHeaderView:(NSInteger)section{
     UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
     if (self.type == BROrderNotEnable && section == 0) {
         [self NotEnableHeaderView:view];
         return view;
     }
    if (self.type != BROrderNotEnable) {
        if (section == 0) {
            
            return view;
        }else{
            
            UILabel * label = [UILabel new];
            label.textColor = COLOR(102, 102, 102);
            label.font = Regular(15);
            label.text = section == 1? @"基本信息" :@"价格信息";
            [view addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(view).offset(LEFT_Margin);
                make.centerY.equalTo(view);
            }];
            UIView * lineView = [UIView new];
            lineView.backgroundColor = COLOR(238, 238, 238);
            [view addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(label).offset(0);
                make.bottom.equalTo(view);
                make.right.equalTo(view).offset(-LEFT_Margin);
                make.height.mas_equalTo(0.5);
            }];
            return view;
        }
    }
    
    return view;
}
- (UIView *)returnFootView:(NSInteger)section{
    
    UIView * view = [UIView new];
    
    // 未付款  取消订单
    if (self.type == BROrderNotPay) {
        if (section == 0) {
            view.backgroundColor = [UIColor whiteColor];
            UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [btn setTitle:@"  取消订单  " forState:(UIControlStateNormal)];
            [btn setTitleColor:COLOR(51, 51, 51) forState:(UIControlStateNormal)];
            btn.titleLabel.font = Regular(14);
            btn.layer.cornerRadius = 10;
            btn.layer.borderWidth = 0.5;
            btn.layer.borderColor = COLOR(153, 153, 153).CGColor;
            btn.clipsToBounds = YES;
            [view addSubview:btn];
            [btn addTarget:self action:@selector(cancelOrder) forControlEvents:(UIControlEventTouchUpInside)];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(view).offset(- 16);
                make.bottom.equalTo(view).offset(-22);
                make.height.mas_equalTo(27);
            }];
            
            UIView * lineView = [UIView new];
            lineView.backgroundColor = COLOR(245, 245, 245);
            [view addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.equalTo(view);
                make.height.mas_equalTo(10);
            }];
            return view;
            
        }
        
        if (section == 2) {
            UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [btn setTitle:@"  立即付款  " forState:(UIControlStateNormal)];
            btn.titleLabel.font = Regular(14);
            btn.layer.cornerRadius = 10;
            btn.clipsToBounds = YES;
            btn.backgroundColor = COLOR(227, 47, 33);
            [view addSubview:btn];
            [btn addTarget:self action:@selector(goPay) forControlEvents:(UIControlEventTouchUpInside)];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(view).offset(- 16);
                make.centerY.equalTo(view);
                make.height.mas_equalTo(27);
            }];
            
        }
    }
    
    if (self.type == BROrderFinsh) {
        if (section == 2) {
            UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [btn setTitle:@"  查看物流  " forState:(UIControlStateNormal)];
            btn.titleLabel.font = Regular(14);
            btn.layer.cornerRadius = 10;
            btn.clipsToBounds = YES;
            btn.backgroundColor = COLOR(227, 47, 33);
            [view addSubview:btn];
            view.backgroundColor = [UIColor whiteColor];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(view).offset(- 16);
                make.centerY.equalTo(view);
                make.height.mas_equalTo(27);
            }];
            [btn addTarget:self action:@selector(ExamineLogistics) forControlEvents:(UIControlEventTouchUpInside)];
            return view;
        }
    }
    if (self.type == BROrderNotEnable) {
        if (section == 0) {
            UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [btn setTitle:@"  联系客服  " forState:(UIControlStateNormal)];
            btn.titleLabel.font = Regular(14);
            btn.layer.cornerRadius = 10;
            btn.clipsToBounds = YES;
            [view addSubview:btn];
            view.backgroundColor = [UIColor whiteColor];
            btn.layer.borderWidth = 0.5;
            btn.layer.borderColor = COLOR(153, 153, 153).CGColor;
            [btn setTitleColor:COLOR(51, 51, 51) forState:(UIControlStateNormal)];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(view).offset(- 16);
                make.centerY.equalTo(view);
                make.height.mas_equalTo(27);
            }];
            UIView * lineView = [UIView     new];
            lineView.backgroundColor = COLOR(245, 245, 245);
            [view addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.equalTo(view);
                make.height.mas_equalTo(10);
            }];
            [btn addTarget:self action:@selector(phone) forControlEvents:(UIControlEventTouchUpInside)];
            return view;
        }
        if (section == 3) {
            UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [btn setTitle:@"  确认收货  " forState:(UIControlStateNormal)];
            btn.titleLabel.font = Regular(14);
            btn.layer.cornerRadius = 10;
            btn.clipsToBounds = YES;
            btn.backgroundColor = COLOR(227, 47, 33);
            [view addSubview:btn];
            view.backgroundColor = [UIColor whiteColor];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(view).offset(- 16);
                make.centerY.equalTo(view);
                make.height.mas_equalTo(27);
            }];
            [btn addTarget:self action:@selector(order_confirm) forControlEvents:(UIControlEventTouchUpInside)];
            
            UIButton * btn2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [btn2 setTitle:@"  查看物流  " forState:(UIControlStateNormal)];
            btn2.titleLabel.font = Regular(14);
            btn2.layer.cornerRadius = 10;
            btn2.clipsToBounds = YES;
            [view addSubview:btn2];
            view.backgroundColor = [UIColor whiteColor];
            btn2.layer.borderWidth = 0.5;
            btn2.layer.borderColor = COLOR(153, 153, 153).CGColor;
            [btn2 setTitleColor:COLOR(51, 51, 51) forState:(UIControlStateNormal)];
            [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(btn.mas_left).offset(- 16);
                make.centerY.equalTo(view);
                make.height.mas_equalTo(27);
            }];
            [btn2 addTarget:self action:@selector(ExamineLogistics) forControlEvents:(UIControlEventTouchUpInside)];
            return view;
        }
       
    }
    view.backgroundColor = COLOR(245, 245, 245);
    int temp = self.type == BROrderNotEnable? 3 : 2;
    if (section == temp) {
        view.backgroundColor = [UIColor whiteColor];
    }
    return view;
}



- (void)NotEnableHeaderView:(UIView *)superView{
    UILabel * OrderNumberlabel = [UILabel new];
    if (self.dataDict) {
         OrderNumberlabel.text = [NSString stringWithFormat:@"订单编号：%@",self.dataDict[@"order_info"][@"order_sn"]];
    }
   
    OrderNumberlabel.textColor = COLOR(102, 102, 102);
    OrderNumberlabel.font = Regular(15);
    [superView addSubview:OrderNumberlabel];
    [OrderNumberlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView).offset(16);
        make.height.mas_equalTo(40);
        make.top.equalTo(superView);
    }];
    UILabel * stateLabel = [[UILabel alloc] init];
    stateLabel.text = @"待收货";
    stateLabel.font = Regular(15);
    stateLabel.textColor = COLOR(255, 1, 1);
    [superView addSubview:stateLabel];
    [stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(OrderNumberlabel);
        make.right.equalTo(superView).offset(-16);
    }];
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = COLOR(245, 245, 245);
    [superView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.height.mas_equalTo(8);
        make.top.equalTo(OrderNumberlabel.mas_bottom);
    }];
    
    UIView * view = [UIView new];
    [superView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.top.equalTo(lineView.mas_bottom);
        make.height.mas_equalTo(60);
    }];
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.image = BCImage(地址);
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(16);
        make.centerY.equalTo(view);
        make.width.mas_equalTo(9 * 1.5);
        make.height.mas_equalTo(12 * 1.5);
    }];
    
    UILabel * nameLabel = [UILabel new];
    
    nameLabel.textColor = COLOR(102, 102, 102) ;
    nameLabel.font = Regular(15);
    [view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).offset(10);
        make.top.equalTo(view).offset(9);
        make.right.equalTo(view);
    }];
    
    
    UILabel * addressLabel = [UILabel new];
    if (self.dataDict) {
        nameLabel.text = self.dataDict[@"order_info"][@"consignee"];
        addressLabel.text = self.dataDict[@"order_info"][@"address"];
    }
    addressLabel.textColor = COLOR(102, 102, 102) ;
    addressLabel.font = Regular(12);
    [view addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).offset(10);
        make.bottom.equalTo(view).offset(-9);
        make.right.equalTo(view);
    }];
    
    UIView * lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = COLOR(245, 245, 245);
    [superView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(superView);
        make.height.mas_equalTo(8);
        make.top.equalTo(view.mas_bottom);
    }];
}

- (void)request{
    [KTooL HttpPostWithUrl:@"Order/order_detail" parameters:@{@"order_id":self.order_id} loadString:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (BCStatus) {
            //0 代付款  1 待发货 2 已完成 3 已取消 4 待收货
            int check_status = [responseObject[@"data"][@"order_info"][@"check_status"]  intValue];
           switch (check_status) {
                case 0:
                     self.type = BROrderNotPay;
                    break;
                case 3:
                case 1:
                    self.type = BROrderNotDispatch;
                    break;
               case 2:
                    self.type = BROrderFinsh;
                    break;
                case 4:
                     self.type = BROrderNotEnable;
                    break;
               
            }
            self.dataDict = responseObject[@"data"];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark  取消订单
- (void)cancelOrder{
    [self showSystemAlertTitle:@"提示" message:@"您确定要取消订单吗？" cancelTitle:@"再想想" confirmTitle:@"确定" cancel:nil confirm:^{
       [KTooL HttpPostWithUrl:@"Order/cancel_order" parameters:@{@"order_id":self.order_id} loadString:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            if (BCStatus) {
                VCToast(@"取消订单成功", 1);
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 
                 for (int i = 0; i < self.navigationController.viewControllers.count; i++) {
                     UIViewController * vc = self.navigationController.viewControllers[i];
                     if ([vc isKindOfClass:[CoinGoodDetailViewController class]]) {
                         if (self.resultData) {
                             self.resultData(@"1");
                         }
                         [self.navigationController popToViewController:vc animated:YES];
                         return;
                     }
                 }
                 if (self.resultData) {
                     self.resultData(@"1");
                 }
                [self.navigationController popViewControllerAnimated:YES];
                });
               
            }else{
                VCToast(BCMsg, 2);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            VCToast(@"取消失败", 2);
        }];
    }];
    
    
}


#pragma mark 立即付款
- (void)goPay{
    if (self.dataDict) {
        [KTooL HttpPostWithUrl:@"Order/get_order_info" parameters:@{@"order_id" : self.order_id} loadString:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            if (BCStatus) {
                [self goPay:responseObject];
            }else{
                VCToast(@"支付失败", 2);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            VCToast(@"支付失败", 2);
        }];
        
        
    }
   
}

- (void)goPay:(NSDictionary *)dict{
    
    // 订单成功了，要判断商品状态   1 全款（CoinOrderAllMoneyViewController）   2 有首付分期（CoinPayMoneyOrderViewController ）  3 无首付分期（CoinPayNotFristViewController）

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
        
        CoinMemberBuyViewController *VC = [[CoinMemberBuyViewController alloc] init];
        VC.type = BRPayBuyCommodity;
        VC.titleString = @"支付首付";
        VC.orderNum =dict[@"data"][@"order_sn"];
        VC.Money = dict[@"data"][@"pay_amount"];
        VC.orderID = dict[@"data"][@"order_id"];
        VC.DataArray = dict[@"data"][@"hot_goods"];
        [self.navigationController pushViewController:VC animated:YES];
        
    }
    
}


#pragma mark 确认收货
- (void)order_confirm{
     [self showSystemAlertTitle:@"提示" message:@"是否收到该订单商品?" cancelTitle:@"未收货" confirmTitle:@"已收货" cancel:nil confirm:^{
        [KTooL HttpPostWithUrl:@"Order/order_confirm" parameters:@{@"order_id":self.order_id} loadString:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            if (BCStatus) {
                [self request];
                CoinOrderSuccessViewController * vc = [CoinOrderSuccessViewController new];
                NSDictionary * goods_info = self.dataDict[@"goods_info"];
                vc.imageUrl = goods_info[@"original_img"];
                vc.name = goods_info[@"goods_name"];
                vc.size = goods_info[@"spec_key_name"];
                vc.price = goods_info[@"goods_price"];
                vc.num = goods_info[@"goods_num"];
                
                [self.navigationController pushViewController:vc animated:YES];
                 if (self.resultData) {
                    self.resultData(@"1");
                }
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
      
    }];
    
    
    
}

// 联系客服
- (void)phone{
    if (self.dataDict) {
        NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.dataDict[@"goods_info"][@"customer_mobile"]];
        UIWebView * callWebview = [[UIWebView alloc] init];[callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];[self.view addSubview:callWebview];
     }

    
    
}

//查看物流
- (void)ExamineLogistics{
    if (self.dataDict) {
        NSString * url =  self.dataDict[@"order_info"][@"express"];
        CoinH5ViewController * VC = [CoinH5ViewController new];
        VC.titleStr = @"查看物流信息";
        VC.url = url;
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    
    
}
@end
