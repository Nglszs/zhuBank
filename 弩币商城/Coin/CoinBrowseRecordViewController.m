//
//  CoinBrowseRecordViewController.m
//  弩币商城
//
//  Created by Jack on 2019/3/5.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinBrowseRecordViewController.h"
#import "CoinBrowseStatusViewController.h"
#import "CoinBrowseRecordTableViewCell.h"
#import "CoinReturnBrowseViewController.h"
#import "CoinNotBrowseTableViewCell.h"

@interface CoinBrowseRecordViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    UIImageView *backImageView;//滑竿
    UIButton *selectedBtn;
    NSMutableArray *notArr,*haveArr;
    NSInteger notF,haveF;
}
@property (nonatomic, strong) UIView *headView;//头部标签

@property (nonatomic, strong) UIScrollView *backScrollView;


@property (nonatomic, strong) UITableView *payTableView,*notPayTableView;//
@end

@implementation CoinBrowseRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"借款记录";
    
    notArr = [NSMutableArray arrayWithCapacity:1];
    haveArr = [NSMutableArray arrayWithCapacity:1];
    
    [self.view addSubview:self.headView];
    [self.view addSubview:self.backScrollView];
    
   
    [self.backScrollView addSubview:self.notPayTableView];
    [self.backScrollView addSubview:self.payTableView];
    
    
    [self getData:@"1" andPage:1];
    [self getData:@"2" andPage:1];
}
#pragma mark 网络请求
- (void)getData:(NSString *)type andPage:(NSInteger)page {

    [KTooL HttpPostWithUrl:@"CashLoan/loan_list" parameters:@{@"type":type,@"p":@(page)} loadString:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSLog(@"===%@",responseObject);
        
        
        if (BCStatus) {
            
            
            if ([type isEqualToString:@"1"]) {//还款中
                 [self.notPayTableView.mj_footer endRefreshing];
           
                NSArray *dataArr = [responseObject objectForKey:@"data"];
                if (dataArr.count <= 10) {
                    
                    [self.notPayTableView.mj_footer endRefreshingWithNoMoreData];
                }
                [notArr addObjectsFromArray:dataArr];
                
                if (notArr.count <= 0) {
                    
                    WOWONoDataView *view = [[WOWONoDataView alloc] initWithImageName:@"order" text:@"您还没有借款记录~" detailText:nil buttonTitle:nil];
                            [self.notPayTableView addSubview:view];
                   self.notPayTableView.mj_footer.hidden = YES;;
                    return ;
                }
                [self.notPayTableView reloadData];
            
            } else {//已还完
                [self.payTableView.mj_footer endRefreshing];
                NSArray *dataArr = [responseObject objectForKey:@"data"];
                
                
                if (dataArr.count <= 10) {
                    
                    [self.payTableView.mj_footer endRefreshingWithNoMoreData];
                }
                [haveArr addObjectsFromArray:dataArr];
                
                
                if (haveArr.count <= 0) {
                    
                    WOWONoDataView *view = [[WOWONoDataView alloc] initWithImageName:@"order" text:@"您还没有还款记录~" detailText:nil buttonTitle:nil];
                    [self.payTableView addSubview:view];
                    self.payTableView.mj_footer.hidden = YES;
                    return ;
                }
                [self.payTableView reloadData];
                
                
            }
            
            
            
        } else {
            
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
          [self.payTableView.mj_footer endRefreshingWithNoMoreData];
        [self.payTableView.mj_header endRefreshing];
    }];

}

#pragma mark tableview 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.notPayTableView) {
        
        return notArr.count;
    } else {
        
        return haveArr.count;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (tableView == self.notPayTableView) {
        
        return 480;
    } else {
        
       return 395;
    }
   
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.notPayTableView) {
        
        static NSString *ID = @"kpo";
        CoinNotBrowseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (!cell) {
            cell = [[CoinNotBrowseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
        }
        NSDictionary *dic = [notArr objectAtIndexCheck:indexPath.row];
        [cell setValueData:dic];
        
        [cell.segLabel addTapGestureWithBlock:^{
            CoinBrowseStatusViewController *VC = [[CoinBrowseStatusViewController alloc] init];
            VC.ID = [dic objectForKey:@"id"];
            [self.navigationController pushViewController:VC animated:YES];
        }];
        [cell.segLabel1 addTapGestureWithBlock:^{
            CoinReturnBrowseViewController *VC =[CoinReturnBrowseViewController new];
            VC.ID = [dic objectForKey:@"id"];
                    [self.navigationController pushViewController:VC animated:YES];
        }];
        
        
        return cell;
    } else {
        
        static NSString *ID = @"kpo3";
        CoinBrowseRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (!cell) {
            cell = [[CoinBrowseRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
        }
        
        
        NSDictionary *dic = [haveArr objectAtIndexCheck:indexPath.row];
        [cell setValueData:dic];
        
        [cell.segLabel addTapGestureWithBlock:^{
            CoinBrowseStatusViewController *VC = [[CoinBrowseStatusViewController alloc] init];
            VC.ID = [dic objectForKey:@"id"];
            [self.navigationController pushViewController:VC animated:YES];
            
        }];
        
        
        return cell;
    }
   
    
   
    
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
        make.top.mas_equalTo(39);
        make.height.mas_equalTo(1);
        
    }];
}
#pragma mark 懒加载加载需要的视图
- (UIView *)headView {
    if (!_headView) {
        
        
        
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , BCWidth, 40)];
        
        _headView.backgroundColor = ThemeColor;
        
        
        
        
        
        NSArray *titleArr1 = @[@"还款中",@"已还完"];
        for(int i = 0; i < titleArr1.count; i++) {
            UIButton *segmentButton1 = [[UIButton alloc] init];
            
            segmentButton1.titleLabel.font = Regular(15);
            [segmentButton1 setTitle:titleArr1[i] forState:UIControlStateNormal];
            [segmentButton1 setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
            
            [segmentButton1 setTitleColor:COLOR(255, 18, 0) forState:UIControlStateSelected];
            segmentButton1.tag = 200 + i;
            [segmentButton1 addTarget:self action:@selector(clickTopButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [_headView addSubview:segmentButton1];
            [segmentButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo((BCWidth - 100 - 180 + 50) * i + 90);
                make.top.mas_equalTo(0);
                make.width.mas_equalTo(50);
                make.height.mas_equalTo(40);
            }];
            
            if (i == 0) {
                backImageView = [[UIImageView alloc] init];
                backImageView.backgroundColor = COLOR(255, 18, 0);
                [_headView addSubview:backImageView];
                [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.width.equalTo(segmentButton1);
                    make.top.mas_equalTo(39);
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
        _backScrollView.backgroundColor = DIVI_COLOR;
        _backScrollView.pagingEnabled = YES;
        _backScrollView.bounces = NO;
        _backScrollView.showsVerticalScrollIndicator = NO;
        _backScrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_backScrollView];
        _backScrollView.contentSize = CGSizeMake(BCWidth*2, BCHeight - 130 -BCNaviHeight);
        
        
    }
    
    return _backScrollView;
}

- (UITableView *)notPayTableView {
    
    
    if (!_notPayTableView) {
        _notPayTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, BCWidth, BCHeight  - BCNaviHeight) style:UITableViewStylePlain];
        _notPayTableView.delegate = self;
        _notPayTableView.dataSource = self;
        _notPayTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
        _notPayTableView.backgroundColor = DIVI_COLOR;
        _notPayTableView.showsVerticalScrollIndicator = NO;
        _notPayTableView.showsHorizontalScrollIndicator = NO;
        
        _notPayTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            
            
            notF++;
            [self getData:@"1"andPage:notF];
            
        }];
    }
    
    
    return _notPayTableView;
}
- (UITableView *)payTableView {
    
    
    if (!_payTableView) {
        _payTableView = [[UITableView alloc] initWithFrame:CGRectMake(BCWidth,0, BCWidth, BCHeight - 40 - BCNaviHeight) style:UITableViewStylePlain];
        _payTableView.delegate = self;
        _payTableView.dataSource = self;
        _payTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _payTableView.backgroundColor = DIVI_COLOR;
        
        
        _payTableView.showsVerticalScrollIndicator = NO;
        _payTableView.showsHorizontalScrollIndicator = NO;
        
        _payTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            
            
            haveF++;
            [self getData:@"2"andPage:haveF];
            
        }];
    }
    
    
    return _payTableView;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
    if (scrollView == self.backScrollView) {
        //     点击按钮
        NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
        
        
        UIButton *btn = [self.headView viewWithTag:200 + index];
        
        [self clickTopButton:btn];
    }
    
    
    
}
@end
