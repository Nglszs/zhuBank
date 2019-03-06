//
//  CoinMemberBuyViewController.h
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/4.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BRPayType) {
    BRPayBuyMember, // 购买会员
    BRPayRepayment, // 分期还款
};
@interface CoinMemberBuyViewController : CoinBaseViewController

@property (nonatomic,assign)BRPayType type;

@end

NS_ASSUME_NONNULL_END
