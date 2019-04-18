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
    BRPayBuyCommodity// 购买商品支付首付
};
@interface CoinMemberBuyViewController : CoinBaseViewController
@property (nonatomic,assign)BRPayType type;
@property (nonatomic,copy)NSString * Money;
@property (nonatomic,copy)NSString * titleString;
@property (nonatomic,copy)NSString * IdStr;// 分期还款的ID
@property (nonatomic,copy)NSString * orderNum;// 订单号
@property (nonatomic,copy)NSString * orderID;// 订单ID
@property (nonatomic,strong)NSArray * DataArray;// 推荐数组
@end

NS_ASSUME_NONNULL_END
