//
//  CoinMemberCouponingCell.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/25.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinMemberCouponingCell.h"

@interface CoinMemberCouponingCell()
@property (nonatomic,strong)UIScrollView * scrollView;

@end
@implementation CoinMemberCouponingCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
    
}

- (void)initView{
    
    self.scrollView = [[UIScrollView alloc] init];
    [self.contentView addSubview:self.scrollView];
    self.scrollView.shouldHideToolbarPlaceholder = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
}
- (UIView *)setView:(NSDictionary *)dict index:(int)index{
    UIView * view = [UIView new];
   
    return view;
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
