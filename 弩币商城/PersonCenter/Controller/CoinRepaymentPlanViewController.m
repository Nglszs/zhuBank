//
//  CoinRepaymentPlanViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/6.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinRepaymentPlanViewController.h"
#import "CoinMemberBuyViewController.h"
#import "CoinRepaymentExplainView.h"
@interface CoinRepaymentPlanViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UIImageView *backImageView;//滑
    UIButton *selectedBtn;
}
@property (nonatomic, strong) UIView *headView;//头部标签
@property (nonatomic,strong)UIScrollView * backScrollView;
@property (nonatomic,strong)UITableView * ProceedTableView;
@property (nonatomic,strong)UITableView * finishTableView;

@property (nonatomic,copy)NSArray *  waitingArray;// 还款中
@property (nonatomic,copy)NSArray *  alreadyArray;// 已还款
@property (nonatomic,strong)WOWONoDataView * NoDataView;
@property (nonatomic,strong)WOWONoDataView * NoDataView2;
@end

@implementation CoinRepaymentPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"还款计划列表";
 
    [self.view addSubview:self.backScrollView];
    [self.backScrollView addSubview:self.finishTableView];
    [self.backScrollView addSubview:self.ProceedTableView];
    [self.view addSubview:self.headView];
    [self setNavitemImage:@"疑问" type:(RightNavItem)];
    
    self.NoDataView = [[WOWONoDataView alloc] initWithImageName:@"暂无记录" text:@"暂无还款计划！" detailText:nil buttonTitle:@"去逛逛"];
    [self.view addSubview:self.NoDataView];
    [self.NoDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.ProceedTableView);
    }];
    
    [self.NoDataView.button addTarget:self action:@selector(goShopp) forControlEvents:UIControlEventTouchUpInside];
    
    self.NoDataView2 = [[WOWONoDataView alloc] initWithImageName:@"暂无记录" text:@"暂无还款计划！" detailText:nil buttonTitle:@"去逛逛"];
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
- (void)RightItemAction{
   CoinRepaymentExplainView * View  = [[CoinRepaymentExplainView alloc] initWithFrame: CGRectMake(0, 0, BCWidth, BCHeight)];
    [[UIApplication sharedApplication].keyWindow addSubview:View];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
      [self request];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return tableView == self.ProceedTableView ? self.waitingArray.count : self.alreadyArray.count; ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return tableView == self.ProceedTableView ? 4 : 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray * titlles = tableView == self.ProceedTableView ? @[@"本期本金：",@"本期应还：",@"最后还款日期：",@"状态："] : @[@"还款日：",@"实际还款时间：",@"应还金额：",@"实还金额：",@"还款方式：",@"流水编号："];
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.selectionStyle = 0;
    cell.textLabel.text = titlles[indexPath.row];
    cell.textLabel.textColor = COLOR(102, 102, 102);
    cell.textLabel.font = Regular(13);
    
    cell.detailTextLabel.textColor = COLOR(102, 102, 102);
    cell.detailTextLabel.font = Regular(13);
    cell.detailTextLabel.text = [self detailTextLabelText:tableView Index:indexPath];
    return cell;
}

- (NSString *)detailTextLabelText:(UITableView *)tableView Index:(NSIndexPath *)index{
    
    if (tableView == self.ProceedTableView) {
        NSDictionary * dict = self.waitingArray[index.section];
        NSString * status = dict[@"status"];
        if ([status intValue] == 1) {
            status = @"正常未还";
        }else if ([status intValue] == 2){
            status = @"逾期未还";
        }else if ([status intValue] == 3){
            status = @"已还";
        }
        switch (index.row) {
            case 0:
                return [NSString stringWithFormat:@"￥%@",dict[@"amount"]];
                break;
             case 1:
                return [NSString stringWithFormat:@"￥%@",dict[@"repay_money"]];
                break;
            case 2:
          return  dict[@"exptime"];
                break;
            case 3:
                return status;
                break;
           
        }
    }
    if (tableView == self.finishTableView) {
        NSDictionary * dict = self.alreadyArray[index.section];
        switch (index.row) {
            case 0:
                return dict[@"exptime"]; // 还款日
                break;
                
            case 1:
                 return dict[@"repay_time"]; // 实际还款日
                break;
            case 2:
                   return [NSString stringWithFormat:@"￥%@",dict[@"repay_money"]];
                break;
            case 3:
                   return [NSString stringWithFormat:@"￥%@",dict[@"repay_money"]];
                break;
                
            case 4:
                return dict[@"pay_name"];// 还款方式
                break;
            case 5:
                return dict[@"repay_order_num"];// 流水编号
                break;
                
        }
    }
    return @"";
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView == self.finishTableView) {
        return 10;
    }
    return 60;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:@"  立即还款  " forState:(UIControlStateNormal)];
    btn.tag = 1000 + section;
    btn.layer.cornerRadius = 5;
    btn.clipsToBounds = YES;
    [view addSubview:btn];
    btn.titleLabel.font = Regular(15);
    btn.backgroundColor = COLOR(227, 47, 33);
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.bottom.equalTo(view).offset(-22);
        make.height.mas_offset(25);
    }];
    [btn addTarget:self action:@selector(GoCoinRepaymentPlanViewController:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIView * LineView = [UIView new];
    LineView.backgroundColor = tableView.backgroundColor;
    [view addSubview:LineView];
    [LineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(view);
        make.height.mas_equalTo(10);
    }];
    if (tableView == self.finishTableView) {
        [btn removeFromSuperview];
    }
    return view;
}
- (void)GoCoinRepaymentPlanViewController:(UIButton *)btn{
    CoinMemberBuyViewController * vc = [CoinMemberBuyViewController new];
    vc.type = BRPayRepayment;
    NSDictionary * dict = self.waitingArray[btn.tag - 1000];
    vc.IdStr = dict[@"id"];
    vc.titleString = dict[@"name"];
    vc.Money = dict[@"repay_money"];
    vc.orderID = dict[@"order_id"];
    vc.DataArray = @[];
    [self.navigationController pushViewController:vc animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 50;
    }
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSDictionary * dict = tableView == self.ProceedTableView ? self.waitingArray[section] : self.alreadyArray[section];
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    UILabel * label = [UILabel new];
    label.text = [NSString stringWithFormat:@"【%@/%@】期",dict[@"period_num"],dict[@"period"]];
    label.textColor = (tableView == self.ProceedTableView ? COLOR(254, 0, 0) : COLOR(255, 169, 73));
    label.font = Regular(14);
    [view addSubview:label];
    int offset = (section == 0 ? 10 : 0);
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(15);
        make.centerY.equalTo(view).offset(offset);
    }];
    if (section == 0) {
        UIView * LineView = [UIView new];
        LineView.backgroundColor = tableView.backgroundColor;
        [view addSubview:LineView];
        [LineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(view);
            make.height.mas_equalTo(10);
        }];
    }
    return view;
}
    
#pragma mark 懒加载加载需要的视图

- (UIScrollView *)backScrollView {
    
    if (!_backScrollView) {
        
        
        _backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40  , BCWidth, BCHeight - 40 )];
        _backScrollView.delegate = self;
        _backScrollView.backgroundColor = COLOR(238, 238, 238);
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
        
        
        
        
        
        NSArray *titleArr1 = @[@"还款中",@"已还款"];
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
        _finishTableView = [[UITableView alloc] initWithFrame:CGRectMake(BCWidth + 10, 0, BCWidth - 20, BCHeight - 40 -  BCNaviHeight) style:(UITableViewStyleGrouped)];
        _finishTableView.delegate = self;
        _finishTableView.dataSource = self;
        _finishTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _finishTableView.backgroundColor = COLOR(238, 238, 238);
    }
    return _finishTableView;
}

- (UITableView *)ProceedTableView{
    if (_ProceedTableView == nil) {
        _ProceedTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, BCWidth - 20, BCHeight - 40 - BCNaviHeight) style:(UITableViewStyleGrouped)];
        _ProceedTableView.delegate = self;
        _ProceedTableView.dataSource = self;
        _ProceedTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _ProceedTableView;
}

- (void)request{
    NSString * url = [NSString stringWithFormat:@"repay-plan/%@",self.order_id];
    [KTooL HttpPostWithUrl:url parameters:@{@"order_id":self.order_id} loadString:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (BCStatus) {
            self.waitingArray = responseObject[@"data"][@"waiting"];
           self.alreadyArray = responseObject[@"data"][@"already"];
            if (!BCArrayIsEmpty(self.waitingArray)) {
                self.NoDataView.hidden = YES;
            }
            
            if (!BCArrayIsEmpty(self.alreadyArray)) {
                self.NoDataView2.hidden = YES;
            }
            
            [self.finishTableView reloadData];
            [self.ProceedTableView reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

@end
