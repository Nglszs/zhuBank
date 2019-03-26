//
//  CoinExpressCouponTableViewCell.h
//  弩币商城
//
//  Created by Jack on 2019/3/1.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoinExpressCouponTableViewCell : UITableViewCell
@property (nonatomic , assign) NSInteger type;//1是已使用，2是已过期
@property (nonatomic , strong) UIButton *activityBtn;
- (void)setDataForCell:(NSDictionary *)data;
@end

NS_ASSUME_NONNULL_END
