//
//  CoinConfirmOrderAddressCell.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/2/27.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinConfirmOrderAddressCell.h"
@interface CoinConfirmOrderAddressCell()

@property (nonatomic,strong)UILabel * NameLabel;
@property (nonatomic,strong)UILabel * AddressLabel;

@end

@implementation CoinConfirmOrderAddressCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
    
    UIImageView * AddressImageView = [[UIImageView alloc] init];
    AddressImageView.image = [UIImage imageNamed:@"地址"];
    [self.contentView addSubview:AddressImageView];
    [AddressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(16);
        make.width.mas_equalTo(13);
        make.height.mas_equalTo(20);
    }];
    UIImageView * SelectImageView = [[UIImageView alloc] init];
    SelectImageView.image = [UIImage imageNamed:@"地址选择"];
    [self.contentView addSubview:SelectImageView];
    [SelectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(AddressImageView);
        make.right.equalTo(self.contentView).offset(-16);
        make.width.mas_equalTo(11);
        make.height.mas_equalTo(20);
    }];
    self.NameLabel = [UILabel new];
    [self.contentView addSubview:self.NameLabel];
    self.NameLabel.font = TextFont(13);
    self.NameLabel.textColor = COLOR(51, 51, 51);
    self.NameLabel.text = @"收货地址";
    [self.NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(36);
        make.top.equalTo(self.contentView).offset(12);
        make.right.equalTo(SelectImageView.mas_left).offset(-10);
    }];
    
    self.AddressLabel = [UILabel new];
    self.AddressLabel.font = TextFont(12);
    self.AddressLabel.textColor = COLOR(134, 134, 134);
    self.AddressLabel.numberOfLines = 2;
   
    [self.contentView addSubview:self.AddressLabel];
    [self.AddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.NameLabel);
        make.top.equalTo(self.NameLabel.mas_bottom).offset(11);
    }];
    
    UIImageView * LineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"地址分栏"]];
    [self.contentView addSubview:LineView];
    [LineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_offset(3);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

- (void)setDataDict:(NSDictionary *)dataDict{
    _dataDict = dataDict;
    if (!BCDictIsEmpty(dataDict)) {
        self.NameLabel.text = [NSString stringWithFormat:@"%@  %@",dataDict[@"consignee"],dataDict[@"mobile"]];
        self.AddressLabel.text = [NSString stringWithFormat:@"%@ %@",dataDict[@"address_area"],dataDict[@"address"]];
        
    }
}
@end
