//
//  CoinPayMoneyOrderViewController.m
//  弩币商城
//
//  Created by Jack on 2019/3/19.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinPayMoneyOrderViewController.h"
#import "CoinMemberBuyViewController.h"
#import "CoinOrderDetailsViewController.h"

@interface CoinPayMoneyOrderViewController ()
@property (nonatomic,assign)BOOL isCancelOrder;

@end
@implementation CoinPayMoneyOrderViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"购买成功";
    self.view.backgroundColor = DIVI_COLOR;
    [self initView];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:(UIBarButtonItemStyleDone) target:self action:@selector(temp)];
    
}

- (void)temp{
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)initView {
    
    UIView *topV = [[UIView alloc] init];
    topV.backgroundColor = White;
    [self.view addSubview:topV];
    [topV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.mas_equalTo(0);
        make.width.mas_equalTo(BCWidth);
        make.height.mas_equalTo(188);
    }];
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.text = @"订单信息已提交审核";
    titleL.textColor = Gray_Color;
    titleL.font = Regular(14);
    [topV addSubview:titleL];
    
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(LEFT_Margin);
        make.centerX.equalTo(topV);
        make.height.mas_equalTo(14);
        
    }];
    
    NSArray * leftA = @[@"收货人姓名：",@"收货地址：",@"支付方式：",@"订单号："];
    NSArray *rightA = @[_name,_address,@"首付 + 分期购",_orderNum];
    for (int i = 0; i < leftA.count; i ++) {
        UILabel *leftL = [[UILabel alloc] init];
        leftL.text = leftA[i];
        leftL.textColor = Gray_Color;
        leftL.font = Regular(13);
        [topV addSubview:leftL];
        leftL.adjustsFontSizeToFitWidth = YES;
        [leftL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleL.mas_bottom).offset(20 + 36 * i);
            make.left.mas_equalTo(LEFT_Margin);
            make.width.mas_equalTo(80);
        }];
        
        UILabel *rightL = [[UILabel alloc] init];
        rightL.text = rightA[i];
        rightL.numberOfLines = 2;
        rightL.textColor = COLOR(153, 153, 153);
        rightL.font = Regular(13);
        [topV addSubview:rightL];
        rightL.textAlignment = NSTextAlignmentRight;
        [rightL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(-LEFT_Margin);
            make.top.mas_equalTo(leftL.mas_top);
            make.left.equalTo(leftL.mas_right);
        }];
        
    }
    
//    支付和订单按钮
    UIButton *backBtn1 = [[UIButton alloc] init];
    backBtn1.titleLabel.font = Regular(16);
    [backBtn1 setTitle:@"支付首付" forState:UIControlStateNormal];
    [backBtn1 setTitleColor:White forState:UIControlStateNormal];
    backBtn1.layer.cornerRadius = 5;
    backBtn1.backgroundColor = COLOR(0, 160, 233);
    [self.view addSubview:backBtn1];
    [backBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.top.equalTo(topV.mas_bottom).offset(20);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(BCWidth - 80);
    }];
    
    [backBtn1 addtargetBlock:^(UIButton *button) {
        CoinMemberBuyViewController *VC = [[CoinMemberBuyViewController alloc] init];
        VC.type = BRPayBuyCommodity;
        VC.titleString = @"支付首付";
        VC.orderNum =self->_orderNum;
        VC.Money = self->_money;
        VC.orderID = self.order_id;
        VC.DataArray = self.dataArray;
        [self.navigationController pushViewController:VC animated:YES];
    }];
    
    UIButton *backBtn = [[UIButton alloc] init];
    backBtn.titleLabel.font = Regular(16);
    [backBtn setTitle:@"查看订单" forState:UIControlStateNormal];
    [backBtn setTitleColor:Gray_Color forState:UIControlStateNormal];
    backBtn.layer.cornerRadius = 5;
    backBtn.backgroundColor = White;
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.top.equalTo(backBtn1.mas_bottom).offset(20);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(BCWidth - 80);
    }];
    
    WS(weakSelf);
    [backBtn addtargetBlock:^(UIButton *button) {
        CoinOrderDetailsViewController * vc = [CoinOrderDetailsViewController new];
        vc.resultData = ^(id  _Nonnull resultData) {
            weakSelf.isCancelOrder = YES;
        };
        vc.order_id = self.order_id;
        vc.type = weakSelf.isCancelOrder ? BROrderNotDispatch : BROrderNotPay;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
}
@end
