//
//  CoinCouponHistoryViewController.m
//  弩币商城
//
//  Created by Jack on 2019/3/1.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinCouponHistoryViewController.h"
#import "CoinMyCouponTableViewCell.h"
#import "CoinExpressCouponTableViewCell.h"


@interface CoinCouponHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    UIImageView *backImageView;//滑竿
     UIButton *selectedBtn;
     NSMutableArray *dataArr,*secondArr,*thirdArr,*newDataArr,*newSecondArr;
    NSDictionary *dataDic;
    
    
}
@property (nonatomic, strong) UIView *headView;//头部标签

@property (nonatomic, strong) UIScrollView *backScrollView;

@property (nonatomic, strong) UITableView *getTableView;

@property (nonatomic, strong) UITableView *payTableView;//
@property (nonatomic, strong) WOWONoDataView *alertdataView;
@end

@implementation CoinCouponHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    dataArr = [NSMutableArray arrayWithCapacity:1];
    secondArr = [NSMutableArray arrayWithCapacity:1];
   
    newSecondArr = [NSMutableArray arrayWithCapacity:1];
    newDataArr = [NSMutableArray arrayWithCapacity:1];
    self.navigationItem.title = @"优惠券历史记录";
     [self.view addSubview:self.headView];
    [self.view addSubview:self.backScrollView];
    
    
    [self.backScrollView addSubview:self.getTableView];
    [self.backScrollView addSubview:self.payTableView];
    
    
    [self getData:@"1"];
    [self getData:@"2"];
}



#pragma mark 网络请求
- (void)getData:(NSString *)type {
    
    
    [dataArr removeAllObjects];
    [secondArr removeAllObjects];
   
    
    [KTooL HttpPostWithUrl:@"UserCenter/history_coupons" parameters:@{@"type":type} loadString:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSLog(@"===%@",responseObject);
        
        
        if (BCStatus) {
            
            
            
            
            dataDic = [responseObject objectNilForKey:@"data"];
            
            NSArray *arr =[dataDic objectForKey:@"coupons_list"];
            
            
            
           
            
            if (arr.count <= 0) {
                if (_alertdataView) {
                    [_alertdataView removeFromSuperview];
                    _alertdataView = nil;
                }
                self.alertdataView = [[WOWONoDataView alloc] initWithImageName:@"myyhq 拷贝" text:@"您还没有优惠券哦~" detailText:nil buttonTitle:nil];
                
                self.alertdataView.frame =self.view.bounds;
                
                [self.view addSubview:_alertdataView];
                
                return ;
            }
            
            //           刷新数据
            if ([type isEqualToString:@"1"]) {
                [dataArr addObjectsFromArray:arr];
                
                for (int i = 0; i < dataArr.count; i ++) {
                    [newDataArr addObject:@"0"];
                }
                [self.getTableView reloadData];
                
            } else {
                [secondArr addObjectsFromArray:arr];
                for (int i = 0; i < secondArr.count; i ++) {
                    [newSecondArr addObject:@"0"];
                }
                [self.payTableView reloadData];
            }
            
            
            
        } else {
            
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark tableview 代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.getTableView) {//所有
        
        NSInteger type = [[[dataArr objectAtIndex:indexPath.row] objectForKey:@"coupons_type"] integerValue];
        
        if (type == 0) {//现金券
            
            if ([[newDataArr objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
                return 115;
            } else {
                NSDictionary *dic = [dataArr objectAtIndex:indexPath.row];
                
                return [CoinMyCouponTableViewCell getCellHeight:dic];
                
            }
            
        } else {
            
            return 115;
        }
        
        
    } else {
        
        if ([[newSecondArr objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
            return 115;
        } else {
            NSDictionary *dic = [secondArr objectAtIndex:indexPath.row];
            
            return [CoinMyCouponTableViewCell getCellHeight:dic];
            
        }
        
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.getTableView) {
        return dataArr.count;
    } else {
        
        
        return secondArr.count;
    } 
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (tableView == self.getTableView) {//已使用
        NSInteger type = [[[dataArr objectAtIndexCheck:indexPath.row] objectForKey:@"coupons_type"] integerValue];
        if (type == 0) {//满减券
            static NSString *ID = @"kpo3";
            CoinMyCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
            if (!cell) {
                cell = [[CoinMyCouponTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                
            }
            
            NSDictionary *dic = [dataArr objectAtIndex:indexPath.row];
            cell.type = 1;
            [cell setDataForCell:dic];
            [cell.detailBtn addtargetBlock:^(UIButton *button) {
                
                button.selected = !button.selected;
                if (button.selected) {
                    
                    [newDataArr replaceObjectAtIndex:indexPath.row withObject:@"1"];
                    cell.detailV.hidden = NO;
                    
                } else {
                    
                    [newDataArr replaceObjectAtIndex:indexPath.row withObject:@"0"];
                    cell.detailV.hidden = YES;
                }
                
                [self.getTableView reloadData];
            }];
            
            
            return cell;
        } else {
            
            
            static NSString *ID = @"kpo31";
            CoinExpressCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
            if (!cell) {
                cell = [[CoinExpressCouponTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                
            }
            NSDictionary *dic = [dataArr objectAtIndex:indexPath.row];
            cell.type = 1;
            [cell setDataForCell:dic];
            return cell;
        }
    } else {//已过期
        NSInteger type = [[[dataArr objectAtIndexCheck:indexPath.row] objectForKey:@"coupons_type"] integerValue];
        if (type == 0) {//现金券
            static NSString *ID = @"kpo32";
            CoinMyCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
            if (!cell) {
                cell = [[CoinMyCouponTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                
            }
            
            NSDictionary *dic = [secondArr objectAtIndex:indexPath.row];
            cell.type =2;
            [cell setDataForCell:dic];
            if ([[newSecondArr objectAtIndex:indexPath.row] boolValue]) {
                cell.detailV.hidden = NO;
            } else {
                cell.detailV.hidden = YES;
            }
            
            [cell.detailBtn addtargetBlock:^(UIButton *button) {
                
                button.selected = !button.selected;
                if (button.selected) {
                    
                    [newSecondArr replaceObjectAtIndex:indexPath.row withObject:@"1"];
                    cell.detailV.hidden = NO;
                    
                } else {
                    
                    [newSecondArr replaceObjectAtIndex:indexPath.row withObject:@"0"];
                    cell.detailV.hidden = YES;
                }
                
                [self.payTableView reloadData];
            }];
            return cell;
        } else {
            
            
            static NSString *ID = @"kpo33";
            CoinExpressCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
            if (!cell) {
                cell = [[CoinExpressCouponTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                
            }
            NSDictionary *dic = [secondArr objectAtIndex:indexPath.row];
            cell.type = 2;
            [cell setDataForCell:dic];
            return cell;
        }
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
        make.height.mas_equalTo(3);
        
    }];
}
#pragma mark 懒加载加载需要的视图
- (UIView *)headView {
    if (!_headView) {
        
        
        
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , BCWidth, 40)];
        
        _headView.backgroundColor = ThemeColor;
        
        
        
        
        
        NSArray *titleArr1 = @[@"已使用",@"已过期"];
        for(int i = 0; i < titleArr1.count; i++) {
            UIButton *segmentButton1 = [[UIButton alloc] init];
            
            segmentButton1.titleLabel.font = Regular(15);
            [segmentButton1 setTitle:titleArr1[i] forState:UIControlStateNormal];
              [segmentButton1 setTitleColor:COLOR(153, 153, 153) forState:UIControlStateNormal];
            [segmentButton1 setTitleColor:COLOR(252, 148, 37) forState:UIControlStateSelected];
            
            
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
                backImageView.backgroundColor = COLOR(252, 148, 37);
                [_headView addSubview:backImageView];
                [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.width.equalTo(segmentButton1);
                    make.top.mas_equalTo(39);
                    make.height.mas_equalTo(3);
                    
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
        _backScrollView.backgroundColor = [UIColor clearColor];
        _backScrollView.pagingEnabled = YES;
        _backScrollView.bounces = NO;
        _backScrollView.showsVerticalScrollIndicator = NO;
        _backScrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_backScrollView];
        _backScrollView.contentSize = CGSizeMake(BCWidth*2, BCHeight - 130 -BCNaviHeight);
        
        
    }
    
    return _backScrollView;
}

- (UITableView *)getTableView {
    
    
    if (!_getTableView) {
        _getTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BCWidth, BCHeight - 40 ) style:UITableViewStylePlain];
        _getTableView.delegate = self;
        _getTableView.dataSource = self;
        _getTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _getTableView.backgroundColor = ThemeColor;
        
        
        _getTableView.showsVerticalScrollIndicator = NO;
        _getTableView.showsHorizontalScrollIndicator = NO;
    }
    
    
    return _getTableView;
}



- (UITableView *)payTableView {
    
    
    if (!_payTableView) {
        _payTableView = [[UITableView alloc] initWithFrame:CGRectMake(BCWidth,0, BCWidth, BCHeight - 40) style:UITableViewStylePlain];
        _payTableView.delegate = self;
        _payTableView.dataSource = self;
        _payTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _payTableView.backgroundColor = ThemeColor;
        
        
        _payTableView.showsVerticalScrollIndicator = NO;
        _payTableView.showsHorizontalScrollIndicator = NO;
    }
    
    
    return _payTableView;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
    
    //     点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    
    UIButton *btn = [self.headView viewWithTag:200 + index];
    
    [self clickTopButton:btn];
    
}
@end
