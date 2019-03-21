//
//  CoinCooperationCompanyViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/20.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinCooperationCompanyViewController.h"

@interface CoinCooperationCompanyViewController ()
@property (nonatomic,strong)UILabel * nameLabel;
@property (nonatomic,strong)UIImageView * imageView;

@end

@implementation CoinCooperationCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"合作金融机构";
    [self initView1];
    [self initView2];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.DataDict[@"logo"]]];
    self.nameLabel.text = self.DataDict[@"name"];
    
}


- (void)initView1{
    UILabel *label = [[UILabel alloc] init];
    
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"由以下持牌机构提供贷款、放款等金融服务。" attributes:@{NSFontAttributeName: Regular(12),NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
    
    label.attributedText = string;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(19);
    }];
    
    UIView * LineView = [UIView new];
    LineView.backgroundColor = COLOR(238, 238, 238);
    [self.view addSubview:LineView];
  
    [LineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(0.5);
    }];
    
    UIImageView * imageView = [UIImageView new];
    
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label);
        make.top.equalTo(label.mas_bottom).offset(32);
        make.width.height.mas_equalTo(40);
    }];
    self.imageView = imageView;
    
}
- (void)initView2{
    
    UILabel *label = [[UILabel alloc] init];
    
    label.numberOfLines = 0;
    label.textColor = COLOR(51, 51, 51);
    label.font = Regular(15);
    [self.view addSubview:label];
    self.nameLabel = label;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imageView);
        make.left.equalTo(self.imageView.mas_right).offset(20);
    }];
}

- (void)setDataDict:(NSDictionary *)DataDict{
    _DataDict = DataDict;
   
}
@end
