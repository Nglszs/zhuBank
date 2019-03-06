//
//  CoinRepaymentPlanViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/6.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinRepaymentPlanViewController.h"
#import "CoinMemberBuyViewController.h"
@interface CoinRepaymentPlanViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UIImageView *backImageView;//滑
    UIButton *selectedBtn;
}
@property (nonatomic, strong) UIView *headView;//头部标签
@property (nonatomic,strong)UIScrollView * backScrollView;
@property (nonatomic,strong)UITableView * ProceedTableView;
@property (nonatomic,strong)UITableView * finishTableView;

@end

@implementation CoinRepaymentPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"还款计划列表";
    [self SetNavTitleColor];
    [self SetReturnButton];
    [self.view addSubview:self.backScrollView];
    [self.backScrollView addSubview:self.finishTableView];
    [self.backScrollView addSubview:self.ProceedTableView];
    [self.view addSubview:self.headView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * titlles = @[@"本期本金：",@"服务费：",@"本期应还：",@"最后还款日期：",@"状态："];
    return titlles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray * titlles = @[@"本期本金：",@"服务费：",@"本期应还：",@"最后还款日期：",@"状态："];
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.selectionStyle = 0;
    cell.textLabel.text = titlles[indexPath.row];
    cell.textLabel.textColor = COLOR(102, 102, 102);
    cell.textLabel.font = Regular(13);
    cell.detailTextLabel.text = @"iPhone 8 plus";
    cell.detailTextLabel.textColor = COLOR(102, 102, 102);
    cell.detailTextLabel.font = Regular(13);
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView == self.ProceedTableView) {
        return 10;
    }
    return 60;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:@"  还立即还款  " forState:(UIControlStateNormal)];
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
    [btn addTarget:self action:@selector(GoCoinRepaymentPlanViewController) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIView * LineView = [UIView new];
    LineView.backgroundColor = tableView.backgroundColor;
    [view addSubview:LineView];
    [LineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(view);
        make.height.mas_equalTo(10);
    }];
    if (tableView == self.ProceedTableView) {
        [btn removeFromSuperview];
    }
    return view;
}
- (void)GoCoinRepaymentPlanViewController{
    CoinMemberBuyViewController * vc = [CoinMemberBuyViewController new];
    vc.type = BRPayRepayment;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 50;
    }
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    UILabel * label = [UILabel new];
    label.text = @"【1/6】期";
    label.textColor = (tableView == self.finishTableView ? COLOR(254, 0, 0) : COLOR(255, 169, 73));
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
        _finishTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, BCWidth - 20, BCHeight - 40 -  BCNaviHeight) style:(UITableViewStyleGrouped)];
        _finishTableView.delegate = self;
        _finishTableView.dataSource = self;
        _finishTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _finishTableView.backgroundColor = COLOR(238, 238, 238);
    }
    return _finishTableView;
}

- (UITableView *)ProceedTableView{
    if (_ProceedTableView == nil) {
        _ProceedTableView = [[UITableView alloc] initWithFrame:CGRectMake(BCWidth, 0, BCWidth, BCHeight - 40) style:(UITableViewStyleGrouped)];
        _ProceedTableView.delegate = self;
        _ProceedTableView.dataSource = self;
        _ProceedTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _ProceedTableView;
}


@end
