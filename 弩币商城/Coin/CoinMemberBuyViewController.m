//
//  CoinMemberBuyViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/4.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinMemberBuyViewController.h"
#import "CoinMemberSucceedViewController.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "CoinGoodDetailViewController.h"
@interface CoinMemberBuyViewController ()
@property (nonatomic,strong)UILabel * moneyLabel;
@property (nonatomic,strong)UIButton * tempButton;
@end

@implementation CoinMemberBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.type == BRPayBuyMember) {
        self.title = @"购买糖库金钻会员卡";
        [self requestVip_money];
    }else if (self.type == BRPayRepayment){
        self.title = @"还款";
    }else if (self.type == BRPayBuyCommodity){
        self.title = @"支付首付";
    }
    [self SetNavTitleColor];
    [self SetReturnButton];
    [self initView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess) name:PaySuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payError) name:PayError object:nil];
}

- (void)initView{
    UILabel * MoneyLabel = [[UILabel alloc] init];
    self.moneyLabel = MoneyLabel;
    if (self.type == BRPayBuyMember) {
        
    }else{
        MoneyLabel.text = [NSString stringWithFormat:@"￥%@",self.Money];
    }
   
    MoneyLabel.textColor = COLOR(255, 87, 103);
    MoneyLabel.font = Regular(24);
    [self.view addSubview:MoneyLabel];
    [MoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(32);
    }];
    
    if (self.type == BRPayRepayment) {
        UILabel * label = [UILabel new];
        label.text  = self.titleString;
        label.textColor = COLOR(51, 51, 51);
        label.font = Regular(13);
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(LEFT_Margin);
            make.right.equalTo(self.view);
            make.top.equalTo(MoneyLabel.mas_bottom).offset(10);
        }];
        
        UIView * LineView = [UIView new];
        LineView.backgroundColor = COLOR(238, 238, 238);
        [self.view addSubview:LineView];
        [LineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(10);
            make.top.equalTo(label.mas_bottom).offset(10);
        }];
    }
    
    UILabel * titleLabel = [UILabel new];
    titleLabel.text = @"选择支付方式";
    titleLabel.textColor = COLOR(51, 51, 51);
    titleLabel.font = Regular(16);
    [self.view addSubview:titleLabel];
    CGFloat top = 40;
    
    if (self.type == BRPayRepayment) {
        top = 60;
    }
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(LEFT_Margin);
        make.top.equalTo(MoneyLabel.mas_bottom).offset(top);
    }];
    
    for (int i = 0; i < 2; i++) {
        UIView * view = [UIView new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(LEFT_Margin);
            make.right.equalTo(self.view).offset(-LEFT_Margin);
            make.height.mas_equalTo(50);
            make.top.equalTo(titleLabel.mas_bottom).offset( (15 + 50 * i));
        }];
        UIView * LineView = [UIView new];
        LineView.backgroundColor = COLOR(229, 229, 229);
        [self.view addSubview:LineView];
        [LineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(view);
            make.height.mas_equalTo(0.5);
        }];
      
        if (i == 1) {
            LineView.hidden = YES;
        }
        
        UIView * LineView2 = [UIView new];
        LineView2.backgroundColor = COLOR(229, 229, 229);
        [self.view addSubview:LineView2];
        [LineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(view);
            make.height.mas_equalTo(0.5);
        }];
        
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:(i == 0 ? @"微信支付" :@"支付宝支付")];
        [view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.left.equalTo(titleLabel);
            make.width.height.mas_equalTo(22);
        }];
       
        UILabel * label = [UILabel new];
        label.text = (i == 0 ? @"微信支付" : @"支付宝支付");
        label.textColor = COLOR(102, 102, 102);
        label.font = Regular(16);
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).offset(10);
            make.centerY.equalTo(imageView);
        }];
        
        UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        btn.adjustsImageWhenHighlighted = NO;
        [btn setBackgroundImage:BCImage(未选中) forState:(UIControlStateNormal)];
         [btn setBackgroundImage:BCImage(选中) forState:(UIControlStateSelected)];
        [btn addTarget:self action:@selector(SelectBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.centerY.equalTo(view);
            make.width.height.mas_equalTo(17);
        }];
        btn.tag = i;
        if (i== 0) {
            btn.selected = YES;
            self.tempButton = btn;
        }
        
    }
    
    UIButton * payButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [payButton setTitle:@"立即支付" forState:(UIControlStateNormal)];
    [self.view addSubview:payButton];
    payButton.titleLabel.font = Regular(16);
    [payButton setBackgroundColor:COLOR(0, 160, 233) forState:(UIControlStateNormal)];
    [payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(38);
        make.right.equalTo(self.view).offset(-38);
        make.top.equalTo(self.view).offset(285);
        make.height.mas_equalTo(40);
    }];
    payButton.layer.cornerRadius = 10;
    payButton.clipsToBounds = YES;
    payButton.adjustsImageWhenHighlighted = NO;
    [payButton addTarget:self action:@selector(pay) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)pay{
    
     NSString * gateway = self.tempButton.tag == 0 ? @"wechat" : @"alipay";
    NSMutableDictionary * dict =[NSMutableDictionary dictionary];
    NSString * url = @"";
    if (self.type == BRPayRepayment) {
        url = [NSString stringWithFormat:@"repay-now/%@",self.IdStr];
        dict[@"id"] = self.IdStr;
        dict[@"gateway"] = gateway;
    }
    
    if (self.type == BRPayBuyMember) {
        url = @"CashLoan/buy_vip";
        dict[@"pay_type"] = self.tempButton.tag == 0 ? @"2" :@"1";
    }
    
    if (self.type == BRPayBuyCommodity) {
        url = @"Order/order_payment";
        dict[@"pay_type"] = self.tempButton.tag == 0 ? @"2" : @"1";
        dict[@"order_sn"] = self.orderNum;
    }
    
    [KTooL HttpPostWithUrl:url parameters:dict loadString:@"正在获取支付信息" success:^(NSURLSessionDataTask *task, id responseObject) {
        if (BCStatus) {
            if (self.tempButton.tag == 0) {
                NSDictionary * data = responseObject[@"data"];
                if ([data objectForKey:@"response"]) {
                    data = data[@"response"];
                }
                [self wechatPay:data];
            }else{
            
                NSString * alipay = responseObject[@"data"][@"alipay"];
                if ([responseObject[@"data"] objectForKey:@"response"]) {
                    alipay = responseObject[@"data"][@"response"];
                }
                [self alipayPay:alipay];
            }
        }else{
            VCToast(@"获取支付信息失败", 2);
        }
  } failure:^(NSURLSessionDataTask *task, NSError *error) {
        VCToast(@"获取支付信息失败", 2);
    }];
    
   
}
- (void)alipayPay:(NSString *)orderString{
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:@"com.Zbanks.tkgo" callback:^(NSDictionary *resultDic) {
        
    }];
    
}

- (void)wechatPay:(NSDictionary *)data{
    PayReq *request = [[PayReq alloc] init] ;
     request.partnerId = data[@"partnerid"];
    request.prepayId= data[@"prepayid"];
    request.package = data[@"package"];
    request.nonceStr= data[@"noncestr"];
    request.timeStamp = [data[@"timestamp"] intValue];
    request.sign= data[@"sign"];
    [WXApi sendReq:request];
}
- (void)SelectBtnAction:(UIButton *)btn{
    btn.adjustsImageWhenHighlighted = NO;
    if (self.tempButton == btn) {
        return;
    }
    self.tempButton.selected = NO;
    btn.selected = YES;
    self.tempButton = btn;
}

- (void)paySuccess{
    CoinMemberSucceedViewController * vc = [CoinMemberSucceedViewController new];
    if (self.type == BRPayBuyMember) {
        vc.type =  BRPaySuccessBuyMember;
    }
    if (self.type == BRPayBuyCommodity) {
        vc.type = BRPayPaymentSuccess;
    }
    
    if (self.type == BRPayRepayment) {
        vc.type = BRPayRepaySuccess;
    }
    vc.Money = self.Money;
    vc.order_id = self.orderID;
    vc.dataArray = self.DataArray;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)payError{
    VCToast(@"支付失败", 2);
}

- (void)BackAction{
 
      [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

- (void)requestVip_money{
    [KTooL HttpPostWithUrl:@"CashLoan/vip_card" parameters:nil loadString:@"正在加载" success:^(NSURLSessionDataTask *task, id responseObject) {
        if (BCStatus) {
            self.moneyLabel.text = [NSString stringWithFormat:@"￥ %@",responseObject[@"data"][@"vip_money"]];
            self.Money = responseObject[@"data"][@"vip_money"];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

@end
