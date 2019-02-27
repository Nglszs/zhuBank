//
//  CoinConfirmCommodityOrderCell.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/2/27.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinConfirmCommodityOrderCell.h"
@interface  CoinConfirmCommodityOrderCell()
@property (nonatomic,strong)UIImageView * CommoditImage;
@property (nonatomic,strong)UILabel * CommoditNameLabel;
@property (nonatomic,strong)UILabel * CommoditSpecificationLabel;// 商品规格
@property (nonatomic,strong)UILabel * CommoditPrice;
@property (nonatomic,strong)UILabel * CommoditNumber;
@end
@implementation CoinConfirmCommodityOrderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    self.CommoditImage = [[UIImageView alloc] init];
    self.CommoditImage.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.CommoditImage];
    [self.CommoditImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.top.equalTo(self.contentView).offset(19);
        make.bottom.equalTo(self.contentView).offset(-7);
        make.width.equalTo(self.CommoditImage.mas_height);
    }];
    self.CommoditNameLabel = [UILabel new];
    self.CommoditNameLabel.text = @"华为（HUAWEI） mate20pro手机 全网通（UD屏内指纹版）";
    self.CommoditNameLabel.numberOfLines = 2;
    self.CommoditNameLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size: 11];
    self.CommoditNameLabel.textColor = COLOR(0, 0, 0);
    [self.contentView addSubview:self.CommoditNameLabel];
    [self.CommoditNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.CommoditImage.mas_right).offset(15);
        make.top.equalTo(self.CommoditImage);
        make.right.equalTo(self.contentView).offset(-71);
    }];
    
    self.CommoditSpecificationLabel = [UILabel new];
    self.CommoditSpecificationLabel.textColor = COLOR(153, 153, 153);
    self.CommoditSpecificationLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size: 11];
    self.CommoditSpecificationLabel.text = @"规格：8G+128G 全网通（UD屏内指纹版）";
    [self.contentView addSubview:self.CommoditSpecificationLabel];
    [self.CommoditSpecificationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.CommoditImage);
        make.left.right.equalTo(self.CommoditNameLabel);
    }];
    self.CommoditPrice = [UILabel new];
    self.CommoditPrice.textColor = COLOR(254, 69, 69);
    self.CommoditPrice.text = @"￥6088 ";
    self.CommoditPrice.textAlignment = NSTextAlignmentRight;
    self.CommoditPrice.font = TextFont(13);
    [self.contentView addSubview:self.CommoditPrice];
    [self.CommoditPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(self.CommoditNameLabel);
        make.left.equalTo(self.CommoditNameLabel.mas_right);
    }];
    
    self.CommoditNumber = [UILabel new];
    self.CommoditNumber.text = @"x1";
    self.CommoditNumber.textAlignment = NSTextAlignmentRight;
    self.CommoditNumber.font = TextFont(13);
    [self.contentView addSubview:self.CommoditNumber];
    [self.CommoditNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.CommoditSpecificationLabel);
        make.left.equalTo(self.CommoditNameLabel.mas_right);
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
