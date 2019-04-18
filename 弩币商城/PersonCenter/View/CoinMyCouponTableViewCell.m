//
//  CoinMyCouponTableViewCell.m
//  弩币商城
//
//  Created by Jack on 2019/3/1.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinMyCouponTableViewCell.h"

@implementation CoinMyCouponTableViewCell

{
    UIView *backView;
     NSMutableArray *bottomArr;
    UIView *bottomV;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.contentView.backgroundColor = ThemeColor;
         bottomArr = [NSMutableArray arrayWithCapacity:1];
        [self initView];
        
    }
    
    return self;
}


- (void)initView {
    
    
    backView = [[UIView alloc] init];
    backView.backgroundColor = COLOR(255, 241, 235);
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.mas_equalTo(LEFT_Margin);
        make.right.mas_equalTo(-LEFT_Margin);
        make.height.mas_equalTo(100);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
    
    
    UIImageView *leftI = [[UIImageView alloc] init];
    leftI.image = BCImage(矩形 15 拷贝 3);
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
    priceL.tag = 100;
    priceL.textColor = COLOR(254, 100, 38);
    priceL.font = Regular(17);
//    priceL.attributedText = str;
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
        
        make.left.equalTo(priceL.mas_right).offset(10);
        make.bottom.equalTo(priceL);
        make.height.mas_equalTo(11);
    }];
    
    
//    满多少可用
    UILabel *useL = [[UILabel alloc] init];
    useL.text = @"满3000 使用";
    useL.textColor = TITLE_COLOR;
    useL.tag = 200;
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
    timeL.tag = 300;
    timeL.font = Regular(10);
    [backView addSubview:timeL];
    [timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(useL.mas_left);
        make.top.equalTo(useL.mas_bottom).offset(5);
        make.height.mas_equalTo(10);
    }];
    
    
//  详细信息
    UIButton *backBtn= [[UIButton alloc] init];
    [backBtn setTitle:@"详细信息" forState:UIControlStateNormal];
    backBtn.hidden = ![Tool AuditState];
    [backBtn setTitleColor:COLOR(167, 167, 167) forState:UIControlStateNormal];
    backBtn.titleLabel.font = Regular11Font;
    backBtn.contentHorizontalAlignment = 1;
    [backBtn setImage:BCImage(圆角矩形 7 拷贝) forState:UIControlStateNormal];
    [backView addSubview:backBtn];
    _detailBtn = backBtn;
  
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
        make.top.mas_equalTo(21);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(58);
    }];
     _activityBtn = [UIButton new];
    [_activityBtn setTitleColor:COLOR(254, 100, 38) forState:UIControlStateNormal];
    [_activityBtn setTitle:@"立即使用" forState:UIControlStateNormal];
    [_activityBtn.titleLabel setFont:Regular(12)];
    _activityBtn.layer.borderWidth = 1;
    _activityBtn.layer.borderColor = COLOR(254, 100, 38).CGColor;
    _activityBtn.tag = 1000;
    _activityBtn.layer.cornerRadius = 8;
    [backView addSubview:_activityBtn];
    
    
    [_activityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
}

- (void)setDataForCell:(NSDictionary *)data {
    
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",[data objectNilForKey:@"money"]]];
    NSDictionary * firstAttributes = @{ NSFontAttributeName:Regular11Font};
    [str setAttributes:firstAttributes range:NSMakeRange(0,1)];
    UILabel *money = [self.contentView viewWithTag:100];
    money.attributedText = str;
    
    
    UIButton *useBtn = [backView viewWithTag:1000];
    if (_type == 1) {
        [useBtn setTitle:@"已使用" forState:UIControlStateNormal];
        useBtn.layer.borderWidth = 0;
    }
    
    if (_type == 2) {
        [useBtn setTitle:@"已过期" forState:UIControlStateNormal];
        useBtn.layer.borderWidth = 0;
    }
    
     UILabel *useL = [self.contentView viewWithTag:200];
     useL.text =[NSString stringWithFormat: @"满%@使用",[data objectNilForKey:@"condition"]];
    
    UILabel *timeL = [self.contentView viewWithTag:300];
    timeL.text =[NSString stringWithFormat: @"有效期%@",[data objectNilForKey:@"period"]];
    
    [bottomArr removeAllObjects];
    [bottomArr addObject:[data objectForKey:@"tips"]];
    NSArray *dataA = [data objectForKey:@"appoint_goods_name"];
    if (dataA.count > 0) {
        [bottomArr addObjectsFromArray:dataA];
    }
    
    if (!bottomV) {
        bottomV = [[UIView alloc] init];
        [backView addSubview:bottomV];
        _detailV = bottomV;
        [bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(85);
            make.height.mas_equalTo(15 * (bottomArr.count - 1));
            make.width.mas_equalTo(BCWidth);
            
        }];
        bottomV.hidden = YES;
    }
   
    
   
  [[bottomV subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i = 0; i < bottomArr.count; i ++) {
        
        UILabel *moneyL1 = [[UILabel alloc] init];
        
        moneyL1.textColor = COLOR(167, 167, 167);
        moneyL1.font = Regular(11);
        [bottomV addSubview:moneyL1];
        [moneyL1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(90);
            make.top.mas_equalTo(15 * i);
            make.height.mas_equalTo(10);
            make.width.mas_equalTo(BCWidth - 120);
        }];
        
        if (i == 0) {
            moneyL1.text = [bottomArr objectAtIndex:i];
        } else {
            
            moneyL1.text = [NSString stringWithFormat:@"限分期购买%@使用",[[bottomArr objectAtIndex:i] objectForKey:@"good_name"]];
        }
        
    }
    
    
}

+ (CGFloat)getCellHeight:(NSDictionary *)data {
    NSMutableArray *bottomArr = [NSMutableArray arrayWithCapacity:1];
    [bottomArr addObject:[data objectForKey:@"tips"]];
    NSArray *dataA = [data objectForKey:@"appoint_goods_name"];
    if (dataA.count > 0) {
        [bottomArr addObjectsFromArray:dataA];
    }
    return 115 + bottomArr.count*15;
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
