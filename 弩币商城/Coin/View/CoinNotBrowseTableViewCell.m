//
//  CoinNotBrowseTableViewCell.m
//  弩币商城
//
//  Created by Jack on 2019/3/15.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinNotBrowseTableViewCell.h"

@implementation CoinNotBrowseTableViewCell
{
    UIImageView *rightImage;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
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
        make.height.mas_equalTo(470);
    }];
    
    
    NSArray *leftA = @[@"借款协议编号：",@"借款金额：",@"利息+服务费：",@"综合月利率：",@"优惠金额：",@"借款期限(天)：",@"借款申请日期：",@"到期还款日：",@"还款方式：",@"还款账户名称：",@"还款账号：",@"应还款金额：",@"状态：",@"逾期费："];
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
            
            
            rightImage  = [[UIImageView alloc] init];
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
        
        if (i == leftA.count - 2 || i==leftA.count - 1) {
            
            rightL.textColor = COLOR(255, 0, 0);
        }
        
    }
    
    
    //    按钮
    
    NSDictionary * firstAttributes1 = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"查看放款记录" attributes:firstAttributes1];
    UILabel *segLabel = [[UILabel alloc] init];
    _segLabel = segLabel;
    segLabel.attributedText = str1;
    segLabel.textColor = COLOR(252, 148, 37);
    segLabel.font = Regular(14);
    [backV addSubview:segLabel];
    [segLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(60);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
   
    
    
    NSDictionary * firstAttributes = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"去还款" attributes:firstAttributes];
    UILabel *segLabel1 = [[UILabel alloc] init];
    _segLabel1 = segLabel1;
    segLabel1.attributedText = str;
    segLabel1.textColor = COLOR(252, 148, 37);
    segLabel1.font = Regular(14);
    [backV addSubview:segLabel1];
    [segLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-60);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
   
}
- (void)setValueData:(NSDictionary *)data {
    
    NSString *status = @"";
    if ([[data objectNilForKey:@"status"] integerValue] == 1) {//
        status = @"未到账";
        
    } else if ([[data objectNilForKey:@"status"] integerValue] == 3) {
        
        status = @"正常未还";
        
    }else if ([[data objectNilForKey:@"status"] integerValue] == 6) {
        
          status = @"逾期未还";
        
    }
    
    [rightImage addTapGestureWithBlock:^{
       
        CoinH5ViewController *vc = [[CoinH5ViewController alloc] init];
        vc.url =[data objectNilForKey:@"load_url"];
        [self.getCurrentViewController.navigationController pushViewController:vc animated:YES];
    }];
    NSArray *leftA = @[[data objectNilForKey:@"loan_agree_num"],
                       [data objectNilForKey:@"amount"],
                       [data objectNilForKey:@"interest"],[data objectNilForKey:@"rate"],@"¥0.00",[data objectNilForKey:@"days"],[data objectNilForKey:@"apply_date"],[data objectNilForKey:@"should_pay_date"],[data objectNilForKey:@"pay_type"],[data objectNilForKey:@"name"],[data objectNilForKey:@"bank_card"],[data objectNilForKey:@"repay_total"],status,[data objectNilForKey:@"overdue_pay"]];
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
