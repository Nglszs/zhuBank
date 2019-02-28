//
//  CoinSelectAddresCell.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/2/28.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinSelectAddresCell.h"
@interface CoinSelectAddresCell()
@property (nonatomic,strong)UILabel * NameLabel;
@property (nonatomic,strong)UILabel * PhoneNumberLabel;
@property (nonatomic,strong)UILabel * AddressLabel;
@end
@implementation CoinSelectAddresCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
    
}

- (void)initView{
    self.NameLabel = [UILabel new];
    [self.contentView addSubview:self.NameLabel];
    self.NameLabel.text = @"梁丽丽";
    self.NameLabel.textColor = COLOR(51, 51, 51);
    self.NameLabel.font = Regular(13);
    
    [self.NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.top.equalTo(self.contentView).offset(  15);
        
    }];
    
    self.PhoneNumberLabel = [UILabel new];
    self.PhoneNumberLabel.textColor = COLOR(51, 51, 51);
    self.PhoneNumberLabel.font = Regular(13);
    self.PhoneNumberLabel.text = @"电话：12345678";
    [self.contentView addSubview:self.PhoneNumberLabel];
    [self.PhoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.NameLabel.mas_right).offset(20);
        make.centerY.equalTo(self.NameLabel);
    }];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"编辑"]];
    [self.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-30);
        make.width.mas_equalTo(19);
        make.height.mas_equalTo(20);
    }];
    
    self.AddressLabel = [UILabel new];
    self.AddressLabel.textColor = COLOR(51, 51, 51);
    self.AddressLabel.text = @"江苏省 南京市 鼓楼区 中山东路";
    self.AddressLabel.font = Regular(13);
    [self.contentView addSubview:self.AddressLabel];
    [self.AddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.PhoneNumberLabel);
        make.right.lessThanOrEqualTo(imageView.mas_left);
        make.top.equalTo(self.PhoneNumberLabel.mas_bottom).offset(11);
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
