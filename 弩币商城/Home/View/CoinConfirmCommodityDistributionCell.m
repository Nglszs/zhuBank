//
//  CoinConfirmCommodityDistributionCell.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/2/27.
//  Copyright © 2019年 詹姆斯. All rights reserved.
// 确认订单快速配送cell

#import "CoinConfirmCommodityDistributionCell.h"

@interface CoinConfirmCommodityDistributionCell()
@property (nonatomic,strong)UIButton * SelectButton;

@end
@implementation CoinConfirmCommodityDistributionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    UILabel * SpeedLabel = [[UILabel alloc] init];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"快速配送" attributes:@{NSFontAttributeName: Regular(13.1),NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
    
    SpeedLabel.attributedText = string;
    [self.contentView addSubview:SpeedLabel];
    [SpeedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.top.equalTo(self.contentView).offset(13);
    }];
    
    UILabel * timeLabel = [[UILabel alloc] init];
    
    timeLabel.numberOfLines = 0;
    [self.contentView addSubview:timeLabel];
    
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:@"工作日、双休日和节假日均可配送" attributes:@{NSFontAttributeName: Regular(11),NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
    
    timeLabel.attributedText = string2;
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SpeedLabel).offset(0);
        make.top.equalTo(SpeedLabel.mas_bottom).offset(12);
    }];
    
    self.SelectButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.contentView addSubview:self.SelectButton];
    [self.SelectButton setBackgroundImage:[UIImage imageNamed:@"选择配送"] forState:(UIControlStateNormal)];
    self.SelectButton.adjustsImageWhenHighlighted = NO;
    [self.SelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(19);
        make.height.mas_equalTo(19);
        make.right.equalTo(self.contentView).offset(-16);
    }];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
