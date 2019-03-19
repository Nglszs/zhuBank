//
//  CoinOrderSuccessViewController.m
//  弩币商城
//
//  Created by Jack on 2019/3/4.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinOrderSuccessViewController.h"

@interface CoinOrderSuccessViewController ()

@property (nonatomic,strong)UIImageView * CommodityImage;
@property (nonatomic,strong)UILabel * CommodityNameLabel;
@property (nonatomic,strong)UILabel * CommodityPriceLabel;
@end

@implementation CoinOrderSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.navigationItem.title = @"确认收货成功";
    
    self.view.backgroundColor = DIVI_COLOR;
    
    
    [self initView];
}

- (void)initView {
    
    UIView *backV = [[UIView alloc] init];
    backV.backgroundColor = White;
    [self.view addSubview:backV];
    [backV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.mas_equalTo(0);
        make.width.mas_equalTo(BCWidth);
        make.height.mas_equalTo(150);
    }];
    
    UIImageView *leftI = [[UIImageView alloc]init];
    leftI.image = BCImage(图层 3);
    [backV addSubview:leftI];
    [leftI mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(50);
        
    }];
    
    
    UILabel *leftL = [[UILabel alloc] init];
    leftL.text = @"确认收货成功！";
    leftL.textColor = COLOR(153, 153, 153);
    leftL.font = Regular(12);
    [backV addSubview:leftL];
    [leftL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(leftI.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(12);
        
    }];
    
    
    UIView *bottomV = [[UIView alloc] init];
    bottomV.backgroundColor = White;
    [self.view addSubview:bottomV];
    [bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(0);
        make.top.equalTo(backV.mas_bottom).offset(10);
        make.width.mas_equalTo(BCWidth);
        make.height.mas_equalTo(70);
    }];
    
    
    self.CommodityImage = [UIImageView new];
    self.CommodityImage.backgroundColor = [UIColor grayColor];
    [bottomV addSubview:self.CommodityImage];
    [self.CommodityImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(7);
        make.left.mas_equalTo(30);
        
        make.width.height.mas_equalTo(50);
    }];
    
    self.CommodityNameLabel = [UILabel new];
    
//    self.CommodityNameLabel.text = @"贵州茅乡酒  M10浓香型白酒 52度送礼白";
    self.CommodityNameLabel.textColor = TITLE_COLOR;
    self.CommodityNameLabel.font = Regular12Font;
    [bottomV addSubview:self.CommodityNameLabel];
    [self.CommodityNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.CommodityImage.mas_right).offset(28);
        make.top.equalTo(self.CommodityImage.mas_top).offset(1);
        make.right.mas_equalTo(-30);
        
    }];
    
    
    UILabel *sizeL = [[UILabel alloc] init];
    sizeL.textColor = COLOR(102, 102, 102);
    sizeL.font = Regular(10);
//    sizeL.text = @"选择规格：xxx";
    [bottomV addSubview:sizeL];
    [sizeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.CommodityNameLabel.mas_left);
        make.top.equalTo(self.CommodityNameLabel.mas_bottom).offset(6);
        make.height.mas_equalTo(10);
    }];
    
    
    
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"¥6088.00 x1"];
//    NSDictionary * firstAttributes = @{NSForegroundColorAttributeName: COLOR(153, 153, 153)};
//    [str setAttributes:firstAttributes range:NSMakeRange(str.length - 2,2)];
    self.CommodityPriceLabel = [UILabel new];
    
    self.CommodityPriceLabel.textColor = TITLE_COLOR;
//    self.CommodityPriceLabel.attributedText = str;
    self.CommodityPriceLabel.font = Regular(10);
    [bottomV addSubview:self.CommodityPriceLabel];
    [self.CommodityPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.CommodityNameLabel);
        make.height.mas_equalTo(10);
        make.top.equalTo(sizeL.mas_bottom).offset(6);
    }];
    
    
    [self.CommodityImage sd_setImageWithURL:[NSURL URLWithString:_imageUrl]];
    
    
    self.CommodityNameLabel.text = _name;
    
    
    sizeL.text = [NSString stringWithFormat:@"选择规格：%@",_size];
    
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@ x%@",_price,_num]];
    NSDictionary * firstAttributes = @{NSForegroundColorAttributeName: COLOR(153, 153, 153)};
    [str setAttributes:firstAttributes range:NSMakeRange(str.length - _num.length - 1,_num.length)];
    self.CommodityPriceLabel.attributedText = str;
    
    
    
}


@end
