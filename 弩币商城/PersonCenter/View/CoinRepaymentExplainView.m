//
//  CoinRepaymentExplainView.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/4/2.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinRepaymentExplainView.h"
// 还款计划说明
@implementation CoinRepaymentExplainView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
    self.backgroundColor = ACOLOR(0, 0, 0, 0.6);
    UILabel * titleLabel = [UILabel new];
    titleLabel.text = @"还款方式";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = Regular(17);
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(100);
    }];
    
    UIView * lineView = [UIView new];
    lineView.backgroundColor = [UIColor whiteColor];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(-30);
        make.height.mas_equalTo(2);
        make.top.equalTo(titleLabel.mas_bottom).offset(30);
    }];
    
    
    UILabel * detaileLabel = [UILabel new];
    
    detaileLabel.text = @"还款方式有两种\n方式一:银行卡代扣，每月还款日前，请保持银卡余额充足，大于或等于当月还款额。\n\n方式二:主动还款，点击立即还款按钮，通过支付宝或微信还款，本平台暂不支持提前还款减息。请您选择其中一种还款方式按时还款，防止影响您的信用记录。";
    detaileLabel.numberOfLines = 0;
    detaileLabel.textColor = [UIColor whiteColor];
    detaileLabel.font = Regular(15);
    [self addSubview:detaileLabel];
    [detaileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lineView);
        make.top.equalTo(lineView.mas_bottom).offset(30);
    }];
    
    UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setBackgroundImage:BCImage(关闭) forState:(UIControlStateNormal)];
    btn.adjustsImageWhenHighlighted = NO;
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(40);
        make.centerX.equalTo(self);
        make.top.equalTo(detaileLabel.mas_bottom).offset(50);
    }];
    
    [btn addTarget:self action:@selector(close) forControlEvents:(UIControlEventTouchUpInside)];
}
- (void)close{
     [self removeFromSuperview];
}


@end
