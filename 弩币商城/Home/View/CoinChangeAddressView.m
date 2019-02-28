//
//  CoinChangeAddressView.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/2/28.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinChangeAddressView.h"
@interface CoinChangeAddressView()
@property (nonatomic,strong)UITextField * NameTF;
@property (nonatomic,strong)UITextField * PhoneNumberTF;
@property (nonatomic,strong)UITextField * CityTF;
@property (nonatomic,strong)UITextField * AddressTF;
@end
@implementation CoinChangeAddressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}
- (void)initView{
    self.NameTF = [UITextField new];
    self.PhoneNumberTF = [UITextField new];
    self.CityTF = [UITextField new];
    self.AddressTF = [UITextField new];
 
    [self SetTextFiled:self.NameTF leftString:@"收货人：" topSpace:(45 * 1) placeholder:nil];
    self.NameTF.text = @"梁丽丽";
  
    [self SetTextFiled:self.PhoneNumberTF leftString:@"手机号码：" topSpace:(45 * 2) placeholder:nil];
      self.PhoneNumberTF.text = @"132123456789";
    
    [self SetTextFiled:self.CityTF leftString:@"所在地区：" topSpace:(45 * 3) placeholder:nil];
    self.CityTF.text = @"江苏省 南京市 鼓楼区";
    
    [self SetTextFiled:self.AddressTF leftString:@"所在地区：" topSpace:(45 * 4) placeholder:nil];
    self.AddressTF.text = @"中山路";
    
    UIView * lineView = [UIView new];
    lineView.backgroundColor = COLOR(0, 0, 0);
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.top.equalTo(self);
        make.right.equalTo(self).offset(-16);
        make.height.mas_equalTo(0.5);
    }];
    
}

- (void)SetTextFiled:(UITextField *)textField leftString:(NSString *)leftString topSpace:(CGFloat)topSpace placeholder:(NSString *)placeholder{
    UIView * view = [UIView new];

    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.height.mas_equalTo(45);
        make.top.equalTo(self).offset((topSpace - 45));
    }];
    
    UILabel * label = [[UILabel alloc] init];
    label.text = leftString;
    label.textColor = COLOR(51, 51, 51);
    label.font = Regular(13);
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(view);
    }];
    textField.font = Regular(13);
    [view addSubview:textField];
    if (placeholder) {
        textField.placeholder = placeholder;
    }
    textField.textColor = COLOR(51, 51, 51);
    CGFloat hh = 0;
    if (textField == self.CityTF) {
        hh = 40;
    }
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label.mas_right).offset(5);
        make.centerY.equalTo(label);
        make.right.lessThanOrEqualTo(view).offset(hh);
    }];
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = COLOR(0, 0, 0);
    [view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(view);
        make.height.mas_equalTo(0.5);
    }];
    
    
}

@end
