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
    NSArray * titles = self.type == BROrderNotEnable? @[@[],@[@"支付方式",@"配送信息"],@[@"发票类型",@"发票抬头",@"纳税人识别号",@"买家留言"],@[@"下单时间",@"商品总价",@"运费",@"实付金额"]] : @[@[],@[@"订单编号",@"下单时间",@"收货地址",@"收货人",@"支付方式",@"配送方式",@"买家留言"],@[@"商品总价",@"运费",@"商品总额"]];
    if (section == 0) {
        return 1;
    }
    return [titles[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CoinConfirmCommodityOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CoinConfirmCommodityOrderCell" forIndexPath:indexPath];
        cell.selectionStyle = 0;
        cell.dataDict = self.dataDict[@"goods_info"];
        return cell;
    }
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    NSArray * titles = self.type == BROrderNotEnable? @[@[],@[@"支付方式",@"配送信息"],@[@"发票类型",@"发票抬头",@"纳税人识别号",@"买家留言"],@[@"下单时间",@"商品总价",@"运费",@"实付金额"]] : @[@[],@[@"订单编号",@"下单时间",@"收货地址",@"收货人",@"支付方式",@"配送方式",@"买家留言"],@[@"商品总价",@"运费",@"商品总额"]];
    cell.textLabel.text = titles[indexPath.section][indexPath.row];
    cell.textLabel.font = Regular(13);
    cell.detailTextLabel.font = Regular(13);
    cell.textLabel.textColor = COLOR(102, 102, 102);
    cell.selectionStyle = 0;
    cell.detailTextLabel.text = [self detailTextLabelText:indexPath];
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
            UIView * lineView = [UIView new];
            lineView.backgroundColor = COLOR(245, 245, 245);
            [view addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.equalTo(view);
                make.height.mas_equalTo(10);
            }];
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


- (void)ExamineLogistics{
    
    CoinLogisticsViewController * vc = [CoinLogisticsViewController new];
    [self.navigationController pushViewController:vc animated:YES];
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
        NSLog(@"%@",responseObject);
        if (BCStatus) {
            self.dataDict = responseObject[@"data"];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

// 取消订单
- (void)cancelOrder{
    
    [KTooL HttpPostWithUrl:@"Order/cancel_order" parameters:@{@"order_id":self.order_id} loadString:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (BCStatus) {
            [SVProgressHUD showSuccessWithStatus:@"成功"]; dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}


// 立即付款
- (void)goPay{
    if (self.dataDict) {
        
        NSString * is_fenqi = [NSString stringWithFormat:@"%@",self.dataDict[@"order_info"][@"is_fenqi"]];
        if ([is_fenqi isEqualToString:@"0"]) {
            // 判断订单是不是分期
            CoinOrderAllMoneyViewController * vc = [CoinOrderAllMoneyViewController new];
            vc.OrderID = self.dataDict[@"order_info"][@"order_sn"];
            vc.Money = self.dataDict[@"order_info"][@"order_amount"];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            CoinPayMoneyOrderViewController * vc = [CoinPayMoneyOrderViewController new];
            vc.money = self.dataDict[@"order_info"][@"first_pay"];
            vc.name  = self.dataDict[@"order_info"][@"consignee"];
            vc.address = self.dataDict[@"order_info"][@"address"];
            vc.orderNum = self.dataDict[@"order_info"][@"order_sn"];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
     
    }
   
}

// 确认收货
- (void)order_confirm{
    
    [KTooL HttpPostWithUrl:@"Order/order_confirm" parameters:@{@"order_id":self.order_id} loadString:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (BCStatus) {
            [SVProgressHUD showSuccessWithStatus:@"成功"]; dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
@end
