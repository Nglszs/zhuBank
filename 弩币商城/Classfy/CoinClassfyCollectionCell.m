//
//  CoinClassfyCollectionCell.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/2/27.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinClassfyCollectionCell.h"
@interface CoinClassfyCollectionCell()
@property (nonatomic,strong)UIImageView * CommodityImage;
@property (nonatomic,strong)UILabel * titleLabel;
@end
@implementation CoinClassfyCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.CommodityImage = [UIImageView new];
    [self.contentView addSubview:self.CommodityImage];
    [self.CommodityImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.width.height.mas_equalTo(44);
        make.top.equalTo(self.contentView).offset(10);
    }];
    self.CommodityImage.backgroundColor = [UIColor redColor];
    self.titleLabel = [UILabel new];
    self.titleLabel.text = @"苹果";
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = TextFont(11);
    self.titleLabel.textColor = COLOR(102, 102, 102);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.CommodityImage);
        make.top.equalTo(self.CommodityImage.mas_bottom).offset(10);
        make.left.right.equalTo(self.contentView);
    }];
    
    
}
@end
