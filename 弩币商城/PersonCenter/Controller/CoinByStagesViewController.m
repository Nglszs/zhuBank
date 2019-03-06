//
//  CoinByStagesViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/6.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinByStagesViewController.h"
#import "CoinRepaymentPlanViewController.h"

@interface CoinByStagesViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UIImageView *backImageView;//滑
    UIButton *selectedBtn;
}
@property (nonatomic, strong) UIView *headView;//头部标签
@property (nonatomic,strong)UIScrollView * backScrollView;
@property (nonatomic,strong)UITableView * ProceedTableView;
@property (nonatomic,strong)UITableView * finishTableView;
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
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
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
    cell.detailTextLabel.text = @"iPhone 8 plus";
    cell.detailTextLabel.textColor = COLOR(102, 102, 102);
    cell.detailTextLabel.font = Regular(13);
    if (indexPath.row == 0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [UIView new];
    UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:@"还款计划列表" forState:(UIControlStateNormal)];
    [view addSubview:btn];
    btn.titleLabel.font = Regular(14);
    [btn setTitleColor:COLOR(255, 0, 0) forState:(UIControlStateNormal)];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    [btn addTarget:self action:@selector(GoCoinRepaymentPlanViewController) forControlEvents:(UIControlEventTouchUpInside)];
    return view;
}
- (void)GoCoinRepaymentPlanViewController{
    CoinRepaymentPlanViewController * vc = [CoinRepaymentPlanViewController new];
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
        _finishTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BCWidth, BCHeight - 40) style:(UITableViewStylePlain)];
        _finishTableView.delegate = self;
        _finishTableView.dataSource = self;
       _finishTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _finishTableView;
}

- (UITableView *)ProceedTableView{
    if (_ProceedTableView == nil) {
        _ProceedTableView = [[UITableView alloc] initWithFrame:CGRectMake(BCWidth, 0, BCWidth, BCHeight - 40) style:(UITableViewStylePlain)];
        _ProceedTableView.delegate = self;
        _ProceedTableView.dataSource = self;
         _ProceedTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _ProceedTableView;
}

@end
