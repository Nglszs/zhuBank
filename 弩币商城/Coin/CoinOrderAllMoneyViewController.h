//
//  CoinOrderAllMoneyViewController.h
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/19.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinBaseViewController.h"


NS_ASSUME_NONNULL_BEGIN

// 订单 全款不分期的支付界面
@interface CoinOrderAllMoneyViewController : CoinBaseViewController

@property (nonatomic,copy)NSString * OrderID;
@property (nonatomic,copy)NSString * Money;
@end

NS_ASSUME_NONNULL_END
