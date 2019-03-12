//
//  CoinSearchResultCell.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/2/26.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinSearchResultCell.h"
#import "CoinSearchResultModel.h"
@interface CoinSearchResultCell()
@property (nonatomic,strong)UIImageView * CommodityImage;
@property (nonatomic,strong)UILabel * CommodityNameLabel;
@property (nonatomic,strong)UILabel * CommodityPriceLabel;
@property (nonatomic,strong)UILabel * ByStagesLabel;
@end
@implementation CoinSearchResultCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
    self.CommodityImage = [UIImageView new];
    [self.contentView addSubview:self.CommodityImage];
    [self.CommodityImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.width.equalTo(self.CommodityImage.mas_height);
    }];
    
    self.CommodityNameLabel = [UILabel new];
    self.CommodityNameLabel.numberOfLines = 2;
   
    [self.contentView addSubview:self.CommodityNameLabel];
    [self.CommodityNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.CommodityImage.mas_right).offset(20);
        make.top.equalTo(self.CommodityImage);
        make.right.equalTo(self.contentView).offset(-20);
        
    }];
    
    self.ByStagesLabel = [[UILabel alloc] init];
 
   
    [self.contentView addSubview:self.ByStagesLabel];
    [self.ByStagesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.CommodityImage);
        make.left.right.equalTo(self.CommodityNameLabel);
    }];
    
    
    self.CommodityPriceLabel = [UILabel new];
    self.CommodityPriceLabel.text = @"¥6088.00";
    self.CommodityPriceLabel.textColor = COLOR(102, 102, 102);
    self.CommodityPriceLabel.font = TextFont(14);
    [self.contentView addSubview:self.CommodityPriceLabel];
    [self.CommodityPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.CommodityNameLabel);
        make.bottom.equalTo(self.ByStagesLabel.mas_top).offset(-7);
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setModel:(CoinSearchResultModel *)model{
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:model.goods_name attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    self.CommodityNameLabel.attributedText = string;
    
    self.CommodityPriceLabel.text = model.shop_price;
    
    NSString * str = model.fenqi_info;
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName: [UIFont systemFontOfSize: 14],NSForegroundColorAttributeName: [UIColor redColor]}];
    NSArray * array = [str componentsSeparatedByString:@"*"];
    if (array.count == 2) {
         [string2 addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]} range:NSMakeRange(str.length - [[array lastObject] length] - 1, [[array lastObject] length] + 1)];
    }
    
   
    
    self.ByStagesLabel.attributedText = string2;
    
    
    [self.CommodityImage sd_setImageWithURL:[NSURL URLWithString:model.original_img]];
    
}

@end
