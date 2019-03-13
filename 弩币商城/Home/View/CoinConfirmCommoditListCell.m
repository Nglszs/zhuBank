//
//  CoinConfirmCommoditListCell.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/2/27.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinConfirmCommoditListCell.h"

@interface CoinConfirmCommoditListCell()
@property (nonatomic,strong)UILabel * leftLabel;
@property (nonatomic,strong)UILabel * tagLabel;
@property (nonatomic,strong)UILabel * RightLabel;

@end
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
    self.leftLabel = leftLabel;
    CGFloat right = isShowSelectImage ? -25 : -11;
    
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
        self.tagLabel = label;
    
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
    self.RightLabel = RightLabel;
    
}

- (void)setInvoice_infoData:(NSDictionary *)invoice_infoData{
    _invoice_infoData = invoice_infoData;
    if (!BCDictIsEmpty(invoice_infoData)) {
        NSString *  invoice_rise = invoice_infoData[@"invoice_rise"];
        NSString * invoice_content = invoice_infoData[@"invoice_content"];
        if (!invoice_rise && !invoice_content) {
            self.RightLabel.text = [NSString stringWithFormat:@"%@ -%@",invoice_rise,invoice_content];
        }
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setTotal_price:(NSString *)total_price{
    total_price = [NSString stringWithFormat:@"￥%@",total_price];
    _total_price = total_price;
    if (!BCStringIsEmpty(total_price)) {
        self.RightLabel.text = total_price;
    }
}


- (void)setTransfer_price:(NSString *)transfer_price{
    transfer_price = [NSString stringWithFormat:@"￥%@",transfer_price];
    _transfer_price = transfer_price;
    if (!BCStringIsEmpty(transfer_price)) {
        self.RightLabel.text = transfer_price;
    }
}

- (void)setCoupons_transfer:(NSString *)coupons_transfer{
    coupons_transfer = [NSString stringWithFormat:@"%@",coupons_transfer];
    _coupons_transfer = coupons_transfer;
    if (!BCStringIsEmpty(coupons_transfer)) {
        self.RightLabel.text = [NSString stringWithFormat:@"-￥%@",coupons_transfer];
        if (![coupons_transfer isEqualToString:@"0"]) {
            self.tagLabel.text = @" 已选1张 ";
        }
        
    }
}

- (void)setCoupons_reduce:(NSString *)coupons_reduce{
    _coupons_reduce = coupons_reduce;
    if (!BCStringIsEmpty(coupons_reduce)) {
        self.RightLabel.text = [NSString stringWithFormat:@"-￥%@",coupons_reduce];
        if (![coupons_reduce isEqualToString:@"0"]) {
            self.tagLabel.text = @" 已选1张 ";
        }
    }
}


@end
