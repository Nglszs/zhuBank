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
#import "CoinOrderDetailsViewController.h"
#import "CoinOrderAllMoneyViewController.h"
#import "CoinPayMoneyOrderViewController.h"
#import "CoinLogisticsViewController.h"

@interface CoinMyOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UIImageView *backImageView;//滑
    UIButton *selectedBtn;
    NSMutableArray *allArr,*notArr,*aleratArr,*notEnableArr,*finshArr;
    NSInteger allF,notF,aleartF,notEnableF,finishF;
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
    
    allArr = [NSMutableArray arrayWithCapacity:1];
    notArr = [NSMutableArray arrayWithCapacity:1];
    aleratArr = [NSMutableArray arrayWithCapacity:1];
    notEnableArr = [NSMutableArray arrayWithCapacity:1];
    finshArr = [NSMutableArray arrayWithCapacity:1];
    
    
    [self.view addSubview:self.headView];
    
    [self.view addSubview:self.backScrollView];
    
    
    [self.backScrollView addSubview:self.allTableView];
    [self.backScrollView addSubview:self.notPayTableView];
    [self.backScrollView addSubview:self.notDispatchTabview];
    [self.backScrollView addSubview:self.notEnableTableView];
    [self.backScrollView addSubview:self.finshTableView];
    
     [self getData:@""andPage:1];
     [self getData:@"WAITPAY"andPage:1];
     [self getData:@"WAITSEND"andPage:1];
     [self getData:@"WAITRECEIVE"andPage:1];
     [self getData:@"FINISH"andPage:1];
    
    
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
    
    
    
}

#pragma mark 网络请求
- (void)getData:(NSString *)type andPage:(NSInteger)page {
    
    [KTooL HttpPostWithUrl:@"Order/my_order" parameters:@{@"user_id":[USER_DEFAULTS objectForKey:USER_ID],@"type":type,@"page":@(page)} loadString:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSLog(@"===%@",responseObject);
        
        
        if (BCStatus) {
            NSArray *arr =  [responseObject objectForKey:@"data"];
            if ([type isEqualToString:@""]) {//全部订单
                [self.allTableView.mj_footer endRefreshing];
                [allArr addObjectsFromArray:arr];
                
                if (arr.count == 0 && allArr.count == 0) {
                    
                    if (_alertdataView) {
                                [_alertdataView removeFromSuperview];
                                _alertdataView = nil;
                            }
                            self.alertdataView = [[WOWONoDataView alloc] initWithImageName:@"order" text:@"抱歉未查到数据" detailText:nil buttonTitle:@"去逛逛"];
                      [self.alertdataView.button addTarget:self action:@selector(clickGo) forControlEvents:UIControlEventTouchUpInside];
                            self.alertdataView.frame =self.view.bounds;
                    
                            [self.allTableView addSubview:_alertdataView];
                    return ;
                    
                }
                
                if (arr.count < 10) {
                    
                    [self.allTableView.mj_footer endRefreshingWithNoMoreData];
                }
                [self.allTableView reloadData];
                
            } else if ([type isEqualToString:@"WAITPAY"]){//代付款
                [self.notPayTableView.mj_footer endRefreshing];
                [notArr addObjectsFromArray:arr];
                
                if (arr.count == 0 && notArr.count == 0) {
                    
                    if (_alertdataView) {
                        [_alertdataView removeFromSuperview];
                        _alertdataView = nil;
                    }
                    self.alertdataView = [[WOWONoDataView alloc] initWithImageName:@"order" text:@"抱歉未查到数据" detailText:nil buttonTitle:@"去逛逛"];
                      [self.alertdataView.button addTarget:self action:@selector(clickGo) forControlEvents:UIControlEventTouchUpInside];
                    self.alertdataView.frame =self.view.bounds;
                    
                    [self.notPayTableView addSubview:_alertdataView];
                    return ;
                    
                }
                
                if (arr.count < 10) {
                    
                    [self.notPayTableView.mj_footer endRefreshingWithNoMoreData];
                }
                [self.notPayTableView reloadData];
                
            }else if ([type isEqualToString:@"WAITSEND"]){//代发货
                [self.notDispatchTabview.mj_footer endRefreshing];
                [aleratArr addObjectsFromArray:arr];
                
                
                if (arr.count == 0 && aleratArr.count == 0) {
                    
                    if (_alertdataView) {
                        [_alertdataView removeFromSuperview];
                        _alertdataView = nil;
                    }
                    self.alertdataView = [[WOWONoDataView alloc] initWithImageName:@"order" text:@"抱歉未查到数据" detailText:nil buttonTitle:@"去逛逛"];
                      [self.alertdataView.button addTarget:self action:@selector(clickGo) forControlEvents:UIControlEventTouchUpInside];
                    self.alertdataView.frame =self.view.bounds;
                    
                    [self.notDispatchTabview addSubview:_alertdataView];
                    return ;
                    
                }
                
                
                if (arr.count < 10) {
                    
                    [self.notDispatchTabview.mj_footer endRefreshingWithNoMoreData];
                }
                [self.notDispatchTabview reloadData];
                
            }else if ([type isEqualToString:@"WAITRECEIVE"]){//代收货
                [self.notEnableTableView.mj_footer endRefreshing];
                [notEnableArr addObjectsFromArray:arr];
                
                
                if (arr.count == 0 && notEnableArr.count == 0) {
                    
                    if (_alertdataView) {
                        [_alertdataView removeFromSuperview];
                        _alertdataView = nil;
                    }
                    self.alertdataView = [[WOWONoDataView alloc] initWithImageName:@"order" text:@"抱歉未查到数据" detailText:nil buttonTitle:@"去逛逛"];
                      [self.alertdataView.button addTarget:self action:@selector(clickGo) forControlEvents:UIControlEventTouchUpInside];
                    self.alertdataView.frame =self.view.bounds;
                    
                    [self.notEnableTableView addSubview:_alertdataView];
                    return ;
                    
                }
                
                
                if (arr.count < 10) {
                    
                    [self.notEnableTableView.mj_footer endRefreshingWithNoMoreData];
                }
                [self.notEnableTableView reloadData];
                
            }else {//已完成
                [self.finshTableView.mj_footer endRefreshing];
                [finshArr addObjectsFromArray:arr];
                
                
                if (arr.count == 0 && finshArr.count == 0) {
                    
                    if (_alertdataView) {
                        [_alertdataView removeFromSuperview];
                        _alertdataView = nil;
                    }
                    self.alertdataView = [[WOWONoDataView alloc] initWithImageName:@"order" text:@"抱歉未查到数据" detailText:nil buttonTitle:@"去逛逛"];
                    
                    self.alertdataView.frame =self.view.bounds;
                    [self.alertdataView.button addTarget:self action:@selector(clickGo) forControlEvents:UIControlEventTouchUpInside];
                    [self.finshTableView addSubview:_alertdataView];
                    return ;
                    
                }
                
                
                if (arr.count < 10) {
                    
                    [self.finshTableView.mj_footer endRefreshingWithNoMoreData];
                }
                [self.finshTableView reloadData];
                
            }
            
        } else {
            
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark 空白页去逛逛
-(void)clickGo{
    self.tabBarController.selectedIndex = 1;
    [self.navigationController popViewControllerAnimated:YES];
   
}
#pragma mark tableview 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.allTableView) {
        
        return allArr.count;
    }else if (tableView == self.notPayTableView) {
         return notArr.count;
    }else if (tableView == self.notDispatchTabview ){
        
         return aleratArr.count;
    }else if (tableView == self.notEnableTableView){
         return notEnableArr.count;
    }else {
        
         return finshArr.count;
        
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.notDispatchTabview) {
        
        return 158;
        
    } else if (tableView == self.allTableView){
    
   NSDictionary *dic = [allArr objectAtIndexCheck:indexPath.row];
        if ([[dic objectForKey:@"check_status"] integerValue] == 1) {//代发货
            return 158;
            
            
        }else {
            
            return 197;
        }
    
    } else {
        
          return 197;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (tableView == self.allTableView) {
             NSDictionary *dic = [allArr objectAtIndexCheck:indexPath.row];
        
        if ([[dic objectForKey:@"check_status"] integerValue] == 0) {//代付款
            
            static NSString *ID = @"kpo";
            CoinMyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
            if (!cell) {
                cell = [[CoinMyOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID andType:0];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                
            }
            cell.payBtn.userInteractionEnabled = NO;
            [cell.cancelBtn addMoreParams:[dic objectForKey:@"order_id"]];
            [cell.cancelBtn addTarget:self action:@selector(cancelEnable:) forControlEvents:UIControlEventTouchUpInside];
            
            
            [cell setDataForValue:dic];
            return cell;
            
        } else if ([[dic objectForKey:@"check_status"] integerValue] == 1) {
            
            static NSString *ID = @"kpos";
            CoinMyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
            if (!cell) {
                cell = [[CoinMyOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID andType:1];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                
            }
            
            
            
            [cell setDataForValue:dic];
            return cell;
            
        }else if ([[dic objectForKey:@"check_status"] integerValue] == 4) {
            
            static NSString *ID = @"kpod";
            CoinMyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
            if (!cell) {
                cell = [[CoinMyOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID andType:2];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                
            }
            [cell.expressBtn addtargetBlock:^(UIButton *button) {
               
                CoinH5ViewController *vc = [[CoinH5ViewController alloc] init];
                vc.url = [dic objectForKey:@"express"];
                [self.navigationController pushViewController:vc animated:YES];
            }];
            
            [cell.serviceBtn addtargetBlock:^(UIButton *button) {
                
                NSMutableString *str=[[NSMutableString alloc]initWithFormat:@"tel:%@",[dic objectForKey:@"customer_mobile"]];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }];
            [cell.enableBtn addMoreParams:dic];
            [cell.enableBtn addTarget:self action:@selector(clickEnable:) forControlEvents:UIControlEventTouchUpInside];
            [cell setDataForValue:dic];
            return cell;
        }else  {
            
            static NSString *ID = @"kposs";
            CoinMyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
            if (!cell) {
                cell = [[CoinMyOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID andType:3];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                
            }
            
            [cell.serviceBtn addtargetBlock:^(UIButton *button) {
                
                NSMutableString *str=[[NSMutableString alloc]initWithFormat:@"tel:%@",[dic objectForKey:@"customer_mobile"]];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }];
            [cell.expressBtn addtargetBlock:^(UIButton *button) {
                
                CoinH5ViewController *vc = [[CoinH5ViewController alloc] init];
                vc.url = [dic objectForKey:@"express"];
                [self.navigationController pushViewController:vc animated:YES];
            }];
            [cell setDataForValue:dic];
            return cell;
            
        }
        
        
        
    } else if (tableView == self.notPayTableView) {
        
        
        static NSString *ID = @"kpo1";
        CoinMyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (!cell) {
            cell = [[CoinMyOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID andType:0];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
        }
        NSDictionary *dic = [notArr objectAtIndexCheck:indexPath.row];
        cell.payBtn.userInteractionEnabled = NO;
        [cell.cancelBtn addMoreParams:[dic objectForKey:@"order_id"]];
        [cell.cancelBtn addTarget:self action:@selector(cancelEnable:) forControlEvents:UIControlEventTouchUpInside];
       
        [cell setDataForValue:dic];
        
        return cell;
        
    } else if (tableView == self.notDispatchTabview ){
        
        
        static NSString *ID = @"kpo2";
        CoinMyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (!cell) {
            cell = [[CoinMyOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID andType:1];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
        }
        
        
        NSDictionary *dic = [aleratArr objectAtIndexCheck:indexPath.row];
        [cell setDataForValue:dic];
        
        return cell;
        
    } else if (tableView == self.notEnableTableView){
        
        
        
        static NSString *ID = @"kpo3";
        CoinMyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (!cell) {
            cell = [[CoinMyOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID andType:2];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
        }
        
         NSDictionary *dic = [notEnableArr objectAtIndexCheck:indexPath.row];
        [cell.enableBtn addMoreParams:dic];
        [cell.enableBtn addTarget:self action:@selector(clickEnable:) forControlEvents:UIControlEventTouchUpInside];
        [cell.serviceBtn addtargetBlock:^(UIButton *button) {
            
            NSMutableString *str=[[NSMutableString alloc]initWithFormat:@"tel:%@",[dic objectForKey:@"customer_mobile"]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }];
        [cell.expressBtn addtargetBlock:^(UIButton *button) {
            
            CoinH5ViewController *vc = [[CoinH5ViewController alloc] init];
            vc.url = [dic objectForKey:@"express"];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        [cell setDataForValue:dic];
        
        return cell;
        
        
        
    } else {
        
        
        static NSString *ID = @"kpo4";
        CoinMyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (!cell) {
            cell = [[CoinMyOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID andType:3];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
        }
        
       
        NSDictionary *dic = [finshArr objectAtIndexCheck:indexPath.row];
        [cell.serviceBtn addtargetBlock:^(UIButton *button) {
            
            NSMutableString *str=[[NSMutableString alloc]initWithFormat:@"tel:%@",[dic objectForKey:@"customer_mobile"]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }];
        [cell.expressBtn addtargetBlock:^(UIButton *button) {
            
            CoinH5ViewController *vc = [[CoinH5ViewController alloc] init];
            vc.url = [dic objectForKey:@"express"];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        [cell setDataForValue:dic];
        
        return cell;
        
    }
   
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CoinOrderDetailsViewController * vc = [CoinOrderDetailsViewController new];
    NSDictionary * dict;
    if (tableView == self.allTableView) {
        dict = allArr[indexPath.row];
    }
    if (tableView == self.finshTableView) {
        dict = finshArr[indexPath.row];
        
    }else if (tableView == self.notPayTableView){
        dict = notArr[indexPath.row];
    }else if (tableView == self.notDispatchTabview){
        dict = aleratArr[indexPath.row];
        
    }else if (tableView == self.notEnableTableView){
        dict = notEnableArr[indexPath.row];
    }
//   check_status 校验订单状态(0待付款； 1待发货；2:已完成 ；3:已取消；4:待收货)
    NSInteger check_status = [dict[@"check_status"] integerValue];
    switch (check_status) {
        case 0:
            vc.type = BROrderNotPay;
            break;
            
        case 1:
            vc.type = BROrderNotDispatch;
            break;
            
        case 2:
            vc.type = BROrderFinsh;
            break;
            
        case 3:
             vc.type = BROrderNotEnable;
            break;
    }
    vc.order_id = dict[@"order_id"];
    [self.navigationController pushViewController:vc animated:YES];

    vc.resultData = ^(id  _Nonnull resultData) {
      
//        刷新当前列表
        NSInteger index = self.backScrollView.contentOffset.x / self.backScrollView.frame.size.width;
        if (index== 0) {
            [allArr removeAllObjects];
            [self getData:@""andPage:1];
            
            
        } else if (index == 1){
            
            [notArr removeAllObjects];
            [self getData:@"WAITPAY"andPage:1];
            
            
        }else if (index == 2){
            
            [aleratArr removeAllObjects];
            [self getData:@"WAITSEND"andPage:1];
            
            
        }else if (index == 3){
            
            [notEnableArr removeAllObjects];
            [self getData:@"WAITRECEIVE"andPage:1];
            
            
        }else {
            
            [finshArr removeAllObjects];
            [self getData:@"FINISH"andPage:1];
        }
    };
}



#pragma mark 确认订单
- (void)clickEnable:(UIButton *)btn {
  
   
    NSDictionary *dic = [btn getMoreParams];
    NSString *orderID = [dic objectForKey:@"order_id"];
    
    [KTooL HttpPostWithUrl:@"Order/order_confirm" parameters:@{@"user_id":[USER_DEFAULTS objectForKey:USER_ID],@"order_id":orderID} loadString:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (BCStatus) {
            CoinOrderSuccessViewController *VC = [CoinOrderSuccessViewController new];
            VC.imageUrl = [dic objectForKey:@"original_img"];
            VC.name = [dic objectForKey:@"goods_name"];
            VC.size = [dic objectForKey:@"spec_key_name"];
            VC.price =[dic objectForKey:@"goods_price"];
            VC.num = [dic objectForKey:@"goods_num"];
           [self.navigationController pushViewController:VC animated:YES];
            
//            刷新当前列表
            NSInteger index = self.backScrollView.contentOffset.x / self.backScrollView.frame.size.width;
            if (index== 0) {
                [allArr removeAllObjects];
                [self getData:@""andPage:1];
                
                
            } else if (index == 1){
                
                [notArr removeAllObjects];
                [self getData:@"WAITPAY"andPage:1];
                
                
            }else if (index == 2){
                
                [aleratArr removeAllObjects];
                [self getData:@"WAITSEND"andPage:1];
               
                
            }else if (index == 3){
                
                [notEnableArr removeAllObjects];
                [self getData:@"WAITRECEIVE"andPage:1];
                
                
            }else {
                
                [finshArr removeAllObjects];
                [self getData:@"FINISH"andPage:1];
            }
            
        } else {
            
            VCToast(@"确认订单失败", 1);
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
    
    
    
}

#pragma mark 取消订单
- (void)cancelEnable:(UIButton *)btn {
    
    NSString *orderID = [btn getMoreParams];
    
    [KTooL HttpPostWithUrl:@"Order/cancel_order" parameters:@{@"user_id":[USER_DEFAULTS objectForKey:USER_ID],@"order_id":orderID} loadString:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        
        
        
        if (BCStatus) {
            
//            刷新当前列表
            NSInteger index = self.backScrollView.contentOffset.x / self.backScrollView.frame.size.width;
            if (index== 0) {
                [allArr removeAllObjects];
                [self getData:@""andPage:1];
                
                
            } else if (index == 1){
                
                [notArr removeAllObjects];
                [self getData:@"WAITPAY"andPage:1];
                
                
            }else if (index == 2){
                
                [aleratArr removeAllObjects];
                [self getData:@"WAITSEND"andPage:1];
                
                
            }else if (index == 3){
                
                [notEnableArr removeAllObjects];
                [self getData:@"WAITRECEIVE"andPage:1];
                
                
            }else {
                
                [finshArr removeAllObjects];
                [self getData:@"FINISH"andPage:1];
            }
            
            VCToast(@"取消订单成功", 1);
            
        } else {
            
            VCToast(@"取消订单失败", 1);
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
    
    
    
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
        
        _allTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            
            
            allF++;
            [self getData:@""andPage:allF];
            
                    }];
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
        
        _notPayTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            
            
            notF++;
            [self getData:@"WAITPAY"andPage:notF];
            
        }];
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
        
        
        _notDispatchTabview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            
            
            aleartF++;
            [self getData:@"WAITSEND"andPage:aleartF];
            
        }];
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
        
        _notEnableTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            
            
           notEnableF++;
            [self getData:@"WAITRECEIVE"andPage:notEnableF];
            
        }];
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
        
        _finshTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            
            
            finishF++;
            [self getData:@"FINISH"andPage:finishF];
            
        }];
    }
    
    return _finshTableView;
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
