//
//  CoinMyOrderTableViewCell.h
//  弩币商城
//
//  Created by Jack on 2019/3/4.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoinMyOrderTableViewCell : UITableViewCell


@property (nonatomic,strong)UIImageView * CommodityImage;
@property (nonatomic,strong)UILabel * CommodityNameLabel;
@property (nonatomic,strong)UILabel * CommodityPriceLabel;
@property (nonatomic,strong)UILabel * ByStagesLabel;

@property (nonatomic,strong) UIButton *cancelBtn,*payBtn,*enableBtn,*expressBtn,*serviceBtn;

// type = 0，代付款，1 代发货，2 确认收货，3 已完成
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andType:(NSUInteger)type;


@end

NS_ASSUME_NONNULL_END
