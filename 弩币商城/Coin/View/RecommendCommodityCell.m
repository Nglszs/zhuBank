//
//  RecommendCommodityCell.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/4.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "RecommendCommodityCell.h"
@interface RecommendCommodityCell()
@property (nonatomic,strong)UIImageView * imageView;
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UILabel * MoneyLabel;
@property (nonatomic,strong)UILabel * ByStagesLabel;
@end

@implementation RecommendCommodityCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self SetUI];
    }
    return self;
}

- (void)SetUI{
    self.imageView = [[UIImageView alloc] init];
    self.imageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-5);
        make.height.mas_equalTo(110);
    }];
    self.titleLabel = [UILabel new];
    self.titleLabel.font = Regular(12);
    self.titleLabel.textColor = COLOR(51, 51, 51);
    self.titleLabel.text = @"HUAWEI Mate 20 Pro";
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.numberOfLines = 2;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView);
        make.right.equalTo(self.contentView);
        make.top.equalTo(self.imageView.mas_bottom).offset(3);
    }];
    self.MoneyLabel = [[UILabel alloc] init];

    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"￥5399起" attributes:@{NSFontAttributeName: Regular(18),NSForegroundColorAttributeName: [UIColor colorWithRed:251/255.0 green:82/255.0 blue:24/255.0 alpha:1.0]}];
    
    [string addAttributes:@{NSFontAttributeName: Regular(17.1)} range:NSMakeRange(1, 4)];
    
    [string addAttributes:@{NSFontAttributeName: Regular(12)} range:NSMakeRange(5, 1)];
    self.MoneyLabel.attributedText = string;
    [self.contentView addSubview:self.MoneyLabel];
    
    [self.MoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(3);
        make.left.right.equalTo(self.titleLabel);
        
    }];
    
    self.ByStagesLabel = [UILabel new];
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:@"￥180*36期" attributes:@{NSFontAttributeName: Regular(12),NSForegroundColorAttributeName: [UIColor colorWithRed:251/255.0 green:82/255.0 blue:24/255.0 alpha:1.0]}];
    
    [string2 addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]} range:NSMakeRange(4, 4)];
    
    self.ByStagesLabel.attributedText = string2;
    [self.contentView addSubview:self.ByStagesLabel];
    [self.ByStagesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.MoneyLabel.mas_bottom).offset(3);
        make.left.right.equalTo(self.MoneyLabel);
    }];

    
}
@end
