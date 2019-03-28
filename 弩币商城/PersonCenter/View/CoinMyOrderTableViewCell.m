//
//  CoinMyOrderTableViewCell.m
//  弩币商城
//
//  Created by Jack on 2019/3/4.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinMyOrderTableViewCell.h"

@implementation CoinMyOrderTableViewCell
{
    
    NSUInteger orderType;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andType:(NSUInteger)type {
    
    
    orderType = type;
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier];
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = DIVI_COLOR;
        [self initView];
    }
    return self;
}

- (void)initView {
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = White;
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(10);
        make.width.mas_equalTo(BCWidth);
        make.left.mas_equalTo(0);
        if (orderType == 1 || orderType == 4) {//如果是代发货，则没有任何按钮
           make.height.mas_equalTo(148);
        } else {
            
            make.height.mas_equalTo(187);
        }
        
    }];
    
    
//  订单编号
    UILabel *leftL = [[UILabel alloc] init];
    leftL.text = @"订单编号：31413414";
    leftL.textColor = TITLE_COLOR;
    leftL.font = Regular(12);
    leftL.tag = 100;
    [backView addSubview:leftL];
    [leftL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(LEFT_Margin);
        make.height.mas_equalTo(36);
        
    }];
    
    UILabel *rightL = [[UILabel alloc] init];
   rightL.textColor = COLOR(255, 0,0);
    rightL.font = Regular(12);
    [backView addSubview:rightL];
    [rightL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-LEFT_Margin);
        make.height.mas_equalTo(36);
        
    }];
    
    self.CommodityImage = [UIImageView new];
    self.CommodityImage.backgroundColor = [UIColor grayColor];
    [backView addSubview:self.CommodityImage];
    [self.CommodityImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(leftL.mas_bottom);
        make.left.mas_equalTo(LEFT_Margin);
        
        make.width.height.mas_equalTo(75);
    }];
    
    self.CommodityNameLabel = [UILabel new];
   
    self.CommodityNameLabel.text = @"贵州茅乡酒  M10浓香型白酒 52度送礼白";
    self.CommodityNameLabel.textColor = TITLE_COLOR;
    self.CommodityNameLabel.font = Regular12Font;
    [backView addSubview:self.CommodityNameLabel];
    [self.CommodityNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.CommodityImage.mas_right).offset(28);
        make.top.equalTo(self.CommodityImage.mas_top).offset(8);
        make.right.equalTo(self.contentView).offset(-30);
        
    }];
    
    
    UILabel *sizeL = [[UILabel alloc] init];
    sizeL.textColor = COLOR(102, 102, 102);
    sizeL.font = Regular(10);
    sizeL.tag = 200;
    sizeL.text = @"选择规格：xxx";
    [backView addSubview:sizeL];
    [sizeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.CommodityNameLabel.mas_left);
        make.top.equalTo(self.CommodityNameLabel.mas_bottom).offset(6);
        make.height.mas_equalTo(10);
    }];
    
    
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"¥6088.00 x1"];
    NSDictionary * firstAttributes = @{NSForegroundColorAttributeName: COLOR(153, 153, 153)};
    [str setAttributes:firstAttributes range:NSMakeRange(str.length - 2,2)];
    self.CommodityPriceLabel = [UILabel new];
   
    self.CommodityPriceLabel.textColor = COLOR(102, 102, 102);
     self.CommodityPriceLabel.attributedText = str;
    self.CommodityPriceLabel.font = Regular(10);
    [backView addSubview:self.CommodityPriceLabel];
    [self.CommodityPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.CommodityNameLabel);
        make.height.mas_equalTo(10);
        make.top.equalTo(sizeL.mas_bottom).offset(6);
    }];
    
    
    
    
    self.ByStagesLabel = [[UILabel alloc] init];
     self.ByStagesLabel.textColor = COLOR(255, 0, 0);
     self.ByStagesLabel.font = Regular(10);
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:@"首付：43  月供：23  期数：2"];
    
    NSDictionary * firstAttributes1 = @{NSForegroundColorAttributeName: COLOR(153, 153, 153)};
    [string2 setAttributes:firstAttributes1 range:NSMakeRange(0,3)];
    
    
    self.ByStagesLabel.attributedText = string2;
    [self.contentView addSubview:self.ByStagesLabel];
    [self.ByStagesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.CommodityPriceLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(10); make.left.right.equalTo(self.CommodityNameLabel);
    }];
    
    
    UILabel *timeL = [[UILabel alloc] init];
    timeL.text = @"共1件商品  合计：￥82.00 ";
    timeL.textColor = TITLE_COLOR;
    timeL.tag = 300;
    timeL.font = Regular(13);
    [backView addSubview:timeL];
    [timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-LEFT_Margin);
        make.top.equalTo(self.CommodityImage.mas_bottom).offset(0);
        make.height.mas_equalTo(36);
    }];
    
   
    
    
    if (orderType == 0) {
         rightL.text = @"待付款";
        
        NSArray *titleA = @[@"立即付款",@"取消订单"];
        for (int i = 0; i < titleA.count ; i++) {
            UIButton *activityBtn = [UIButton new];
          
            [activityBtn setTitle:titleA[i] forState:UIControlStateNormal];
            [activityBtn.titleLabel setFont:Regular(14)];
            activityBtn.layer.borderWidth = 1;
            activityBtn.layer.borderColor = COLOR(153, 153, 153).CGColor;
            
            activityBtn.layer.cornerRadius = 13.5;
            [backView addSubview:activityBtn];
            
            
            [activityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(-12);
                make.right.mas_equalTo(-LEFT_Margin - i*(98));
                
                make.size.mas_equalTo(CGSizeMake(86, 27));
            }];
            
            
            if (i == 0) {
                
                  [activityBtn setTitleColor:White forState:UIControlStateNormal];
                activityBtn.backgroundColor = COLOR(255, 0, 0);
                 activityBtn.layer.borderWidth = 0;
                
                _payBtn = activityBtn;
            } else {
                _cancelBtn = activityBtn;
                  [activityBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
            }
            
        }
        
        
        
    } else if (orderType == 1) {
        
         rightL.text = @"待发货";
    } else if (orderType == 2) {
        
         rightL.text = @"待收货";
        
        NSArray *titleA = @[@"确认收货",@"查看物流",@"联系客服"];
        for (int i = 0; i < titleA.count ; i++) {
            UIButton *activityBtn = [UIButton new];
            
            [activityBtn setTitle:titleA[i] forState:UIControlStateNormal];
            [activityBtn.titleLabel setFont:Regular(14)];
            activityBtn.layer.borderWidth = 1;
            activityBtn.layer.borderColor = COLOR(153, 153, 153).CGColor;
             [activityBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
            activityBtn.layer.cornerRadius = 13.5;
            [backView addSubview:activityBtn];
            
            
            [activityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(-12);
                make.right.mas_equalTo(-LEFT_Margin - i*(98));
                
                make.size.mas_equalTo(CGSizeMake(86, 27));
            }];
            
            
            if (i == 0) {
                
                [activityBtn setTitleColor:White forState:UIControlStateNormal];
                activityBtn.backgroundColor = COLOR(255, 0, 0);
                activityBtn.layer.borderWidth = 0;
                
                _enableBtn = activityBtn;
            } else if(i == 1){
                _expressBtn = activityBtn;
               
            } else {
                _serviceBtn = activityBtn;
                
            }
            
        }
        
    } else if (orderType == 3){
        
        rightL.text = @"已完成";
        
        NSArray *titleA = @[@"联系客服",@"查看物流"];
        for (int i = 0; i < titleA.count ; i++) {
            UIButton *activityBtn = [UIButton new];
            
            [activityBtn setTitle:titleA[i] forState:UIControlStateNormal];
            [activityBtn.titleLabel setFont:Regular(14)];
            activityBtn.layer.borderWidth = 1;
            activityBtn.layer.borderColor = COLOR(153, 153, 153).CGColor;
              [activityBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
            activityBtn.layer.cornerRadius = 13.5;
            [backView addSubview:activityBtn];
            
            
            [activityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(-12);
                make.right.mas_equalTo(-LEFT_Margin - i*(98));
                
                make.size.mas_equalTo(CGSizeMake(86, 27));
            }];
            
            
            if (i == 0) {
                
               
                
                _serviceBtn = activityBtn;
            } else {
                _expressBtn = activityBtn;
              
            }
            
        }
        
    } else {
        
         rightL.text = @"已取消";
    }
    
    
    
}

- (void)setDataForValue:(NSDictionary *)data {
    
    
    [self.CommodityImage sd_setImageWithURL:[data objectForKey:@"original_img"]];
    
    UILabel *leftL = [self.contentView viewWithTag:100];
    leftL.text = [NSString stringWithFormat:@"订单编号：%@",[data objectForKey:@"order_sn"]];
    
    self.CommodityNameLabel.text = [data objectForKey:@"goods_name"];
    
    UILabel *sizeL = [self.contentView viewWithTag:200];
    sizeL.text = [NSString stringWithFormat:@"选择规格：%@",[data objectForKey:@"spec_key_name"]];
    
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@ x%@",[data objectForKey:@"goods_price"],[data objectForKey:@"goods_num"]]];
    NSDictionary * firstAttributes = @{NSForegroundColorAttributeName: COLOR(153, 153, 153)};
    [str setAttributes:firstAttributes range:NSMakeRange(str.length - [[data objectForKey:@"goods_num"] stringValue].length - 1,[[data objectForKey:@"goods_num"] stringValue].length)];
    self.CommodityPriceLabel.attributedText = str;
    
    
    
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"首付：%@  月供：%@  期数：%@",[data objectForKey:@"first_pay"],[data objectForKey:@"per_return_money"],[data objectForKey:@"period"]]];
    
    NSDictionary * firstAttributes1 = @{NSForegroundColorAttributeName: COLOR(153, 153, 153)};
    [string2 setAttributes:firstAttributes1 range:NSMakeRange(0,3)];
     [string2 setAttributes:firstAttributes1 range:NSMakeRange(5 + [[data objectForKey:@"first_pay"] length],3)];
    [string2 setAttributes:firstAttributes1 range:NSMakeRange(5 + [[data objectForKey:@"first_pay"] length] + [[data objectForKey:@"per_return_money"] length] + 5,3)];
    
    self.ByStagesLabel.attributedText = string2;
   
    if ([[data objectForKey:@"is_fenqi"] integerValue] == 0) {//未分期隐藏
        self.ByStagesLabel.hidden = YES;
    }
    
//
    UILabel *timeL = [self.contentView viewWithTag:300];
    timeL.text = [NSString stringWithFormat:@"共%@件商品  合计：￥%@",[data objectForKey:@"goods_num"],[data objectForKey:@"order_amount"]];
    
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
