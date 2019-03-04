//
//  CoinMyOrderViewController.m
//  弩币商城
//
//  Created by Jack on 2019/3/4.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinMyOrderViewController.h"
#import "CoinMyOrderTableViewCell.h"
#import "CoinOrderSuccessViewController.h"

@interface CoinMyOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UIImageView *backImageView;//滑
    UIButton *selectedBtn;
}
@property (nonatomic, strong) UIView *headView;//头部标签
@property (nonatomic, strong) UIScrollView *backScrollView;

@property (nonatomic, strong) UITableView *allTableView,*notPayTableView,*notDispatchTabview,*notEnableTableView,*finshTableView;

@property (nonatomic, strong) WOWONoDataView *alertdataView;
@end

@implementation CoinMyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      self.navigationItem.title = @"我的订单";
    
    
    
    [self.view addSubview:self.headView];
    
    [self.view addSubview:self.backScrollView];
    
    
    [self.backScrollView addSubview:self.allTableView];
    [self.backScrollView addSubview:self.notPayTableView];
    [self.backScrollView addSubview:self.notDispatchTabview];
    [self.backScrollView addSubview:self.notEnableTableView];
    [self.backScrollView addSubview:self.finshTableView];
    
    
    if (_isNotPay == 1) {
        
     [self.backScrollView   setContentOffset:CGPointMake(BCWidth, 0) animated:NO];
        
       
        
        UIButton *btn = [self.headView viewWithTag:201];
     
        [self clickTopButton:btn];
    }
    
    if (_isNotPay == 3) {
        
        
          [self.backScrollView   setContentOffset:CGPointMake(BCWidth * 3, 0) animated:NO];
        
        
        UIButton *btn = [self.headView viewWithTag:203];
        
        [self clickTopButton:btn];
        
       
    }
    
    
//    if (_alertdataView) {
//        [_alertdataView removeFromSuperview];
//        _alertdataView = nil;
//    }
//    self.alertdataView = [[WOWONoDataView alloc] initWithImageName:@"order" text:@"抱歉未查到数据" detailText:nil buttonTitle:@"去逛逛"];
//    
//    self.alertdataView.frame =self.view.bounds;
//    
//    [self.view addSubview:_alertdataView];
//    
    
    
}



#pragma mark tableview 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.notDispatchTabview) {
        
        return 158;
        
    } else{
    
    return 197;
    
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (tableView == self.allTableView) {
        static NSString *ID = @"kpo";
        CoinMyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (!cell) {
            cell = [[CoinMyOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID andType:0];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
        }
        
        
        
        
        return cell;
        
    } else if (tableView == self.notPayTableView) {
        
        
        static NSString *ID = @"kpo1";
        CoinMyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (!cell) {
            cell = [[CoinMyOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID andType:0];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
        }
        
       
        
        return cell;
        
    } else if (tableView == self.notDispatchTabview ){
        
        
        static NSString *ID = @"kpo2";
        CoinMyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (!cell) {
            cell = [[CoinMyOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID andType:1];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
        }
        
        
        
        
        return cell;
        
    } else if (tableView == self.notEnableTableView){
        
        
        
        static NSString *ID = @"kpo3";
        CoinMyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (!cell) {
            cell = [[CoinMyOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID andType:2];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
        }
        
        [cell.enableBtn addTarget:self action:@selector(clickEnable:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        return cell;
        
        
        
    } else {
        
        
        static NSString *ID = @"kpo4";
        CoinMyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (!cell) {
            cell = [[CoinMyOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID andType:3];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
        }
        
        
        
        
        return cell;
        
    }
   
    
    
}


#pragma mark 确认订单
- (void)clickEnable:(UIButton *)btn {
    
    [self.navigationController pushViewController:[CoinOrderSuccessViewController new] animated:YES];
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
#pragma mark 懒加载加载需要的视图
- (UIView *)headView {
    if (!_headView) {
        
        
        
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , BCWidth, 40)];
        
        _headView.backgroundColor = ThemeColor;
        
        
        
        
        
        NSArray *titleArr1 = @[@"全部订单",@"待付款",@"待发货",@"待收货",@"已完成"];
        for(int i = 0; i < titleArr1.count; i++) {
            UIButton *segmentButton1 = [[UIButton alloc] init];
            
            segmentButton1.titleLabel.font = Regular(12);
            [segmentButton1 setTitle:titleArr1[i] forState:UIControlStateNormal];
            [segmentButton1 setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
             [segmentButton1 setTitleColor:COLOR(255, 0, 0) forState:UIControlStateSelected];
            
            segmentButton1.tag = 200 + i;
            [segmentButton1 addTarget:self action:@selector(clickTopButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [_headView addSubview:segmentButton1];
            [segmentButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(((BCWidth - 250 - 60)/4 + 50) * i + 30);
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
        
        
        
        
        
        
        
        //           滑竿
        
        
        
    }
    
    return _headView;
}


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
- (UITableView *)allTableView {
    
    
    if (!_allTableView) {
        _allTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, BCWidth, BCHeight - 40) style:UITableViewStylePlain];
        _allTableView.delegate = self;
        _allTableView.dataSource = self;
        _allTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _allTableView.backgroundColor = DIVI_COLOR;
        _allTableView.showsVerticalScrollIndicator = NO;
        _allTableView.showsHorizontalScrollIndicator = NO;
    }
    
    
    return _allTableView;
}

- (UITableView *)notPayTableView {
    
    
    if (!_notPayTableView) {
        _notPayTableView = [[UITableView alloc] initWithFrame:CGRectMake(BCWidth,0, BCWidth, BCHeight - 40) style:UITableViewStylePlain];
        _notPayTableView.delegate = self;
        _notPayTableView.dataSource = self;
        _notPayTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
       
        
        _notPayTableView.backgroundColor = DIVI_COLOR;
        _notPayTableView.showsVerticalScrollIndicator = NO;
        _notPayTableView.showsHorizontalScrollIndicator = NO;
    }
    
    
    return _notPayTableView;
}

- (UITableView *)notDispatchTabview {
    
    if (!_notDispatchTabview) {
        
        
        _notDispatchTabview = [[UITableView alloc] initWithFrame:CGRectMake(BCWidth * 2, 0, BCWidth, BCHeight - 40) style:UITableViewStylePlain];
        _notDispatchTabview.delegate = self;
        _notDispatchTabview.dataSource = self;
        _notDispatchTabview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _notDispatchTabview.backgroundColor = DIVI_COLOR;
        
        _notDispatchTabview.showsVerticalScrollIndicator = NO;
        _notDispatchTabview.showsHorizontalScrollIndicator = NO;
    }
    
    return _notDispatchTabview;
}

- (UITableView *)notEnableTableView {
    
    if (!_notEnableTableView) {
        
        
        _notEnableTableView = [[UITableView alloc] initWithFrame:CGRectMake(BCWidth * 3, 0, BCWidth, BCHeight - 40) style:UITableViewStylePlain];
        _notEnableTableView.delegate = self;
        _notEnableTableView.dataSource = self;
        _notEnableTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _notEnableTableView.backgroundColor = DIVI_COLOR;
        
        
        _notEnableTableView.showsVerticalScrollIndicator = NO;
        _notEnableTableView.showsHorizontalScrollIndicator = NO;
    }
    
    return _notEnableTableView;
}

- (UITableView *)finshTableView {
    
    if (!_finshTableView) {
        
        
        _finshTableView = [[UITableView alloc] initWithFrame:CGRectMake(BCWidth * 4, 0, BCWidth, BCHeight - 40) style:UITableViewStylePlain];
        _finshTableView.delegate = self;
        _finshTableView.dataSource = self;
        _finshTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _finshTableView.backgroundColor = DIVI_COLOR;
        
        
        _finshTableView.showsVerticalScrollIndicator = NO;
        _finshTableView.showsHorizontalScrollIndicator = NO;
    }
    
    return _finshTableView;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
    
    //     点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    
    UIButton *btn = [self.headView viewWithTag:200 + index];
    
    [backImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.equalTo(btn);
        make.top.mas_equalTo(37);
        make.height.mas_equalTo(1);
        
    }];
    
}
@end
