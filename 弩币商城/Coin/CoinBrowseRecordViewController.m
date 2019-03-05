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

@interface CoinBrowseRecordViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    UIImageView *backImageView;//滑竿
     UIButton *selectedBtn;
}
@property (nonatomic, strong) UIView *headView;//头部标签

@property (nonatomic, strong) UIScrollView *backScrollView;


@property (nonatomic, strong) UITableView *payTableView;//
@end

@implementation CoinBrowseRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"借款记录";
    
    
    [self.view addSubview:self.headView];
    [self.view addSubview:self.backScrollView];
    
   
   
    [self.backScrollView addSubview:self.payTableView];
    
    [self initView];
}

- (void)initView {
   
    
    UIView *backV = [[UIView alloc] init];
    backV.backgroundColor = White;
    [self.backScrollView addSubview:backV];
    [backV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.mas_equalTo(0);
        make.width.mas_equalTo(BCWidth);
        make.height.mas_equalTo(470);
    }];
    
    
    NSArray *leftA = @[@"借款协议编号：",@"借款金额：",@"利+服务费：",@"综合月利率：",@"优惠金额：",@"借款期限(天)：",@"借款申请日期：",@"到期还款日：",@"还款方式：",@"还款账户名称：",@"还款账号：",@"应还款金额：",@"状态：",@"逾期费："];
    for (int i = 0; i < leftA.count; i ++) {
        
        
        UILabel *leftL = [[UILabel alloc] init];
        leftL.text = leftA[i];
        
        leftL.textColor = COLOR(102, 102, 102);
        leftL.font = Regular(13);
        [backV addSubview:leftL];
        [leftL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(30*i + TOP_Margin);
            make.left.mas_equalTo(LEFT_Margin);
            make.height.mas_equalTo(25);
            
        }];
        
        
        
        UILabel *rightL = [[UILabel alloc] init];
        rightL.text = @"¥700.00";
        rightL.textColor = COLOR(102, 102, 102);
        rightL.font = Regular(13);
        [backV addSubview:rightL];
        [rightL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(-LEFT_Margin);
            make.top.mas_equalTo(leftL.mas_top);
            make.height.mas_equalTo(25);
        }];
        
        if (i == 0) {
            
            
            UIImageView *rightImage = [[UIImageView alloc] init];
            rightImage.image = BCImage(查看更多);
            [backV addSubview:rightImage];
            [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.right.mas_equalTo(-LEFT_Margin);
                make.centerY.equalTo(leftL);
            }];
            
            
            
            [rightL mas_remakeConstraints:^(MASConstraintMaker *make) {
               
                
                make.right.equalTo(rightImage.mas_left).offset(-10);
                make.top.mas_equalTo(leftL.mas_top);
                make.height.mas_equalTo(25);
                
            }];
        }
        
    }
    
    
//    按钮
    
    NSDictionary * firstAttributes1 = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"查看放款记录" attributes:firstAttributes1];
    UILabel *segLabel = [[UILabel alloc] init];
    segLabel.attributedText = str1;
    segLabel.textColor = COLOR(252, 148, 37);
    segLabel.font = Regular(14);
    [backV addSubview:segLabel];
    [segLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(60);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    [segLabel addTapGestureWithBlock:^{
       
        [self.navigationController pushViewController:[CoinBrowseStatusViewController new] animated:YES];
    }];
    
    
    NSDictionary * firstAttributes = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"去还款" attributes:firstAttributes];
    UILabel *segLabel1 = [[UILabel alloc] init];
    segLabel1.attributedText = str;
    segLabel1.textColor = COLOR(252, 148, 37);
    segLabel1.font = Regular(14);
    [backV addSubview:segLabel1];
    [segLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-60);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    [segLabel1 addTapGestureWithBlock:^{
       
        [self.navigationController pushViewController:[CoinReturnBrowseViewController new] animated:YES];
    }];
    
}
#pragma mark tableview 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    return 395;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
   
        static NSString *ID = @"kpo3";
        CoinBrowseRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (!cell) {
            cell = [[CoinBrowseRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
           
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
        }
        
    [cell.segLabel addTapGestureWithBlock:^{
       
         [self.navigationController pushViewController:[CoinBrowseStatusViewController new] animated:YES];
        
    }];
        
        
        return cell;
   
    
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
- (UITableView *)payTableView {
    
    
    if (!_payTableView) {
        _payTableView = [[UITableView alloc] initWithFrame:CGRectMake(BCWidth,0, BCWidth, BCHeight - 40) style:UITableViewStylePlain];
        _payTableView.delegate = self;
        _payTableView.dataSource = self;
        _payTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _payTableView.backgroundColor = DIVI_COLOR;
        
        
        _payTableView.showsVerticalScrollIndicator = NO;
        _payTableView.showsHorizontalScrollIndicator = NO;
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
