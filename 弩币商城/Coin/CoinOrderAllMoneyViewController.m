//
//  CoinOrderAllMoneyViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/19.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinOrderAllMoneyViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "CoinMemberSucceedViewController.h"
#import "WXApi.h"
#import "CoinOrderAllMoneyViewController.h"
@interface CoinOrderAllMoneyViewController ()
@property (nonatomic,strong)UIButton * tempButton;
@property (nonatomic,strong)UILabel * orderNumberLabel;
@property (nonatomic,strong)UILabel * moneyLabel;
@end

@implementation CoinOrderAllMoneyViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提交订单";
    [self SetNavTitleColor];
    [self SetReturnButton];
    [self initView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess) name:PaySuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payError) name:PayError object:nil];
}

- (void)initView{
    UILabel * label = [UILabel new];
    label.font = Regular(16);
    label.textColor = COLOR(51, 51, 51);
    label.text = @"订单号";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(LEFT_Margin);
        make.right.equalTo(self.view).offset(-LEFT_Margin);
        make.height.mas_equalTo(50);
        make.top.equalTo(self.view);
    }];
    
    self.orderNumberLabel = [UILabel new];
    self.orderNumberLabel.text = self.OrderNum;
    self.orderNumberLabel.textColor = COLOR(255, 0, 0);
    self.orderNumberLabel.font = Regular(16);
    [self.view addSubview:self.orderNumberLabel];
    [self.orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-LEFT_Margin);
        make.centerY.equalTo(label);
        make.right.equalTo(self.view).offset(-LEFT_Margin);
        
    }];
    
    UIView * lineView1 = [UIView new];
    lineView1.backgroundColor = COLOR(229, 229, 229);
    [self.view addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label);
        make.top.equalTo(label.mas_bottom);
        make.right.equalTo(self.orderNumberLabel);
    }];
    
    UILabel * label2 = [UILabel new];
    label2.font = Regular(16);
    label2.textColor = COLOR(51, 51, 51);
    label2.text = @"订单金额";
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(LEFT_Margin);
        make.right.equalTo(self.view).offset(-LEFT_Margin);
        make.height.mas_equalTo(50);
        make.top.equalTo(lineView1.mas_bottom);
    }];
    
    self.moneyLabel = [UILabel new];
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%@",self.Money];
    self.moneyLabel.textColor = self.orderNumberLabel.textColor;
    self.moneyLabel.font = self.orderNumberLabel.font;
    [self.view addSubview:self.moneyLabel];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label2);
        make.right.equalTo(self.orderNumberLabel);
        
    }];
    
        UIView * LineView = [UIView new];
        LineView.backgroundColor = COLOR(238, 238, 238);
        [self.view addSubview:LineView];
        [LineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(10);
            make.top.equalTo(label2.mas_bottom).offset(0);
        }];
    
    
    UILabel * titleLabel = [UILabel new];
    titleLabel.text = @"选择支付方式";
    titleLabel.textColor = COLOR(51, 51, 51);
    titleLabel.font = Regular(16);
    [self.view addSubview:titleLabel];
    CGFloat top = 10;
    
  
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(LEFT_Margin);
    make.top.equalTo(LineView.mas_bottom).offset(top);
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
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"order_sn"] = self.OrderNum;
    dict[@"pay_type"] = self.tempButton.tag == 0? @"2" : @"1";
    [KTooL HttpPostWithUrl:@"Order/order_payment" parameters:dict loadString:@"正在支付" success:^(NSURLSessionDataTask *task, id responseObject) {
        if (BCStatus) {
            
            if (self.tempButton.tag == 0) {
                [self wechatPay:responseObject[@"data"]];
            }else{
                [self alipayPay:responseObject[@"data"][@"response"]];
            }
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
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
        vc.type = BRPayAllMoneySuccess;
    vc.Money = self.Money;
    vc.order_id = self.order_id;
    vc.dataArray = self.dataArray;
        [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)payError{
    VCToast(@"支付失败", 2);
    
}


@end
