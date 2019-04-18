//
//  CoinMyCouponViewController.m
//  弩币商城
//
//  Created by Jack on 2019/3/1.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinMyCouponViewController.h"
#import "CoinMyCouponTableViewCell.h"
#import "CoinExpressCouponTableViewCell.h"
#import "CoinCouponHistoryViewController.h"
#import "CoinCouponCanViewController.h"
#import "CoinClassfyViewController.h"

@interface CoinMyCouponViewController ()<UITableViewDelegate,UITableViewDataSource,ViewCellHeightDelegate>
{
     UIImageView *backImageView;//滑竿
    UIButton *newBtn,*newBtn1;
     UIButton *selectedBtn;
    NSDictionary *dataDic;
    NSMutableArray *dataArr,*secondArr,*thirdArr,*newDataArr,*newSecondArr,*newThirdArr;
    
}
@property (nonatomic, strong) UIView *headView;//头部标签

@property (nonatomic, strong) UIScrollView *backScrollView;

@property (nonatomic, strong) UITableView *getTableView;

@property (nonatomic, strong) UITableView *playTableView;
@property (nonatomic, strong) UITableView *payTableView;//

@property (nonatomic, strong) WOWONoDataView *alertdataView;
@end

@implementation CoinMyCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.headView];
    
    dataArr = [NSMutableArray arrayWithCapacity:1];
    secondArr = [NSMutableArray arrayWithCapacity:1];
    thirdArr = [NSMutableArray arrayWithCapacity:1];
    
    newDataArr = [NSMutableArray arrayWithCapacity:1];
      newSecondArr = [NSMutableArray arrayWithCapacity:1];
      newThirdArr = [NSMutableArray arrayWithCapacity:1];
    
     self.navigationItem.title = @"优惠券";
    
    [self setCustomRightBar:@"优惠券历史记录" click:^{
        
        [self.navigationController pushViewController:[CoinCouponHistoryViewController new] animated:YES];
    }];
    
     [self.view addSubview:self.backScrollView];
    
    
    [self.backScrollView addSubview:self.getTableView];
    [self.backScrollView addSubview:self.payTableView];
  
    [self.backScrollView addSubview:self.playTableView];
    
      [self getData:@"1"];
      [self getData:@"2"];
      [self getData:@"3"];
    
}


#pragma mark 网络请求
- (void)getData:(NSString *)type {
    
    [newDataArr removeAllObjects];
    [dataArr removeAllObjects];
    [secondArr removeAllObjects];
    [thirdArr removeAllObjects];
    
    [KTooL HttpPostWithUrl:@"UserCenter/my_coupons" parameters:@{@"type":type} loadString:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSLog(@"===%@",responseObject);
        
        
        if (BCStatus) {
            
            
            
            
            dataDic = [responseObject objectNilForKey:@"data"];
            
            NSArray *arr =[dataDic objectForKey:@"coupons_list"];
            
           
           
            UIButton *btn = [self.headView viewWithTag:200];
             UIButton *btn1 = [self.headView viewWithTag:201];
             UIButton *btn2 = [self.headView viewWithTag:202];
            
            [btn setTitle:[NSString stringWithFormat:@"全部(%@)",[dataDic objectForKey:@"all_coupons"]] forState:UIControlStateNormal];
             [btn1 setTitle:[NSString stringWithFormat:@"现金抵用券(%@)",[dataDic objectForKey:@"cash_coupons"]] forState:UIControlStateNormal];
             [btn2 setTitle:[NSString stringWithFormat:@"运费抵用券(%@)",[dataDic objectForKey:@"freight_coupons"]] forState:UIControlStateNormal];
            
            
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
                
            } else if ([type isEqualToString:@"2"]) {
                 [secondArr addObjectsFromArray:arr];
                for (int i = 0; i < secondArr.count; i ++) {
                    [newSecondArr addObject:@"0"];
                }
                [self.payTableView reloadData];
            } else {
                 [thirdArr addObjectsFromArray:arr];
                for (int i = 0; i < thirdArr.count; i ++) {
                    [newThirdArr addObject:@"0"];
                }
                [self.playTableView reloadData];
            }
        
        
            
        } else {
            
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark tableview 代理


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.getTableView) {
        return dataArr.count;
    } else if (tableView == self.payTableView){
        
        
        return secondArr.count;
    } else {
        
        return thirdArr.count;
    }
    
}



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
            
            if ([[newDataArr objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
                return 115;
            } else {
                NSDictionary *dic = [dataArr objectAtIndex:indexPath.row];
                
                return [CoinExpressCouponTableViewCell getCellHeight:dic];
                
            }
        }
        
        
    }else if (tableView == self.payTableView){//优惠券
        if ([[newSecondArr objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
            return 115;
        } else {
            NSDictionary *dic = [secondArr objectAtIndex:indexPath.row];
            
            return [CoinMyCouponTableViewCell getCellHeight:dic];
            
        }
        
    }else {
        
        
        if ([[newThirdArr objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
            return 115;
        } else {
            NSDictionary *dic = [thirdArr objectAtIndex:indexPath.row];
            
            return [CoinExpressCouponTableViewCell getCellHeight:dic];
            
        }
        
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (tableView == self.getTableView) {//所有
        
        NSInteger type = [[[dataArr objectAtIndex:indexPath.row] objectForKey:@"coupons_type"] integerValue];
        if (type == 0) {//现金券
            static NSString *ID = @"kpo3";
            CoinMyCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
            if (!cell) {
                cell = [[CoinMyCouponTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                
            }
            
            NSDictionary *dic = [dataArr objectAtIndex:indexPath.row];
            [cell.activityBtn addtargetBlock:^(UIButton *button) {
                CoinCouponCanViewController *vc = [[CoinCouponCanViewController alloc] init];
                vc.ID = [[[dataArr objectAtIndex:indexPath.row] objectForKey:@"cid"] stringValue];
                [self.navigationController pushViewController:vc animated:YES];
            }];
            [cell setDataForCell:dic];
            
            if ([[newDataArr objectAtIndex:indexPath.row] boolValue]) {
                cell.detailV.hidden = NO;
            } else {
                cell.detailV.hidden = YES;
            }
            
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
            
            
            static NSString *ID = @"kpo3177";
            CoinExpressCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
            if (!cell) {
                cell = [[CoinExpressCouponTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                
            }
            NSDictionary *dic = [dataArr objectAtIndex:indexPath.row];
            [cell.activityBtn addtargetBlock:^(UIButton *button) {

                
                CoinClassfyViewController *rentVC = [[CoinClassfyViewController alloc] init];
                [self.navigationController pushViewController:rentVC animated:YES];
            }];
            [cell setDataForCell:dic];
            
            if ([[newDataArr objectAtIndex:indexPath.row] boolValue]) {
                cell.detailV.hidden = NO;
            } else {
                cell.detailV.hidden = YES;
            }
            
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
        }
    } else if (tableView == self.payTableView){//优惠券
        static NSString *ID = @"kpo2888";
        CoinMyCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (!cell) {
            cell = [[CoinMyCouponTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
        }
        
        
        NSDictionary *dic = [secondArr objectAtIndex:indexPath.row];
       
        [cell.activityBtn addtargetBlock:^(UIButton *button) {
            CoinCouponCanViewController *vc = [[CoinCouponCanViewController alloc] init];
            vc.ID = [[[secondArr objectAtIndex:indexPath.row] objectForKey:@"cid"] stringValue];
            [self.navigationController pushViewController:vc animated:YES];
        }];

        
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
        
    } else {//运费
        
        static NSString *ID = @"kpo1";
        CoinExpressCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (!cell) {
            cell = [[CoinExpressCouponTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
        }
        
        
        NSDictionary *dic = [thirdArr objectAtIndex:indexPath.row];
        [cell.activityBtn addtargetBlock:^(UIButton *button) {
            CoinClassfyViewController *rentVC = [[CoinClassfyViewController alloc] init];
            [self.navigationController pushViewController:rentVC animated:YES];
        }];
        [cell setDataForCell:dic];
        
        
        
        if ([[newThirdArr objectAtIndex:indexPath.row] boolValue]) {
            cell.detailV.hidden = NO;
        } else {
            cell.detailV.hidden = YES;
        }
        
        [cell.detailBtn addtargetBlock:^(UIButton *button) {
            
            button.selected = !button.selected;
            if (button.selected) {
                
                [newThirdArr replaceObjectAtIndex:indexPath.row withObject:@"1"];
                cell.detailV.hidden = NO;
                
            } else {
                
                [newThirdArr replaceObjectAtIndex:indexPath.row withObject:@"0"];
                cell.detailV.hidden = YES;
            }
            
            [self.playTableView reloadData];
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
        make.height.mas_equalTo(3);
        
    }];
}
#pragma mark 懒加载加载需要的视图
- (UIView *)headView {
    if (!_headView) {
        
       
        
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , BCWidth, 40)];
        
        _headView.backgroundColor = ThemeColor;
        

       
        
        
        NSArray *titleArr1 = @[@"全部(11)",@"现金抵用券(2)",@"运费抵用券(1)"];
        
        for(int i = 0; i < titleArr1.count; i++) {
            UIButton *segmentButton1 = [[UIButton alloc] init];
           
            segmentButton1.titleLabel.font = Regular(15);
            [segmentButton1 setTitle:titleArr1[i] forState:UIControlStateNormal];
              [segmentButton1 setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
            [segmentButton1 setTitleColor:COLOR(252, 148, 37) forState:UIControlStateSelected];
            
            
            segmentButton1.tag = 200 + i;
            
           
           
            [segmentButton1 addTarget:self action:@selector(clickTopButton:) forControlEvents:UIControlEventTouchUpInside];
            
            if (i == 0) {
                newBtn = segmentButton1;
            } else if(i== 1) {
                
                newBtn1 = segmentButton1;
            }
        
            
            [_headView addSubview:segmentButton1];
            [segmentButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
               
                if (i == 0) {
                    make.left.mas_equalTo(LEFT_Margin);
                    segmentButton1.selected = YES;
                    selectedBtn = segmentButton1;
                } else if (i == 1) {
                    
                    make.left.equalTo(newBtn.mas_right).offset(30);
                } else {
                    make.left.equalTo(newBtn1.mas_right).offset(30);
                    
                }
                
                
               
                make.top.mas_equalTo(0);
                make.height.mas_equalTo(40);
            }];
            
            
           
           
        }
        
        
        
        
        
       
        
        //           滑竿
        
        backImageView = [[UIImageView alloc] init];
        backImageView.backgroundColor = COLOR(252, 148, 37);
        [_headView addSubview:backImageView];
        [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.width.equalTo(newBtn);
            make.top.mas_equalTo(39);
            make.height.mas_equalTo(3);
            
        }];
        
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
        _backScrollView.contentSize = CGSizeMake(BCWidth*3, BCHeight - 130 -BCNaviHeight);

       
    }

    return _backScrollView;
}

- (UITableView *)getTableView {
    
    
    if (!_getTableView) {
        _getTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BCWidth, BCHeight - 40 - BCNaviHeight - 15) style:UITableViewStylePlain];
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
        _payTableView = [[UITableView alloc] initWithFrame:CGRectMake(BCWidth,0, BCWidth, BCHeight - 40 - BCNaviHeight- 15) style:UITableViewStylePlain];
        _payTableView.delegate = self;
        _payTableView.dataSource = self;
        _payTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _payTableView.backgroundColor = ThemeColor;
        
        
        _payTableView.showsVerticalScrollIndicator = NO;
        _payTableView.showsHorizontalScrollIndicator = NO;
    }
    
    
    return _payTableView;
}


- (UITableView *)playTableView {
    
    if (!_playTableView) {
        
        
        _playTableView = [[UITableView alloc] initWithFrame:CGRectMake(BCWidth * 2, 0, BCWidth, BCHeight - 40 - BCNaviHeight - 15) style:UITableViewStylePlain];
        _playTableView.delegate = self;
        _playTableView.dataSource = self;
        _playTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _playTableView.backgroundColor = ThemeColor;
        
        
        _playTableView.showsVerticalScrollIndicator = NO;
        _playTableView.showsHorizontalScrollIndicator = NO;
    }
    
    return _playTableView;
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (self.backScrollView == scrollView) {
        //     点击按钮
        NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
        
        
        UIButton *btn = [self.headView viewWithTag:200 + index];
        
        [self clickTopButton:btn];
    }
    

}
@end
