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
@interface CoinMyCouponViewController ()<UITableViewDelegate,UITableViewDataSource>
{
     UIImageView *backImageView;//滑竿
    UIButton *newBtn,*newBtn1;
}
@property (nonatomic, strong) UIView *headView;//头部标签

@property (nonatomic, strong) UIScrollView *backScrollView;

@property (nonatomic, strong) UITableView *getTableView;

@property (nonatomic, strong) UITableView *playTableView;
@property (nonatomic, strong) UITableView *payTableView;//

@end

@implementation CoinMyCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.headView];
    
    
     self.navigationItem.title = @"优惠券";
    
    [self setCustomRightBar:@"优惠券历史记录" click:^{
        
        [self.navigationController pushViewController:[CoinCouponHistoryViewController new] animated:YES];
    }];
    
     [self.view addSubview:self.backScrollView];
    
    
    [self.backScrollView addSubview:self.getTableView];
    [self.backScrollView addSubview:self.payTableView];
  
    [self.backScrollView addSubview:self.playTableView];
    
}

#pragma mark tableview 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    return 115;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (tableView == self.getTableView) {//所有
        static NSString *ID = @"kpo3";
        CoinMyCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (!cell) {
            cell = [[CoinMyCouponTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
        }
        
        
        
        
        return cell;
    } else if (tableView == self.payTableView){//优惠券
        static NSString *ID = @"kpo2";
        CoinMyCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (!cell) {
            cell = [[CoinMyCouponTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
        }
        
        
        
        
        return cell;
        
    } else {//运费
        
        static NSString *ID = @"kpo1";
        CoinExpressCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (!cell) {
            cell = [[CoinExpressCouponTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
        }
        
        
        
        
        return cell;
    }
    
   
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    [self.navigationController pushViewController:[CoinCouponCanViewController new] animated:YES];
}
#pragma mark 点击顶部按钮
- (void)clickTopButton:(UIButton *)btn {
    
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
            [segmentButton1 setTitleColor:COLOR(252, 148, 37) forState:UIControlStateNormal];
            
            
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


- (UITableView *)playTableView {
    
    if (!_playTableView) {
        
        
        _playTableView = [[UITableView alloc] initWithFrame:CGRectMake(BCWidth * 2, 0, BCWidth, BCHeight - 40) style:UITableViewStylePlain];
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
    
    
    
//     点击按钮
        NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    
        UIButton *btn = [self.headView viewWithTag:200 + index];
    
    [backImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.equalTo(btn);
        make.top.mas_equalTo(39);
        make.height.mas_equalTo(3);
        
    }];
    
}
@end
