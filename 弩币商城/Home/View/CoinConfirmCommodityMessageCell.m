//
//  CoinConfirmCommodityMessageCell.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/2/28.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinConfirmCommodityMessageCell.h"
@interface CoinConfirmCommodityMessageCell()
@property (nonatomic,strong)UITextView * textView;
@end
@implementation CoinConfirmCommodityMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
    UILabel * titleLabel= [UILabel new];
    titleLabel.text = @"用户备注(50字)";
    [self.contentView addSubview:titleLabel];
    titleLabel.textColor = COLOR(102, 102, 102);
    titleLabel.font = Regular(13);
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.top.equalTo(self.contentView).offset(12);
     }];
    UIView * textView = [[UIView alloc] init];
    textView.layer.borderColor = COLOR(153, 153, 153).CGColor;
    textView.layer.borderWidth = 0.5;
    [self.contentView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.top.equalTo(titleLabel.mas_bottom).offset(8);
        make.bottom.equalTo(self.contentView).offset(-8);
    }];
    
    self.textView = [UITextView new];
    self.textView.font = Regular(10);
    self.textView.textColor = COLOR(183, 183, 183);
    [textView addSubview:self.textView];
    self.textView.text = @"选填";
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(textView);
        make.bottom.equalTo(textView).offset(-15);
    }];
    
    UILabel * label = [UILabel new];
    label.textColor = COLOR(183, 183, 183);
    label.text = @"50/50";
    label.font = Regular(10);
    [textView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(textView);
    }];
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
