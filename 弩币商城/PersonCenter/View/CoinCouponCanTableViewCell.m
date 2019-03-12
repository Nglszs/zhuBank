//
//  CoinCouponCanTableViewCell.m
//  弩币商城
//
//  Created by Jack on 2019/3/1.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinCouponCanTableViewCell.h"

@implementation CoinCouponCanTableViewCell
{
    
    UILabel *timeL;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.CommodityImage = [UIImageView new];
    self.CommodityImage.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.CommodityImage];
    [self.CommodityImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.mas_equalTo(LEFT_Margin);
        
        make.width.height.mas_equalTo(100);
    }];
    
    self.CommodityNameLabel = [UILabel new];
    self.CommodityNameLabel.numberOfLines = 2;
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"华为（HUAWEI） mate20pro手机全网通（UD屏内指纹版）" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    self.CommodityNameLabel.attributedText = string;
    [self.contentView addSubview:self.CommodityNameLabel];
    [self.CommodityNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.CommodityImage.mas_right).offset(20);
        make.top.equalTo(self.CommodityImage);
        make.right.equalTo(self.contentView).offset(-20);
        
    }];
    
    
    
    self.CommodityPriceLabel = [UILabel new];
    self.CommodityPriceLabel.text = @"¥6088.00";
    self.CommodityPriceLabel.textColor = COLOR(102, 102, 102);
    self.CommodityPriceLabel.font = TextFont(14);
    [self.contentView addSubview:self.CommodityPriceLabel];
    [self.CommodityPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.CommodityNameLabel);
        make.top.equalTo(self.CommodityNameLabel.mas_bottom).offset(12);
    }];
    
    self.ByStagesLabel = [[UILabel alloc] init];
    
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:@"￥1100.00*6期" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize: 14],NSForegroundColorAttributeName: [UIColor redColor]}];
    
    [string2 addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]} range:NSMakeRange(8, 3)];
    
    self.ByStagesLabel.attributedText = string2;
    [self.contentView addSubview:self.ByStagesLabel];
    [self.ByStagesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.CommodityPriceLabel.mas_bottom).offset(5);
        make.left.right.equalTo(self.CommodityNameLabel);
    }];
    
    
    timeL = [[UILabel alloc] init];
    timeL.text = @"1条评价 98%好评 ";
    timeL.textColor = COLOR(153, 153, 153);
    timeL.font = Regular(11);
    [self.contentView addSubview:timeL];
    [timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.ByStagesLabel.mas_left);
        make.top.equalTo(self.ByStagesLabel.mas_bottom).offset(6);
        make.height.mas_equalTo(11);
    }];
    
    //    分割线
    UIImageView *lineImage = [[UIImageView alloc] init];
    lineImage.backgroundColor = COLOR(242, 242, 242);
    
    [self.contentView addSubview:lineImage];
    [lineImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(LEFT_Margin);
        make.bottom.mas_equalTo(-3);
        make.width.mas_equalTo(BCWidth - 30);
        make.height.mas_equalTo(1);
    }];
   
}

- (void)setValueForCell:(NSDictionary *)data {
    [self.CommodityImage sd_setImageWithURL:[data objectNilForKey:@"original_img"]];
    self.CommodityNameLabel.text = [data objectNilForKey:@"goods_name"];
     self.CommodityPriceLabel.text =[NSString stringWithFormat:@"¥%@",[data objectNilForKey:@"shop_price"]];
    
    
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@*%@期",[data objectNilForKey:@"per_money"],[data objectNilForKey:@"period_num"]] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize: 14],NSForegroundColorAttributeName: [UIColor redColor]}];
    
    [string2 addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]} range:NSMakeRange([[data objectNilForKey:@"per_money"] stringValue].length + 1, 3)];
  self.ByStagesLabel.attributedText = string2;
    
    
    timeL.text = [NSString stringWithFormat:@"%@条评价 %@%%好评 ",[data objectNilForKey:@"show_comment_count"],[[data objectNilForKey:@"comment_statistics"]objectForKey:@"high_rate"] ];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


@end
