//
//  CoinChangeAddressViewController.h
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/2/28.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoinChangeAddressViewController : CoinBaseViewController

@property (nonatomic,copy)NSString * address_id;
// 是否从确认订单进来的
@property (nonatomic,assign)BOOL isAffirmOrder;
@end

NS_ASSUME_NONNULL_END
