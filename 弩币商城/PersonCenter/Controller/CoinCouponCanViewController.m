//
//  CoinCouponCanViewController.m
//  弩币商城
//
//  Created by Jack on 2019/3/1.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinCouponCanViewController.h"
#import "CoinCouponCanTableViewCell.h"
#import "CoinGoodDetailViewController.h"

@interface CoinCouponCanViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataArr;
    UITableView * tabView;
}
@end

@implementation CoinCouponCanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArr = [NSMutableArray arrayWithCapacity:1];
    self.navigationItem.title = @"本券可购买商品";
     [self initTableView];
    
    [self getData];
}
#pragma mark 网络请求
- (void)getData {
    
    [KTooL HttpPostWithUrl:@"UserCenter/coupons_goods" parameters:@{@"cid":_ID} loadString:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSLog(@"===%@",responseObject);
        
        
        if (BCStatus) {
            
            dataArr = [responseObject objectNilForKey:@"data"];
            
            if (dataArr.count <= 0) {
                
               
               WOWONoDataView *alertdataView = [[WOWONoDataView alloc] initWithImageName:@"myyhq 拷贝" text:@"该优惠券还没有可使用商品哦~" detailText:nil buttonTitle:nil];
                
              alertdataView.frame =self.view.bounds;
                
                [self.view addSubview:alertdataView];
                
                return ;
            }
            [tabView reloadData];
            
        } else {
            
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
        NSLog(@"");
    }];
}

// 初始化tableView
- (void)initTableView{
    tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:(UITableViewStylePlain)];
    tabView.delegate = self;
    tabView.dataSource = self;
    tabView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tabView];
    [tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(0);
    }];
    
}

#pragma mark  tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CoinCouponCanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CoinSearchResultCell"];
    if (cell == nil) {
        cell = [[CoinCouponCanTableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"CoinSearchResultCell"];
    }
    cell.selectionStyle = 0;
    NSDictionary *dic = [dataArr objectAtIndexCheck:indexPath.row];
    [cell setValueForCell:dic];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    CoinGoodDetailViewController *vc = [[CoinGoodDetailViewController alloc] init];
    vc.goodID = [[dataArr objectAtIndex:indexPath.row] objectForKey:@"goods_id"];
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
