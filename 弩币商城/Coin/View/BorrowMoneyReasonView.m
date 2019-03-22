//
//  BorrowMoneyReasonView.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/4.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "BorrowMoneyReasonView.h"

@interface BorrowMoneyReasonView()

@end
@implementation BorrowMoneyReasonView

- (instancetype)initWithFrame:(CGRect)frame withData:(NSArray *)dataArray{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView:dataArray];
    }
    return self;
}

- (void)initView:(NSArray *)data{
    
    UIView * BGView = [[UIView alloc] init];
    BGView.backgroundColor = [UIColor blackColor];
    BGView.alpha = 0.5;
    [self addSubview:BGView];
    [BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    NSMutableArray * array = [NSMutableArray array];
    for (NSDictionary * dict in data) {
        [array addObject:dict[@"use"]];
    }
    for (int i = 0; i < array.count; i++) {
        UIView * view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        [BGView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(BGView);
            make.bottom.equalTo(BGView).offset( - i * 45);
            make.height.mas_equalTo(45);
        }];
        UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [btn setTitle:array[array.count - i - 1] forState:(UIControlStateNormal)];
        btn.adjustsImageWhenHighlighted = NO;
        [btn setTitleColor:COLOR(153, 153, 153) forState:(UIControlStateNormal)];
        btn.titleLabel.font = Regular(13);
        [BGView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(view);
        }];
        MJWeakSelf;
        [btn addtargetBlock:^(UIButton *button) {
            if (weakSelf.use) {
                weakSelf.use(button.titleLabel.text);
            }
        }];
        btn.tag = 1000 + i;
        [btn addTarget:self action:@selector(Select:) forControlEvents:(UIControlEventTouchUpInside)];
        UIView * lineView = [UIView new];
        lineView.backgroundColor = COLOR(240, 240, 240);
        [btn addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(btn);
            make.height.mas_equalTo(0.5);
            make.left.equalTo(btn).offset(LEFT_Margin);
            make.right.equalTo(btn).offset(-LEFT_Margin);
        }];
     
    }
    
    UIView * headerView = [UIView new];
    headerView.backgroundColor = COLOR(238, 238, 238);
    [BGView addSubview:headerView];
    NSInteger bottom = - (array.count * 45);
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(BGView);
        make.bottom.equalTo(BGView).offset(bottom);
        make.height.mas_equalTo(50);
    }];
    UIButton * closeButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [closeButton setBackgroundImage:BCImage(取消) forState:(UIControlStateNormal)];
    [closeButton addTarget:self action:@selector(close) forControlEvents:(UIControlEventTouchUpInside)];
    [headerView addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView).offset(10);
        make.right.equalTo(headerView).offset(-10);
        make.width.height.mas_equalTo(15);
    }];
    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.font = Regular(12);
    titleLabel.textColor = COLOR(102, 102, 102);
    titleLabel.text = @"请选择实际资金用途\n禁止用于购房、投资、及各种非消费场景";
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(SetY(80));
        make.right.equalTo(headerView).offset(-SetY(80));
        make.centerY.equalTo(headerView);
    }];
    [BGView addTapGestureWithBlock:^{
        [self close];
    }];
    
   
}
- (void)Select:(UIButton *)btn{
    
    [self close];
}
- (void)close{
    [UIView animateWithDuration:0.25 animations:^{
        self.top = BCHeight + 100;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)setTop:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

@end
