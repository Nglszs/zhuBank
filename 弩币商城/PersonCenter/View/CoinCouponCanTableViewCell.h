//
//  CoinCouponCanTableViewCell.h
//  弩币商城
//
//  Created by Jack on 2019/3/1.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoinCouponCanTableViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView * CommodityImage;
@property (nonatomic,strong)UILabel * CommodityNameLabel;
@property (nonatomic,strong)UILabel * CommodityPriceLabel;
@property (nonatomic,strong)UILabel * ByStagesLabel;
- (void)setValueForCell:(NSDictionary *)data;
@end

NS_ASSUME_NONNULL_END
