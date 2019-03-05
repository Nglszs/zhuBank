//
//  CoinOrderDetailsViewController.h
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/5.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, BROrderType) {
    BROrderNotPay, // 待付款
    BROrderNotDispatch, // 待发货
    BROrderNotEnable,// 待收货
    BROrderFinsh,//已完成
};

@interface CoinOrderDetailsViewController : CoinBaseViewController

@property (nonatomic,assign)BROrderType type;
@end

NS_ASSUME_NONNULL_END
