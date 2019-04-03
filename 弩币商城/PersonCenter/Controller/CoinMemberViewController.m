//
//  CoinMemberViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/24.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinMemberViewController.h"
#import "CoinMemberDredgeCell.h"
#import "CoinMemberBuyViewController.h"
#import "CoinMemberCouponingCell.h"
@interface CoinMemberViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)UIButton * button;
@property (nonatomic,strong)NSDictionary * DataDict;
@property (nonatomic,strong)UIButton * agreementBtn;
@end

@implementation CoinMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"帑库金钻会员卡";
    [self initView];
    [self request];
}

- (void)initView{
    self.button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.view addSubview:self.button];
    [self.button setTitle:@"立即开通" forState:(UIControlStateNormal)];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:(UITableViewStyleGrouped)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.button.backgroundColor = COLOR(255, 0, 0);
    self.button.titleLabel.font = Regular(18);
    [self.view addSubview:self.tableView];
    self.tableView.bounces = NO;
    CGFloat hh = 40;
    if ([Tool isVip]) {
        hh = 0;
    }
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(hh);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.button);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.button.mas_top);
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.button addTarget:self action:@selector(dredgeVip) forControlEvents:(UIControlEventTouchUpInside)];
    [self request];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 7;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        CoinMemberDredgeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CoinMemberDredgeCell"];
        if (cell == nil) {
            cell =  [[CoinMemberDredgeCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"CoinMemberDredgeCell"];
        }
        cell.SelfVC = self;
        if (self.DataDict) {
            cell.service_agreement = self.DataDict[@"service_agreement"];
        }
        if ([Tool isVip]) {
            if (self.DataDict) {
              cell.end_time = self.DataDict[@"end_time"];
            }
            
        }
         [cell.dredgeButton addTarget:self action:@selector(dredgeVip) forControlEvents:(UIControlEventTouchUpInside)];
        self.agreementBtn =  cell.agreementBtn;
        cell.selectionStyle = 0;
        return cell;
    }
     if (indexPath.section == 1 && indexPath.row == 1) {
        CoinMemberCouponingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CoinMemberCouponingCell1"];
        if (cell == nil) {
            cell = [[CoinMemberCouponingCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"CoinMemberCouponingCell1"];
        }
         cell.SeleVC = self;
         cell.dataArray = self.DataDict[@"mall_coupons"];
        return cell;
    }
    
    if (indexPath.section == 1 && indexPath.row == 3) {
        CoinMemberCouponingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CoinMemberCouponingCell1"];
        if (cell == nil) {
            cell = [[CoinMemberCouponingCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"CoinMemberCouponingCell1"];
        }
        cell.SeleVC = self;
        cell.dataArray = self.DataDict[@"month_coupons"];
        return cell;
    }
    
    NSArray * titles = @[@"特权一",@"",@"特权二",@"",@"特权三",@"特权四",@"特权五"];
    NSArray * imageStr = @[@"特权一 拷贝",@"",@"特权2 拷贝",@"",@"特权3 拷贝",@"特权4 拷贝",@"特权5 拷贝"];
    NSArray * detailes = @[@"",@"",@"每月均可享福利大礼包",@"",@"帑库银票现金分期资格",@"3C商品分期特权",@"会员期内享受一次免费体检体验（限定一人）"];
    if (indexPath.section == 1) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        }
        cell.selectionStyle = 0;
        cell.imageView.image = [UIImage imageNamed:imageStr[indexPath.row]];
        cell.textLabel.text = titles[indexPath.row];
        cell.detailTextLabel.text = detailes[indexPath.row];
        cell.textLabel.textColor = COLOR(51, 51, 51);
        cell.textLabel.font = Regular(12);
        cell.detailTextLabel.textColor = COLOR(51, 51, 51);
        cell.detailTextLabel.font = Regular(11);
        if (indexPath.row == 0 && self.DataDict) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"享受价值%@元帑库商城会员礼包",self.DataDict[@"mall_money"]];
        }
        return cell;
    }
    
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return (BCWidth - 40) / 335.0 * 190 + 30;
    }
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 35;
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [UIView new];
    
    if (section == 1) {
        UIImageView * image = [UIImageView new];
        [view addSubview:image];
        image.image = BCImage(会员图层);
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.left.equalTo(view).offset(20);
            make.width.mas_equalTo(7);
            make.height.mas_equalTo(15);
        }];
        
        UILabel * label = [UILabel new];
        label.text = @"金钻会员特权";
        label.font = Regular(15);
        label.textColor = COLOR(51, 51, 51);
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(image.mas_right).offset(6);
            make.centerY.equalTo(image);
        }];
        view.backgroundColor = [UIColor whiteColor];
        UIView * lineView = [UIView new];
        lineView.backgroundColor = COLOR(238, 238, 238);
        [view addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(16);
            make.right.equalTo(view).offset(-16);
            make.bottom.equalTo(view);
            make.height.mas_equalTo(0.5);
        }];
        return view;
        
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 8;
    }
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [UIView new];
    if (section == 0) {
        view.backgroundColor = COLOR(238, 238, 238);
        return view;
    }
    view.backgroundColor = COLOR(238, 238, 238);
    UILabel * label = [UILabel new];
    label.textColor = COLOR(153, 153, 153);
    label.font = Regular(10);
    label.text = @"1、备注：通过帑库银票借款用户需成为会员方可借款，若因征信等原因无法借款，会员费用不退款，可继续用于商城优惠购物。\n2、借款提示：请确认用户自身信誉良好且满足借款条件，否则因个人原因无法完成借款的，平台会员不退还相关费用。";
    label.numberOfLines = 0;
    
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(12);
        make.bottom.equalTo(view).offset(-12);
        make.left.equalTo(view).offset(16);
        make.right.equalTo(view).offset(-16);
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    return view;
}

- (void)dredgeVip{
    if (!self.agreementBtn.selected) {
        VCToast(@"请先同意会员服务协议", 2);
        return;
    }
    CoinMemberBuyViewController * vc = [CoinMemberBuyViewController new];
    vc.type = BRPayBuyMember;
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)request{
    [KTooL HttpPostWithUrl:@"CashLoan/vip_card" parameters:nil loadString:@"正在加载" success:^(NSURLSessionDataTask *task, id responseObject) {
        if (BCStatus) {
            self.DataDict = responseObject[@"data"];
            [self.tableView reloadData];
            
            int buy_vip = [self.DataDict[@"buy_vip"] intValue];
            if (buy_vip == 1) {
                [self.button mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(0);
                }];
            }
        }else{
            VCToast(BCMsg, 2);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        VCToast(@"加载失败", 2);
    }];
    
}
@end
