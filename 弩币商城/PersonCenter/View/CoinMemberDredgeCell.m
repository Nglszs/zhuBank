//
//  CoinMemberDredgeCell.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/24.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinMemberDredgeCell.h"

@interface CoinMemberDredgeCell()
@property (nonatomic,strong)UILabel * TimeLabel;

@end
@implementation CoinMemberDredgeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self) {
        if ([Tool isVip]) {
             [self initViewVip];
        }else{
          [self initView];
        }
      
    }
    return self;
}
- (void)initViewVip{
    UIImageView * backImage = [[UIImageView alloc] init];
    backImage.image = BCImage(会员卡bj 拷贝);
    [self.contentView addSubview:backImage];
    [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
        make.top.equalTo(self.contentView).offset(10);
        make.height.mas_equalTo((BCWidth - 40) / 335.0 * 190.0);
    }];
    
    
    UILabel * label1 = [UILabel new];
    label1.textColor = COLOR(255, 255, 255);
    label1.font = Regular(18);
    label1.text = @"金钻会员";
    [self.contentView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(30);
        make.top.equalTo(self.contentView).offset(64);
    }];
    
    
    UILabel * label2 = [UILabel new];
    label2.textColor = COLOR(255, 255, 255);
    label2.font = Regular(15);
    self.TimeLabel = label2;
    [self.contentView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(30);
        make.top.equalTo(label1.mas_bottom).offset(31);
    }];
    
}

- (void)initView{
    UIImageView * backImage = [[UIImageView alloc] init];
    backImage.image = BCImage(会员卡bj 拷贝);
    [self.contentView addSubview:backImage];
    [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
        make.top.equalTo(self.contentView).offset(10);
        make.height.mas_equalTo((BCWidth - 40) / 335.0 * 190.0);
    }];
    
    UILabel * label1 = [[UILabel alloc] init];
    label1.text = @"金钻会员";
    label1.textColor = COLOR(255, 255, 255);
    label1.font = Regular(18);
    [self.contentView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backImage).offset(31);
        make.left.equalTo(backImage).offset(34);
        
    }];
    UILabel * label2 = [[UILabel alloc] init];
    label2.textColor = COLOR(255, 255, 255);
    label2.font = Regular(12);
    label2.text = @"开通尊享......";
    [self.contentView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1);
        make.top.equalTo(label1.mas_bottom).offset(13);
    }];
    
    UILabel * label3 = [[UILabel alloc] init];
    label3.textColor = COLOR(255, 255, 255);
    label3.font = Regular(10);
    label3.text = @"通过率高，全额到账。";
    [self.contentView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label2);
        make.top.equalTo(label2.mas_bottom).offset(7);
    }];
    
    UILabel * label4 = [[UILabel alloc] init];
    label4.textColor = COLOR(255, 255, 255);
    label4.font = Regular(15);
    label4.text = @"￥299.00（有效期一年）";
    [self.contentView addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label2);
        make.top.equalTo(label3.mas_bottom).offset(24);
    }];
    
    UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.backgroundColor = COLOR(254, 254, 254);
    btn.layer.cornerRadius = 10;
    btn.clipsToBounds = YES;
    [self.contentView addSubview:btn];
    [btn setTitle:@"立即开通" forState:(UIControlStateNormal)];
    [btn setTitleColor:COLOR(253, 160, 133) forState:(UIControlStateNormal)];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label2);
        make.top.equalTo(label4.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(27);
    }];
    btn.titleLabel.font = Regular(15);
    self.dredgeButton = btn;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setEnd_time:(NSString *)end_time{
    _end_time = end_time;
    
    self.TimeLabel.text = [NSString stringWithFormat:@"将于%@到期",end_time];
    
}
@end
