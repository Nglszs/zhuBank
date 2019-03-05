//
//  CoinUpdatePassWordView.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/4.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinUpdatePassWordView.h"

@implementation CoinUpdatePassWordView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self  initUI];
    }
    return self;
}
- (void)initUI{
    
    self.backgroundColor = [UIColor whiteColor];
    UIImageView * BeginImageView = [UIImageView new];
    BeginImageView.image = [UIImage imageNamed:@"完成"];
    [self addSubview:BeginImageView];
    [BeginImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(SetX(41));
        make.top.equalTo(self).offset(SetY(41));
        make.width.height.mas_equalTo(21);
    }];
    UILabel * beginLabel = [UILabel new];
    [self addSubview:beginLabel];
    beginLabel.font = Regular(12);
    beginLabel.text = @"账号验证";
    beginLabel.textColor = COLOR(102, 102, 102);
    [self addSubview:beginLabel];
    
    [beginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(BeginImageView);
        make.top.equalTo(BeginImageView.mas_bottom).offset(10);
    }];
    
    
    
    UIImageView * CentreImageView = [UIImageView new];
    CentreImageView.image = [UIImage imageNamed:@"组4"];
    [self addSubview:CentreImageView];
    [CentreImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(SetY(41));
        make.width.height.mas_equalTo(21);
    }];
    UILabel * CenterLabel = [UILabel new];
    [self addSubview:CenterLabel];
    CenterLabel.font = Regular(12);
    CenterLabel.text = @"更新密码";
    CenterLabel.textColor = COLOR(102, 102, 102);
    [self addSubview:CenterLabel];
    
    [CenterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(CentreImageView);
        make.top.equalTo(BeginImageView.mas_bottom).offset(10);
    }];
    
    
    UIImageView * OverImageView = [UIImageView new];
    OverImageView.image = [UIImage imageNamed:@"更新密码"];
    [self addSubview:OverImageView];
    [OverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-SetX(41));
        make.top.equalTo(self).offset(SetY(41));
        make.width.height.mas_equalTo(21);
    }];
    UILabel * OverLabel = [UILabel new];
    [self addSubview:OverLabel];
    OverLabel.font = Regular(12);
    OverLabel.text = @"完成";
    OverLabel.textColor = COLOR(102, 102, 102);
    [self addSubview:OverLabel];
    
    [OverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(OverImageView);
        make.top.equalTo(BeginImageView.mas_bottom).offset(10);
    }];
    
    UIView * lineView = [UIView new];
    lineView.backgroundColor =  COLOR(217, 217, 217);
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(BeginImageView);
        make.right.equalTo(OverImageView);
        make.height.mas_equalTo(0.5);
    }];
    [self sendSubviewToBack:lineView];
    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.font = Regular(17);
    titleLabel.textColor = COLOR(102, 102, 102);
    titleLabel.text = @"设置新密码";
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(CenterLabel.mas_bottom).offset(SetY(54));
    }];
    
    [self SetTextField:[UITextField new] leftImage:@"密码" placeholdeStr:@"输入新密码" belowLineY:SetY(270)];
     [self SetTextField:[UITextField new] leftImage:@"密码" placeholdeStr:@"确认新密码" belowLineY:SetY(305)];
    UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.backgroundColor = COLOR(255, 0, 0);
    [self addSubview:btn];
    [btn setTitle:@"确认修改" forState:(UIControlStateNormal)];
    btn.layer.cornerRadius = 20;
    btn.clipsToBounds = YES;
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(SetX(71));
        make.right.equalTo(self).offset(-SetX(71));
        make.top.equalTo(self).offset(SetY(353));
        make.height.mas_equalTo(43);
    }];
    self.UpDateButton = btn;
}

- (void)SetTextField:(UITextField *)textField leftImage:(NSString *)imageName placeholdeStr:(NSString *)placeholdeStr belowLineY:(CGFloat)belowLineY{
    UIView * BGView = [UIView new];
    [self addSubview:BGView];
    [BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(SetX(45));
        make.right.equalTo(self).offset(SetX(-45));
        make.height.mas_equalTo(SetY(51));
        make.bottom.equalTo(self.mas_top).offset(belowLineY);
    }];
    
    UIView * lineView = [UIView new];
    lineView.backgroundColor = COLOR(153, 153, 153);
    [BGView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(BGView);
        make.height.mas_equalTo(0.5);
    }];
    UIImageView *  imageView = [UIImageView new];
    [BGView addSubview:imageView];
    imageView.image = [UIImage imageNamed:imageName];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(BGView).offset(10);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(18);
        make.bottom.equalTo(BGView).offset(-13);
    }];
    [BGView addSubview:textField];
    textField.placeholder = placeholdeStr;
    [textField setValue:COLOR(153, 153, 153) forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).offset(10);
        make.right.equalTo(BGView);
        make.centerY.equalTo(imageView);
    }];
    
}



@end
