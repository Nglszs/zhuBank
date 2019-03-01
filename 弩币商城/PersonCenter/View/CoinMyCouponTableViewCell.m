//
//  CoinMyCouponTableViewCell.m
//  弩币商城
//
//  Created by Jack on 2019/3/1.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinMyCouponTableViewCell.h"

@implementation CoinMyCouponTableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.contentView.backgroundColor = ThemeColor;
        
        [self initView];
        
    }
    
    return self;
}


- (void)initView {
    
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = COLOR(255, 241, 235);
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.mas_equalTo(LEFT_Margin);
        make.right.mas_equalTo(-LEFT_Margin);
        make.height.mas_equalTo(100);
        
    }];
    
    
    UIImageView *leftI = [[UIImageView alloc] init];
    leftI.backgroundColor = ImageColor;
    [backView addSubview:leftI];
    [leftI mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(LEFT_Margin);
        make.top.mas_equalTo(20);
        make.width.height.mas_equalTo(60);
        
    }];
    
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"¥5399"];
    NSDictionary * firstAttributes = @{ NSFontAttributeName:Regular11Font};
    [str setAttributes:firstAttributes range:NSMakeRange(0,1)];
    
    UILabel *priceL = [[UILabel alloc] init];
    
    priceL.textColor = COLOR(254, 100, 38);
    priceL.font = Regular(17);
    priceL.attributedText = str;
    [backView addSubview:priceL];
    [priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(leftI.mas_right).offset(10);
        make.top.mas_equalTo(15);
        make.height.mas_equalTo(17);
    }];
    
    
    
    UILabel *moneyL1 = [[UILabel alloc] init];
    moneyL1.text = @"现金抵用券";
    moneyL1.textColor = COLOR(254, 100, 38);
    moneyL1.font = Regular(11);
    [backView addSubview:moneyL1];
    [moneyL1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(priceL.mas_right).offset(20);
        make.bottom.equalTo(priceL);
        make.height.mas_equalTo(11);
    }];
    
    
//    满多少可用
    UILabel *useL = [[UILabel alloc] init];
    useL.text = @"满3000 使用";
    useL.textColor = TITLE_COLOR;
    useL.font = Regular(13);
    [backView addSubview:useL];
    [useL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(priceL.mas_left);
        make.top.equalTo(moneyL1.mas_bottom).offset(5);
        make.height.mas_equalTo(13);
    }];
    
    
    
    UILabel *timeL = [[UILabel alloc] init];
    timeL.text = @"有效期2019.01.06-2019.03.31";
    timeL.textColor = COLOR(153, 153, 153);
    timeL.font = Regular(10);
    [backView addSubview:timeL];
    [timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(useL.mas_left);
        make.top.equalTo(useL.mas_bottom).offset(5);
        make.height.mas_equalTo(10);
    }];
    
    
//  详细信息
    UIButton *backBtn= [[UIButton alloc] init];
    
    [backBtn setTitle:@"查看更多" forState:UIControlStateNormal];
    [backBtn setTitleColor:COLOR(167, 167, 167) forState:UIControlStateNormal];
    backBtn.titleLabel.font = Regular11Font;
    backBtn.contentHorizontalAlignment = 1;
    [backBtn setImage:BCImage(圆角矩形 7 拷贝) forState:UIControlStateNormal];
    [backView addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(timeL.mas_bottom).offset(5);
        make.left.equalTo(leftI.mas_right).offset(15);
        make.height.mas_equalTo(10);
        make.width.mas_equalTo(100);
    }];
    [backBtn imagePositionStyle:ImagePositionStyleRight spacing:7];
    
    
//    右边按钮
    UIImageView *lineImage = [[UIImageView alloc] init];
   
    lineImage.backgroundColor = COLOR(254, 100, 38);
    
    [backView addSubview:lineImage];
    [lineImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-82);
        make.centerY.equalTo(backView);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(58);
    }];
    
    
    UIButton *activityBtn = [UIButton new];
    [activityBtn setTitleColor:COLOR(254, 100, 38) forState:UIControlStateNormal];
    [activityBtn setTitle:@"立即使用" forState:UIControlStateNormal];
    [activityBtn.titleLabel setFont:Regular(12)];
    activityBtn.layer.borderWidth = 1;
    activityBtn.layer.borderColor = COLOR(254, 100, 38).CGColor;
    
    activityBtn.layer.cornerRadius = 8;
    [backView addSubview:activityBtn];
    
    
    [activityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backView);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
