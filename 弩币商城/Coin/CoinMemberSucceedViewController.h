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
    BRPayPaymentSuccess,// 支付首付成功
    BRPayAllMoneySuccess,// 付全款成功
    BRPayRepaySuccess // 还款成功
};

@interface CoinMemberSucceedViewController : CoinBaseViewController

@property (nonatomic,assign)BRPaySuccessType type;

@property (nonatomic,copy)NSString * Money;
@property (nonatomic,copy)NSString * order_id;
@property (nonatomic,copy)NSArray * dataArray;

@end

NS_ASSUME_NONNULL_END
