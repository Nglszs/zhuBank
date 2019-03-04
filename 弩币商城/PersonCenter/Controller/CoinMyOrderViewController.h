//
//  CoinMyOrderViewController.h
//  弩币商城
//
//  Created by Jack on 2019/3/4.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoinMyOrderViewController : CoinBaseViewController


/**
 1 代付款，3是待收货
 */
@property (nonatomic, assign) NSInteger  isNotPay;
@end

NS_ASSUME_NONNULL_END
