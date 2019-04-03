//
//  CoinByStagesViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/6.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinByStagesViewController.h"
#import "CoinRepaymentPlanViewController.h"
#import "WOWONoDataView.h"
#import "CoinOrderDetailsViewController.h"
@interface CoinByStagesViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UIImageView *backImageView;//滑
    UIButton *selectedBtn;
}
@property (nonatomic, strong) UIView *headView;//头部标签
@property (nonatomic,strong)UIScrollView * backScrollView;
@property (nonatomic,strong)UITableView * ProceedTableView;
@property (nonatomic,strong)UITableView * finishTableView;
@property (nonatomic,copy)NSArray *ProceedDataArray;
@property (nonatomic,copy)NSArray * finishDataArray;
@property (nonatomic,strong)WOWONoDataView * NoDataView;
@property (nonatomic,strong)WOWONoDataView * NoDataView2;
@end

@implementation CoinByStagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分期记录";
    [self SetNavTitleColor];
    [self SetReturnButton];
    [self.view addSubview:self.headView];
    
    [self.view addSubview:self.backScrollView];
    [self.backScrollView addSubview:self.finishTableView];
    [self.backScrollView addSubview:self.ProceedTableView];
    [self requestFinish];
    [self requestProceed];
    self.NoDataView = [[WOWONoDataView alloc] initWithImageName:@"暂无记录" text:@"暂无分期记录！" detailText:nil buttonTitle:@"去逛逛"];
     [self.view addSubview:self.NoDataView];
    [self.NoDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.ProceedTableView);
    }];
    
    [self.NoDataView.button addTarget:self action:@selector(goShopp) forControlEvents:UIControlEventTouchUpInside];
    
    self.NoDataView2 = [[WOWONoDataView alloc] initWithImageName:@"暂无记录" text:@"暂无分期记录！" detailText:nil buttonTitle:@"去逛逛"];
    [self.finishTableView addSubview:self.NoDataView2];
    [self.NoDataView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.NoDataView);
    }];
   
    [self.NoDataView2.button addTarget:self action:@selector(goShopp) forControlEvents:(UIControlEventTouchUpInside)];
    
    
}

- (void)goShopp{
    self.tabBarController.selectedIndex = 1;
    [self.navigationController popToRootViewControllerAnimated:YES];
 }
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return tableView == self.ProceedTableView ? self.ProceedDataArray.count : self.finishDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     NSArray * titlles = @[@"查看订单详情:",@"分期购服务协议编号:",@"借款金额：",@"服务费：",@"年化利率：",@"借款期限(月)：",@"出账日期：",@"借款截止日期：",@"还款方式：",@"还款账户名称：",@"还款账号：",@"剩余未还本金："];
    return titlles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray * titlles = @[@"查看订单详情:",@"分期购服务协议编号:",@"借款金额：",@"服务费：",@"年化利率：",@"借款期限(月)：",@"出账日期：",@"借款截止日期：",@"还款方式：",@"还款账户名称：",@"还款账号：",@"剩余未还本金："];
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.selectionStyle = 0;
    cell.textLabel.text = titlles[indexPath.row];
    cell.textLabel.textColor = COLOR(102, 102, 102);
    cell.textLabel.font = Regular(13);
    cell.detailTextLabel.textColor = COLOR(102, 102, 102);
    cell.detailTextLabel.font = Regular(13);
    if (indexPath.row == 0 || indexPath.row == 1) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSDictionary * dict = tableView == self.ProceedTableView ? self.ProceedDataArray[indexPath.section] : self.finishDataArray[indexPath.section];
    switch (indexPath.row) {
        case 0:
            cell.detailTextLabel.text = dict[@"goods_name"];
            break;
        case 1:
                  cell.detailTextLabel.text = dict[@"fenqi_agree_num"];
            break;
        case 2:
                  cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%@",dict[@"fenqi_amount"]];
            break;
        case 3:
                  cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%@",dict[@"service_amount"]];
            break;
        case 4:
                  cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",dict[@"percent"]];
            break;
        case 5:
                  cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",dict[@"period"]];
            break;
        case 6:
                  cell.detailTextLabel.text = dict[@"pay_time"];            break;
        case 7:
                  cell.detailTextLabel.text = dict[@"repay_end_time"];
            break;
            
        case 8:
            cell.detailTextLabel.text = dict[@"type"];
            break;
        case 9:
            cell.detailTextLabel.text = dict[@"username"];
            break;
            
        case 10:
            cell.detailTextLabel.text = dict[@"bank_card"];
            break;
        case 11:
            cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%@",dict[@"remaining"]];
            break;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView == self.finishTableView) {
        return 10;
    }
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (tableView == self.finishTableView) {
        UIView * view = [UIView new];
        view.backgroundColor = COLOR(238, 238, 238);
        return view;
    }
    UIView * view = [UIView new];
    UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:@"还款计划列表" forState:(UIControlStateNormal)];
    [view addSubview:btn];
    btn.titleLabel.font = Regular(14);
    [btn setTitleColor:COLOR(255, 0, 0) forState:(UIControlStateNormal)];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    btn.tag = 1000 + section;
    [btn addTarget:self action:@selector(GoCoinRepaymentPlanViewController:) forControlEvents:(UIControlEventTouchUpInside)];
    UIView * LineView = [UIView new];
    LineView.backgroundColor = COLOR(238, 238, 238);
    [view addSubview:LineView];
    [LineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(view);
        make.height.mas_equalTo(10);
    }];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
- (void)GoCoinRepaymentPlanViewController:(UIButton *)btn{
    CoinRepaymentPlanViewController * vc = [CoinRepaymentPlanViewController new];
    vc.order_id = self.ProceedDataArray[btn.tag - 1000][@"order_id"];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark 懒加载加载需要的视图

- (UIScrollView *)backScrollView {
    
    if (!_backScrollView) {
        
        
        _backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40  , BCWidth, BCHeight - 40 )];
        _backScrollView.delegate = self;
        
        _backScrollView.pagingEnabled = YES;
        _backScrollView.bounces = NO;
        _backScrollView.showsVerticalScrollIndicator = NO;
        _backScrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_backScrollView];
        _backScrollView.contentSize = CGSizeMake(BCWidth*5, BCHeight - 130 -BCNaviHeight);
        
        
    }
    
    return _backScrollView;
}




- (UIView *)headView {
    if (!_headView) {
        
        
        
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , BCWidth, 40)];
        
        _headView.backgroundColor = ThemeColor;
        
        
        
        
        
        NSArray *titleArr1 = @[@"还款中",@"已还完"];
        for(int i = 0; i < titleArr1.count; i++) {
            UIButton *segmentButton1 = [[UIButton alloc] init];
            
            segmentButton1.titleLabel.font = Regular(12);
            [segmentButton1 setTitle:titleArr1[i] forState:UIControlStateNormal];
            [segmentButton1 setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
            [segmentButton1 setTitleColor:COLOR(255, 0, 0) forState:UIControlStateSelected];
            
            segmentButton1.tag = 200 + i;
            [segmentButton1 addTarget:self action:@selector(clickTopButton:) forControlEvents:UIControlEventTouchUpInside];
            CGFloat kk = -(BCWidth / 4);
            if (i == 1) {
                kk = BCWidth / 4;
            }
            [_headView addSubview:segmentButton1];
            [segmentButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerX.equalTo(self->_headView).offset(kk);
                make.top.mas_equalTo(0);
                make.width.mas_equalTo(50);
                make.height.mas_equalTo(40);
            }];
            
            if (i == 0) {
                backImageView = [[UIImageView alloc] init];
                backImageView.backgroundColor = COLOR(255, 0, 0);
                [_headView addSubview:backImageView];
                [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.width.equalTo(segmentButton1);
                    make.top.mas_equalTo(37);
                    make.height.mas_equalTo(1);
                    
                }];
                
                segmentButton1.selected = YES;
                selectedBtn = segmentButton1;
            }
            
        }
        
        
    }
    
    return _headView;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if ([scrollView isKindOfClass:[UITableView class]]) {
        return;
    }
    
    //     点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    
    UIButton *btn = [self.headView viewWithTag:200 + index];
    
    [self clickTopButton:btn];
    
}

#pragma mark 点击顶部按钮
- (void)clickTopButton:(UIButton *)btn {
    
    if (btn!= selectedBtn) {
        
        selectedBtn.selected = NO;
        btn.selected = YES;
        selectedBtn = btn;
        
    }else{
        
        selectedBtn.selected = YES;
    }
    
    [self.backScrollView setContentOffset:CGPointMake(BCWidth * (btn.tag - 200), 0) animated:YES];
    [backImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.equalTo(btn);
        make.top.mas_equalTo(37);
        make.height.mas_equalTo(1);
        
    }];
}

- (UITableView *)finishTableView{
    if (_finishTableView == nil) {
        _finishTableView = [[UITableView alloc] initWithFrame:CGRectMake(BCWidth, 0, BCWidth, BCHeight - 40 - BCNaviHeight) style:(UITableViewStyleGrouped)];
        _finishTableView.delegate = self;
        _finishTableView.dataSource = self;
       _finishTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _finishTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self requestFinish];
        }];
    }
    return _finishTableView;
}

- (UITableView *)ProceedTableView{
    if (_ProceedTableView == nil) {
        _ProceedTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BCWidth, BCHeight - 40 - BCNaviHeight) style:(UITableViewStyleGrouped)];
        _ProceedTableView.delegate = self;
        _ProceedTableView.dataSource = self;
         _ProceedTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _ProceedTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self requestProceed];
        }];
    }
    return _ProceedTableView;
}
- (void)requestProceed{
    [KTooL HttpPostWithUrl:@"installments" parameters:@{@"repay_type":@"1"} loadString:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.ProceedTableView.mj_header endRefreshing];
        if (BCStatus) {
            if (!BCArrayIsEmpty(responseObject[@"data"])) {
                self.ProceedDataArray = responseObject[@"data"];
                [self.ProceedTableView reloadData];
                self.NoDataView.hidden = YES;
            }
        }
    
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
          [self.ProceedTableView.mj_header endRefreshing];
    }];

}


- (void)requestFinish{
    [KTooL HttpPostWithUrl:@"installments" parameters:@{@"repay_type":@"2"} loadString:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.finishTableView.mj_header endRefreshing];
        if (BCStatus) {
        if (!BCArrayIsEmpty(responseObject[@"data"])) {
                self.finishDataArray = responseObject[@"data"];
                [self.finishTableView reloadData];
                self.NoDataView2.hidden = YES;
            }
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.finishTableView.mj_header endRefreshing];
    }];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dict;
    if (tableView == self.ProceedTableView) {
        dict = self.ProceedDataArray[indexPath.section];
    }else{
        dict = self.finishDataArray[indexPath.section];
    }
    if (indexPath.row == 0) {
         CoinOrderDetailsViewController * vc = [CoinOrderDetailsViewController new];
        vc.type = BROrderFinsh;
        vc.order_id = dict[@"order_id"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.row == 1) {
        CoinH5ViewController * vc = [CoinH5ViewController new];
        vc.titleStr = @"借款协议";
         vc.url = dict[@"url"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
