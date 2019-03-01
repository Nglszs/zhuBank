//
//  BankCardCell.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/1.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "BankCardCell.h"
@interface BankCardCell()
@property (nonatomic,strong)UIImageView * BankImageView;
@property (nonatomic,strong)UILabel * BankNameLabel;
@property (nonatomic,strong)UILabel * BankMoneyLabel;
@end
@implementation BankCardCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
    self.BankImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.BankImageView];
    
    [self.BankImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_equalTo(40);
        make.left.equalTo(self.contentView).offset(32);
    }];
    self.BankNameLabel = [[UILabel alloc] init];
    self.BankNameLabel.font = Regular(15);
    self.BankNameLabel.text = @"中国银行";
    self.BankNameLabel.textColor = COLOR(51, 51, 51);
    [self.contentView addSubview:self.BankNameLabel];
    [self.BankNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.BankImageView.mas_right).offset(17);
        make.top.equalTo(self.BankImageView);
        make.right.equalTo(self.contentView);
    }];
    self.BankImageView.image = [UIImage imageNamed:@"中国银行"];
    self.BankMoneyLabel = [UILabel new];
    self.BankMoneyLabel.text = @"单笔限1万，每日限1万";
    self.BankMoneyLabel.textColor = COLOR(153, 153, 153);
    self.BankMoneyLabel.font = Regular(13);
    [self.contentView addSubview:self.BankMoneyLabel];
    [self.BankMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.BankNameLabel);
        make.bottom.equalTo(self.BankImageView);
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
