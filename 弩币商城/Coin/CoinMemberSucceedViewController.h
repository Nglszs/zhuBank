//
//  CoinMemberSucceedViewController.h
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/4.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BRPaySuccessType) {
    BRPaySuccessBuyMember,//购买会员卡成功
    BRPaySuccess,// 支付首付成功
};
// 支付成功界面得改
@interface CoinMemberSucceedViewController : CoinBaseViewController

@property (nonatomic,assign)BRPaySuccessType type;
@end

NS_ASSUME_NONNULL_END
