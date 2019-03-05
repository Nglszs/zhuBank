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
@interface CoinOrderDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * tableView;
@end

@implementation CoinOrderDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    [self initView];
    [self SetNavTitleColor];
    [self SetReturnButton];
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
        return cell;
    }
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    NSArray * titles = self.type == BROrderNotEnable? @[@[],@[@"支付方式",@"配送信息"],@[@"发票类型",@"发票抬头",@"纳税人识别号",@"买家留言"],@[@"下单时间",@"商品总价",@"运费",@"实付金额"]] : @[@[],@[@"订单编号",@"下单时间",@"收货地址",@"收货人",@"支付方式",@"配送方式",@"买家留言"],@[@"商品总价",@"运费",@"商品总额"]];
    cell.textLabel.text = titles[indexPath.section][indexPath.row];
    cell.textLabel.font = Regular(13);
    cell.textLabel.textColor = COLOR(102, 102, 102);
    cell.selectionStyle = 0;
    return cell;
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
    OrderNumberlabel.text = @"订单编号：1234525462";
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
    nameLabel.text = @"隔壁小王     13212345678";
    nameLabel.textColor = COLOR(102, 102, 102) ;
    nameLabel.font = Regular(15);
    [view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).offset(10);
        make.top.equalTo(view).offset(9);
        make.right.equalTo(view);
    }];
    
    
    UILabel * addressLabel = [UILabel new];
    addressLabel.text = @"江苏省,南京市,秦淮区,中山东路300号";
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
@end
