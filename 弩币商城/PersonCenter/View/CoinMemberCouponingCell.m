//
//  CoinMemberCouponingCell.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/25.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinMemberCouponingCell.h"
#import "CoinMemberBuyViewController.h"
#import "CoinCouponCanViewController.h"
#import "CoinClassfyViewController.h"
@interface CoinMemberCouponingCell()
@property (nonatomic,strong)UIScrollView * scrollView;

@end
@implementation CoinMemberCouponingCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
        self.selectionStyle = 0;
    }
    return self;
    
}

- (void)initView{
    
    self.scrollView = [[UIScrollView alloc] init];
    [self.contentView addSubview:self.scrollView];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    
}
- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    for (UIView * view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    self.scrollView.contentSize = CGSizeMake(dataArray.count * (105 + 10) + 40, 0);
    for (int i = 0; i < dataArray.count; i++) {
        CGFloat left = 20 + (105 + 10) * i;
        UIView * view;
        if ([dataArray[i][@"coupons_type"] integerValue] == 0) {
             view = [self initCommodityView:dataArray[i] index:i];
            
        }else{
           view = [self initDiscountCouponView:dataArray[i] index:i];
        }
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.scrollView);
            make.left.equalTo(self.scrollView).offset(left);
            make.width.mas_equalTo(105);
            make.height.mas_equalTo(54);
        }];
    }
    
}

/**
 返回单个商品优惠券
 @param dict 数据参数
 @param index 下标
 @return 单个商品优惠券
 */
- (UIView *)initCommodityView:(NSDictionary *)dict index:(int)index{
    UIView * view = [UIView new];
    [self.scrollView addSubview:view];
    
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.image = BCImage(商品优惠券);
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    
    UILabel * nameLabel = [UILabel new];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    NSString * name = dict[@"name"];
    NSMutableString * string = [NSMutableString string];
    
    for (int i = 0; i < name.length; i++) {
        NSString * temp = [name substringWithRange:NSMakeRange(i, 1)];
        [string appendString:temp];
        if (i != name.length - 1) {
            [string appendString:@"\n"];
        }
    }
    nameLabel.text = string;
    nameLabel.font = Regular(11);
    nameLabel.textColor = COLOR(255, 255, 255);
    nameLabel.numberOfLines = 0;
    [view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(imageView);
        make.centerX.equalTo(imageView.mas_left).offset(12);
        
    }];
    UILabel * moneyLabel = [[UILabel alloc] init];
    moneyLabel.font = Regular(20);
    moneyLabel.textColor = COLOR(255, 255, 255);
    moneyLabel.numberOfLines = 0;
    moneyLabel.text = [NSString stringWithFormat:@"%@",dict[@"money"]];
 
    [view addSubview:moneyLabel];
    
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView).offset(0);
        make.centerX.equalTo(imageView.mas_left).offset(65.5);
    }];
    UILabel * yuan = [UILabel new];
    yuan.font = Regular(10);
    yuan.textColor = COLOR(255, 255, 255);
    yuan.text = @"元";
    [view addSubview:yuan];
    [yuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moneyLabel.mas_right);
        make.bottom.equalTo(moneyLabel).offset(-4);
    }];
    UILabel * condition = [UILabel new];
    condition.font = Regular(9);
    condition.textColor = COLOR(255, 255, 255);
    condition.text = [NSString stringWithFormat:@"满%@元使用",dict[@"condition"]];
    [view addSubview:condition];
    [condition mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(moneyLabel);
        make.top.equalTo(moneyLabel.mas_bottom).offset(-4);
    }];
    UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.backgroundColor = COLOR(254, 254, 254);
    btn.layer.cornerRadius = 3;
    btn.clipsToBounds = YES;
    btn.tag = index;
    [view addSubview:btn];
    int status = [dict[@"status"] intValue];
    NSString * btnStr = @"";
    if (status == 1) {
        btnStr = @"立即使用";
    }else if (status == 2){
         btnStr = @"已使用";
    }else if (status == 3){
         btnStr = @"已过期";
    }
    [btn setTitle:btnStr forState:(UIControlStateNormal)];
    [btn setTitleColor:COLOR(251, 172, 125) forState:(UIControlStateNormal)];
    btn.adjustsImageWhenDisabled = NO;
    btn.titleLabel.font = Regular(9);
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(moneyLabel);
        make.bottom.equalTo(imageView).offset(-2);
        make.width.mas_equalTo(48);
        make.height.mas_equalTo(14);
    }];
    [btn addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    return view;
}

- (void)buttonAction:(UIButton *)btn{
    if (![Tool isVip]) {
        // 去购买会员
        CoinMemberBuyViewController * VC = [CoinMemberBuyViewController new];
        VC.type = BRPayBuyMember;
        [self.SeleVC.navigationController pushViewController:VC animated:YES];
        return;
    }
    NSDictionary * dict = self.dataArray[btn.tag];
    int coupons_type = [dict[@"coupons_type"] intValue];
    if (coupons_type == 0) {
        // 商品优惠券
        CoinCouponCanViewController * vc = [CoinCouponCanViewController new];
        vc.ID = dict[@"cid"];
        [self.SeleVC.navigationController pushViewController:vc animated:YES];
    }else{
        // 运费优惠券
        [self.SeleVC.navigationController pushViewController:[CoinClassfyViewController new] animated:YES];
    }
 
}

- (UIView *)initDiscountCouponView:(NSDictionary *)dict index:(int)index{
    
  
    UIView * view = [UIView new];
    [self.scrollView addSubview:view];
    
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.image = BCImage(运费券);
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    
    UILabel * moeneyLabel = [UILabel new];
    moeneyLabel.textColor = COLOR(255, 255, 255);
    moeneyLabel.font = Regular(10);
    moeneyLabel.text = [NSString stringWithFormat:@"￥%@运费抵扣卷",dict[@"money"]];
    moeneyLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:moeneyLabel];
    [moeneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view).offset(-7);
        make.left.right.equalTo(view);
    }];
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:moeneyLabel.text];
    [string addAttribute:NSFontAttributeName value:Regular(25) range:NSMakeRange(1, [[NSString stringWithFormat:@"%@",dict[@"money"]] length])];
    moeneyLabel.attributedText = string;
    
    UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.backgroundColor = COLOR(255, 255, 255);
    btn.layer.cornerRadius = 3;
    btn.clipsToBounds = YES;
    btn.tag = index;
    [view addSubview:btn];
    int status = [dict[@"status"] intValue];
    NSString * btnStr = @"";
    if (status == 1) {
        btnStr = @"立即使用";
        btn.userInteractionEnabled = YES;
    }else if (status == 2){
        btnStr = @"已使用";
         btn.userInteractionEnabled = NO;
    }else if (status == 3){
        btnStr = @"已过期";
         btn.userInteractionEnabled = NO;
    }
    [btn setTitle:btnStr forState:(UIControlStateNormal)];
    [btn setTitleColor:COLOR(0, 0, 0) forState:(UIControlStateNormal)];
    btn.adjustsImageWhenDisabled = NO;
    btn.titleLabel.font = Regular(9);
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(moeneyLabel.mas_bottom);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(14);
    }];
    [btn addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    return view;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
