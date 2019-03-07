//
//  CoinClassfyLeftTVCell.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/2/26.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinClassfyLeftTVCell.h"

@interface CoinClassfyLeftTVCell()
@property (nonatomic,strong)UILabel * label;
@property (nonatomic,strong)UIView * LeftLineView;
@end
@implementation CoinClassfyLeftTVCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}
- (void)initView{
    self.label = [UILabel new];
    self.label.font = TextFont(15);
    self.label.textColor = COLOR(102, 102, 102);
    [self.contentView addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
    
    self.LeftLineView = [UIView new];
    self.LeftLineView.backgroundColor = COLOR(255, 41, 59);
    [self.contentView addSubview:self.LeftLineView];
    self.LeftLineView.hidden = YES;
    [self.LeftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.label);
        make.left.equalTo(self.contentView);
        make.width.mas_equalTo(1);
        make.centerY.equalTo(self.contentView);
    }];
    self.label.text = @"手机数码";
    
    
}

- (void)setIsSelect:(BOOL)isSelect{
    self.LeftLineView.hidden = !isSelect;
    
    self.label.textColor = isSelect ? COLOR(255, 41, 59) : COLOR(102, 102, 102);
    self.contentView.backgroundColor = isSelect?COLOR(238, 238, 238) : [UIColor whiteColor];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.label.text = title;
}


@end
