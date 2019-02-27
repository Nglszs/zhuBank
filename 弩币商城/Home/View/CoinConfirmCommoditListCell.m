//
//  CoinConfirmCommoditListCell.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/2/27.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinConfirmCommoditListCell.h"

@implementation CoinConfirmCommoditListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier leftTitle:(NSString *)leftTitleStr leftTitleColor:(UIColor *)leftTitleColor tagString:(NSString *)tagString rightStr:(NSString *)rightStr rightStrColor:(UIColor *)rightStrColor isShowSelectImage:(BOOL)isShowSelectImage{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self SetUILeftTitle:leftTitleStr leftTitleColor:leftTitleColor tagString:tagString rightStr:rightStr rightStrColor:rightStrColor isShowSelectImage:isShowSelectImage];
    }
    return self;
    
}
- (void)SetUILeftTitle:(NSString *)leftTitleStr leftTitleColor:(UIColor *)leftTitleColor tagString:(NSString *)tagString rightStr:(NSString *)rightStr rightStrColor:(UIColor *)rightStrColor isShowSelectImage:(BOOL)isShowSelectImage{
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
