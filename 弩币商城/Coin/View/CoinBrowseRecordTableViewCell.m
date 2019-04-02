//
//  CoinBrowseRecordTableViewCell.m
//  弩币商城
//
//  Created by Jack on 2019/3/5.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinBrowseRecordTableViewCell.h"

@implementation CoinBrowseRecordTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = DIVI_COLOR;
        [self initView];
    }
    return self;
}

- (void)initView {
    
    
    UIView *backV = [[UIView alloc] init];
    backV.backgroundColor = White;
    [self.contentView addSubview:backV];
    [backV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.mas_equalTo(0);
        make.width.mas_equalTo(BCWidth);
        make.height.mas_equalTo(385);
    }];
    
    
    NSArray *leftA = @[@"借款协议编号：",@"借款金额：",@"利息+服务费：",@"综合月利率：",@"借款期限(天)：",@"到期还款日：",@"实际还款日：",@"还款方式：",@"逾期费：",@"实际还款总金额：",@"还款账户名称：",@"还款账号："];
    for (int i = 0; i < leftA.count; i ++) {
        
        
        UILabel *leftL = [[UILabel alloc] init];
        leftL.text = leftA[i];
        
        leftL.textColor = COLOR(102, 102, 102);
        leftL.font = Regular(13);
        [backV addSubview:leftL];
        [leftL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(30*i + TOP_Margin);
            make.left.mas_equalTo(LEFT_Margin);
            make.height.mas_equalTo(25);
            
        }];
        
        
        
        UILabel *rightL = [[UILabel alloc] init];
        rightL.text = @"¥700.00";
        rightL.tag = 100 + i;
        rightL.textColor = COLOR(102, 102, 102);
        rightL.font = Regular(13);
        [backV addSubview:rightL];
        [rightL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(-LEFT_Margin);
            make.top.mas_equalTo(leftL.mas_top);
            make.height.mas_equalTo(25);
        }];
        
        if (i == 0) {
            
            
            UIImageView *rightImage = [[UIImageView alloc] init];
            rightImage.image = BCImage(查看更多);
            [backV addSubview:rightImage];
            [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.right.mas_equalTo(-LEFT_Margin);
                make.centerY.equalTo(leftL);
            }];
            
            
            
            [rightL mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                
                make.right.equalTo(rightImage.mas_left).offset(-10);
                make.top.mas_equalTo(leftL.mas_top);
                make.height.mas_equalTo(25);
                
            }];
        }
        
    }
    
    
//    还款记录
    
    NSDictionary * firstAttributes = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"查看放款记录" attributes:firstAttributes];
    _segLabel = [[UILabel alloc] init];
    _segLabel.attributedText = str;
    _segLabel.textColor = COLOR(252, 148, 37);
    _segLabel.font = Regular(14);
    [backV addSubview:_segLabel];
    [_segLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(backV);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
}
- (void)setValueData:(NSDictionary *)data {
    
    NSArray *leftA = @[[data objectNilForKey:@"loan_agree_num"],
                       [data objectNilForKey:@"amount"],
                       [data objectNilForKey:@"interest"],[data objectNilForKey:@"rate"],[data objectNilForKey:@"days"],[data objectNilForKey:@"should_pay_date"],[data objectNilForKey:@"success_repay_date"],[data objectNilForKey:@"pay_type"],[data objectNilForKey:@"overdue_pay"],[data objectNilForKey:@"repay_total"],[data objectNilForKey:@"name"],[data objectNilForKey:@"bank_card"]];
    for (int i = 0; i < leftA.count; i ++) {
        
        
        UILabel *rightL = [self.contentView viewWithTag:100 + i];
        
        rightL.text = [NSString stringWithFormat:@"%@",leftA[i]];
        
    }
    
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
