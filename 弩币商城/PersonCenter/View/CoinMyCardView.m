//
//  CoinMyCardView.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/1.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinMyCardView.h"

@interface CoinMyCardView()
@property (nonatomic,strong)UIScrollView * scrollView;
@property (nonatomic,strong)UIImageView * ByStagesBankImage;
@property (nonatomic,strong)UIImageView * loansBankImage;
@property (nonatomic,strong)UILabel *ByStagesBankNameLabel;
@property (nonatomic,strong)UILabel *loansBankNameLabel;
@property (nonatomic,strong)UILabel *ByStagesBankNumberLabel;
@property (nonatomic,strong)UILabel * loansBankNumberLabel;

@property (nonatomic,strong)UIView * view1;
@property (nonatomic,strong)UIView * view2;


@end
@implementation CoinMyCardView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self SetUI];
        [self request];
    }
    return self;
}
- (void)SetUI{
    self.backgroundColor = [UIColor whiteColor];
    self.scrollView = [[UIScrollView alloc] init];
    [self addSubview:self.scrollView];
    
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self);
    }];
   
    self.scrollView.contentSize = CGSizeMake(BCWidth, 667);
    UILabel * PayLabel = [UILabel new];
    PayLabel.text = @"分期购支持代扣还款的储蓄卡";
    PayLabel.font = Regular(14);
    PayLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [self.scrollView addSubview:PayLabel];
    [PayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self);
        make.top.equalTo(self.scrollView).offset(16);
    }];
    UIView * PayView = [self SetNoneCardView];
    self.PayView = PayView;
    self.view1 = [self AddBankCard:0];
  
  
    
    [PayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.height.mas_equalTo(122);
        make.top.equalTo(PayLabel.mas_bottom).offset(20);
    }];
    
    [self.view1 mas_makeConstraints:^(MASConstraintMaker *make) {
         make.edges.equalTo(PayView);
    }];
    
    UIView * lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = COLOR(238, 238, 238);
    [self.scrollView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(PayView.mas_bottom).offset(12);
        make.height.mas_equalTo(10);
    }];
    
    
    UILabel * RepaymentLabel = [UILabel new];
    RepaymentLabel.text = @"糖库借呗用于收款、还款的储蓄卡";
    RepaymentLabel.font = Regular(14);
    RepaymentLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [self.scrollView addSubview:RepaymentLabel];
    [RepaymentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self);
        make.top.equalTo(lineView2.mas_bottom).offset(16);
    }];
    
    UIView * RepaymentView = [self SetNoneCardView];
    self.RepaymentView = RepaymentView;
    self.view2 = [self AddBankCard:1];
    [self.view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(RepaymentView);
    }];
    [RepaymentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(PayView);
        make.top.equalTo(RepaymentLabel.mas_bottom).offset(20);
    }];
    UILabel * InfoLabel = [UILabel new];
    InfoLabel.textColor = COLOR(153, 153, 153);
    InfoLabel.font = Regular(11);
    InfoLabel.numberOfLines = 0;
    InfoLabel.text = @"温馨提示：\n● 银行卡开户信息须与您实名认证信息一致（姓名、身份证号等），不支持绑定信用卡；\n● 绑定时请认真对您的银行卡信息，相关信息填写错误将导致您无法按时还款；\n● 如果银行卡解绑申请未通过审核，银行卡则默认为原绑定银行卡。\n● 如有疑问请拨打客户热线400-618-8803.";
    [self.scrollView addSubview:InfoLabel];
    [InfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(RepaymentView);
        make.top.equalTo(RepaymentView.mas_bottom).offset(30);
    }];
    self.view1.hidden = YES;
    self.view2.hidden = YES;
    
}

- (UIView *)SetNoneCardView{
    UIView * view = [UIView new];
    view.layer.borderWidth = 0.5;
    view.layer.borderColor = COLOR(233, 233, 233).CGColor;
    view.layer.cornerRadius = 10;
    [self.scrollView addSubview:view];
    UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setBackgroundImage:[UIImage imageNamed:@"组5"] forState:(UIControlStateNormal)];
    [view addSubview:btn];
    btn.userInteractionEnabled = NO;
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(view).offset(24);
        make.width.height.mas_equalTo(45);
    }];
    UIView * lineView = [UIView new];
    lineView.backgroundColor = COLOR(233, 233, 233);
    [view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(view);
        make.height.mas_equalTo(0.5);
        make.bottom.equalTo(view).offset(-32);
    }];
    UILabel * label = [UILabel new];
    label.text = @"添加银行卡";
    label.font = Regular(13);
    label.textColor = COLOR(153, 153, 153);
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(lineView);
        make.bottom.equalTo(view);
    }];
    [btn addTarget:self action:@selector(AddBankCard) forControlEvents:(UIControlEventTouchUpInside)];
    return view;
}

// 有卡布局  0 分期还款，代扣  1  收款还款
- (UIView *)AddBankCard:(int)type{
    UIView * view = [UIView new];
    UIImageView * imageView = [UIImageView new];

    view.backgroundColor = COLOR(236, 74, 77);
    view.layer.cornerRadius = 5;
    view.clipsToBounds = YES;
    [view addSubview:imageView];
    [self.scrollView addSubview:view];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(20);
        make.top.equalTo(view).offset(25);
        make.width.height.mas_equalTo(32);
    }];
    imageView.layer.cornerRadius = 16;
    imageView.clipsToBounds = YES;
    
    UILabel * nameLabel = [UILabel new];
    nameLabel.textColor = COLOR(255, 255, 255);
    nameLabel.font = Regular(14);
    [view addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).offset(9);
        make.centerY.equalTo(imageView);
    }];
    
    
    UILabel * numberLabel = [UILabel new];
    numberLabel.textColor = COLOR(255, 255, 255);
    numberLabel.font = Regular(17);
    [view addSubview:numberLabel];
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel);
        make.bottom.equalTo(view).offset(-25);
    }];
    
    if (type == 0) {
        self.ByStagesBankImage = imageView;
        self.ByStagesBankNameLabel = nameLabel;
        self.ByStagesBankNumberLabel = numberLabel;
    }else{
        self.loansBankNameLabel = nameLabel;
        self.loansBankImage = imageView;
        self.loansBankNumberLabel = numberLabel;
    }
    return view;
}


- (void)AddBankCard{
    
    
}
- (void)request{
    [KTooL HttpPostWithUrl:@"UserCenter/my_bank" parameters:nil loadString:nil success:^(NSURLSessionDataTask *task, id responseObject) {

        if (BCStatus) {
            
            NSDictionary *  fu_bankcard = responseObject[@"data"][@"fu_bankcard"];
            NSDictionary * ll_bankcard = responseObject[@"data"][@"ll_bankcard"];
            int  status1 = [fu_bankcard[@"status"] intValue];
            int  status2 = [ll_bankcard[@"status"] intValue];
            if (status1 == 1) {
                self.view1.hidden = NO;
                [self.ByStagesBankImage sd_setImageWithURL:[NSURL URLWithString:fu_bankcard[@"pic"]]];
                self.ByStagesBankNameLabel.text = fu_bankcard[@"bank_name"];
                self.ByStagesBankNumberLabel.text = fu_bankcard[@"bank_card"];
                
            }
            
            if (status2 == 1) {
                self.view2.hidden = NO;
                [self.loansBankImage sd_setImageWithURL:[NSURL URLWithString:ll_bankcard[@"pic"]]];
                self.loansBankNameLabel.text = ll_bankcard[@"bank_name"];
                self.loansBankNumberLabel.text = ll_bankcard[@"bank_card"];
                
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
@end
