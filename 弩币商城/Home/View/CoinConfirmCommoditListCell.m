//
//  CoinConfirmCommoditListCell.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/2/27.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinConfirmCommoditListCell.h"

@implementation CoinConfirmCommoditListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier leftTitle:(NSString *)leftTitleStr leftTitleColor:(UIColor *)leftTitleColor tagString:(NSString *)tagString rightStr:(NSString *)rightStr rightStrColor:(UIColor *)rightStrColor isShowSelectImage:(BOOL)isShowSelectImage{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self SetUILeftTitle:leftTitleStr leftTitleColor:leftTitleColor tagString:tagString rightStr:rightStr rightStrColor:rightStrColor isShowSelectImage:isShowSelectImage];
    }
    return self;
    
}
- (void)SetUILeftTitle:(NSString *)leftTitleStr leftTitleColor:(UIColor *)leftTitleColor tagString:(NSString *)tagString rightStr:(NSString *)rightStr rightStrColor:(UIColor *)rightStrColor isShowSelectImage:(BOOL)isShowSelectImage{
    UILabel * leftLabel = [UILabel new];
    leftLabel.font = Regular(13);
    leftLabel.textColor = leftTitleColor;
    leftLabel.text = leftTitleStr;
    [self.contentView addSubview:leftLabel];
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.centerY.equalTo(self.contentView);
    }];
    
    CGFloat right = isShowSelectImage ? -25 : -11;
    if (tagString.length > 0) {
        UILabel * label = [[UILabel alloc] init];
        label.font = Regular(10);
        label.text = tagString;
        label.textColor = [UIColor colorWithRed:254/255.0 green:36/255.0 blue:72/255.0 alpha:1.0];
        label.layer.borderWidth = 0.5;
        label.layer.borderColor = [UIColor colorWithRed:254/255.0 green:36/255.0 blue:72/255.0 alpha:1.0].CGColor;
        label.layer.cornerRadius = 5;
        label.clipsToBounds = YES;
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(leftLabel.mas_right).offset(10);
        }];
    }
    UIImageView * SelectImage = [UIImageView new];
    SelectImage.image = [UIImage imageNamed:@"查看更多"];
    SelectImage.hidden = !isShowSelectImage;
    [self.contentView addSubview:SelectImage];
    [SelectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-11);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(6);
        make.height.mas_equalTo(11);
    }];
    
    UILabel * RightLabel = [[UILabel alloc] init];
    RightLabel.textColor = rightStrColor;
    RightLabel.text = rightStr;
    RightLabel.font = MediumFont(14);
    [self.contentView addSubview:RightLabel];
    [RightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(right);
        make.centerY.equalTo(self.contentView);
    }];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
