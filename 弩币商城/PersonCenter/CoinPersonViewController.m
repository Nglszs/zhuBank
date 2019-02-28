//
//  CoinPersonViewController.m
//  弩币商城
//
//  Created by Jack on 2019/2/25.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinPersonViewController.h"
#import "CoinChangePhoneViewController.h"

@interface CoinPersonViewController ()
@property (nonatomic, strong) UIScrollView *backScrollView;
@end

@implementation CoinPersonViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    if (@available(iOS 11.0, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [self.view addSubview:self.backScrollView];
    
    
    [self initView];
    
    
    [self initDiviView];
    
    
    [self initOrderView];
    
    [self initBottomView];
    
}

- (void)initView {
    
    UIView *topV = [[UIView alloc] init];
    topV.backgroundColor = COLOR(255, 2, 2);
    [self.backScrollView addSubview:topV];
    [topV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.mas_equalTo(0);
        make.width.mas_equalTo(BCWidth);
        make.height.mas_equalTo(160);
        
    }];
    
    
//  头像
    UIImageView *headI = [[UIImageView alloc] init];
    headI.image = BCImage(头像);
    headI.layer.cornerRadius = 35;
    headI.clipsToBounds = YES;
    [topV addSubview:headI];
    [headI mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(55);
        make.left.mas_equalTo(LEFT_Margin);
        make.width.height.mas_equalTo(70);
        
    }];
    
    
//    设置
    
    UIButton *exitButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [exitButton setImage:[UIImage imageNamed:@"编辑"] forState:UIControlStateNormal];
   
    [topV addSubview:exitButton];
    [exitButton addTarget:self action:@selector(clickSet:) forControlEvents:UIControlEventTouchUpInside];
    [exitButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.mas_equalTo(-LEFT_Margin);
        make.top.mas_equalTo(45);
        make.width.height.mas_equalTo(25);
    }];
    
    
    
    
//    昵称
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.text = @"Jack";
    titleL.textColor = White;
    titleL.font = Regular(13);
    [self.backScrollView addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(headI.mas_top).offset(16);
        
        make.left.equalTo(headI.mas_right).offset(LEFT_Margin);
        make.height.mas_equalTo(13);
    }];
    
    
//    会员及额度
    UIButton *backBtn= [[UIButton alloc] init];
    
    [backBtn setTitle:@"帑库金钻会员" forState:UIControlStateNormal];
    [backBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    backBtn.titleLabel.font = Regular(13);
    backBtn.layer.cornerRadius = 12;
    backBtn.clipsToBounds = YES;
    backBtn.backgroundColor = White;
    [topV addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(titleL.mas_bottom).offset(12);
        make.left.mas_equalTo(titleL.mas_left);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(90);
    }];
   
    
    
    
    //   查看额度
    UIButton *backBtn1 = [[UIButton alloc] init];
    backBtn1.titleLabel.font = Regular(13);
    [backBtn1 setTitle:@"查看额度" forState:UIControlStateNormal];
    [backBtn1 setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    backBtn1.backgroundColor = White;
    backBtn1.layer.cornerRadius = 12;
    backBtn1.clipsToBounds = YES;
    [topV addSubview:backBtn1];
    [backBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backBtn.mas_top);
        make.left.equalTo(backBtn.mas_right).offset(LEFT_Margin);
        make.size.mas_equalTo(CGSizeMake(70, 25));
    }];
    
    
}


- (void)initDiviView{
    UIView *topV = [[UIView alloc] init];
    topV.backgroundColor = White;
    [self.backScrollView addSubview:topV];
    [topV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(160);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(BCWidth);
        make.height.mas_equalTo(104);
        
    }];
    
    
//    分期按钮
    NSArray *imageA = @[@"分期记录",@"借款记录"];
    NSArray *titleA = @[@"分期记录",@"借款记录"];
     NSArray *titleA1 = @[@"每月10日还款",@"最近一笔2月2号还款 "];
    
    for (int i = 0; i < 2; i++) {
        
        UIButton *backBtn= [[UIButton alloc] init];
        
        [backBtn setTitle:titleA[i] forState:UIControlStateNormal];
        [backBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
        backBtn.titleLabel.font = Regular(15);
        
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, 0);
    
        [backBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageA[i]]] forState:UIControlStateNormal];
        [topV addSubview:backBtn];
        
        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(i * BCWidth/2);
            make.height.mas_equalTo(104);
            make.width.mas_equalTo(BCWidth/2);
        }];
        [backBtn imagePositionStyle:ImagePositionStyleTop spacing:7];
        
        
//        还款时间
        UILabel *titleL = [[UILabel alloc] init];
        titleL.text = titleA1[i];
        titleL.textColor = COLOR(153, 153, 153);
        titleL.font = Regular(11);
        [topV addSubview:titleL];
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.mas_equalTo(-LEFT_Margin);
            make.centerX.equalTo(backBtn);
            make.height.mas_equalTo(11);
        }];
        
    }
}


- (void)initOrderView {
    
    
    UIImageView *divideView = [[UIImageView alloc] init];
    divideView.backgroundColor = DIVI_COLOR;
    [self.backScrollView addSubview:divideView];
    [divideView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(264);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(TOP_Margin);
        make.width.mas_equalTo(BCWidth);
        
    }];
    
    UIView *topV = [[UIView alloc] init];
    topV.backgroundColor = White;
    [self.backScrollView addSubview:topV];
    [topV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(divideView.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(BCWidth);
        make.height.mas_equalTo(117);
        
    }];
    
//    头部标题
    UIButton *backBtn= [[UIButton alloc] init];
    
    [backBtn setTitle:@"我的订单" forState:UIControlStateNormal];
    [backBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    backBtn.titleLabel.font = Regular(13);
    backBtn.contentHorizontalAlignment = 1;
    [backBtn setImage:BCImage(订单) forState:UIControlStateNormal];
    [topV addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(LEFT_Margin + 5);
        make.height.mas_equalTo(46);
        
    }];
    [backBtn imagePositionStyle:ImagePositionStyleDefault spacing:7];
    
    UIButton *backBtn1= [[UIButton alloc] init];
    
    [backBtn1 setTitle:@"查看全部" forState:UIControlStateNormal];
    [backBtn1 setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    backBtn1.titleLabel.font = Regular(13);
    backBtn1.contentHorizontalAlignment = 2;
    [backBtn1 setImage:BCImage(查看更多) forState:UIControlStateNormal];
    [topV addSubview:backBtn1];
    
    [backBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(BCWidth - 105 - LEFT_Margin);
        make.height.mas_equalTo(46);
        make.width.mas_equalTo(100);
    }];
    [backBtn1 imagePositionStyle:ImagePositionStyleRight spacing:7];
    
    
//    分割线
    UIImageView *lineImage = [[UIImageView alloc] init];
    lineImage.backgroundColor = COLOR(181, 181, 181);
    
    [topV addSubview:lineImage];
    [lineImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(46);
        make.width.mas_equalTo(BCWidth);
        make.height.mas_equalTo(1);
    }];
    
//    代付款和待收货
    
    NSArray *imageA = @[@"待付款",@"待收货"];
    NSArray *titleA = @[@"待付款",@"待收货"];
   
    
    for (int i = 0; i < 2; i++) {
        
        UIButton *backBtn= [[UIButton alloc] init];
        
        [backBtn setTitle:titleA[i] forState:UIControlStateNormal];
        [backBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
        backBtn.titleLabel.font = Regular(15);
        
      
        
        [backBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageA[i]]] forState:UIControlStateNormal];
        [topV addSubview:backBtn];
        
        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(lineImage.mas_bottom).offset(1);
            make.left.mas_equalTo((BCWidth - 100 - 80)/2 + i * (130) );
            make.height.mas_equalTo(70);
            make.width.mas_equalTo(50);
        }];
        [backBtn imagePositionStyle:ImagePositionStyleTop spacing:7];
        
      
    }
    
}

- (void)initBottomView {

    
    UIView *topV = [[UIView alloc] init];
    topV.backgroundColor = White;
    [self.backScrollView addSubview:topV];
    [topV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(391);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(BCWidth);
        make.height.mas_equalTo(56 * 4);
        make.bottom.equalTo(self.backScrollView).offset(-50);
        
    }];
    
    
//    几个按钮
    
    NSArray *imageA = @[@"地址1",@"银行卡",@"优惠券",@"关于我"];
    NSArray *titleA = @[@"地址管理",@"我的银行卡",@"我的优惠券",@"关于我们"];
    
    
    for (int i = 0; i < 4; i++) {
        
        
        
        UIImageView *divideView = [[UIImageView alloc] init];
        divideView.backgroundColor = DIVI_COLOR;
        [topV addSubview:divideView];
        [divideView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(56 * i);
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(TOP_Margin);
            make.width.mas_equalTo(BCWidth);
            
        }];
        
        UIButton *backBtn= [[UIButton alloc] init];
        backBtn.tag = 100 + i;
        [backBtn setTitle:titleA[i] forState:UIControlStateNormal];
        [backBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
        backBtn.titleLabel.font = Regular(13);
        backBtn.contentHorizontalAlignment = 1;
        [backBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageA[i]]] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [topV addSubview:backBtn];
        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(divideView.mas_bottom);
            make.left.mas_equalTo(LEFT_Margin + 5);
            make.height.mas_equalTo(46);
            make.width.mas_equalTo(BCWidth - 20);
        }];
        [backBtn imagePositionStyle:ImagePositionStyleDefault spacing:7];
        
        
        
        UIImageView *rightImage = [[UIImageView alloc] init];
        rightImage.image = BCImage(查看更多);
        [topV addSubview:rightImage];
        [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(-LEFT_Margin);
            make.centerY.equalTo(backBtn);
        }];
        
    }
    
    
}
#pragma mark 点击设置按钮
- (void)clickSet:(UIButton *)button {
    
    
    
}

#pragma mark 点击底部4个按钮
- (void)clickButton:(UIButton *)button {
    
    
    switch (button.tag) {
        case 100://地址管理
        {
            [self.navigationController pushViewController:[CoinChangePhoneViewController new] animated:YES];
        }
            break;
        case 101://我的银行卡
        {
            
        }
            break;
        case 102://我的优惠券
        {
            
        }
            break;
        case 103://关于我们
        {
            
        }
            break;
        default:
            break;
    }
    
}
#pragma mark 懒加载
- (UIScrollView *)backScrollView {
    
    if (!_backScrollView) {
        _backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, BCWidth, BCHeight )];
        _backScrollView.backgroundColor = DIVI_COLOR;
        _backScrollView.showsVerticalScrollIndicator = NO;
        _backScrollView.showsHorizontalScrollIndicator = NO;
       
      
        
    }
    
    
    return _backScrollView;
}

@end
