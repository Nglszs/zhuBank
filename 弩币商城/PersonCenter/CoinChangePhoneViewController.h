//
//  CoinChangePhoneViewController.h
//  弩币商城
//
//  Created by Jack on 2019/2/28.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoinChangePhoneViewController : CoinBaseViewController


/**
 yes 是修改手机号，no是修改交易密码
 */
@property(nonatomic, assign) BOOL isChangePhone;

@property (nonatomic, assign) BOOL isReset;

/**
 yes是设置交易密码，no是修改
 */
@property (nonatomic, assign) BOOL isSetPay;

@property (nonatomic, copy) NSString *phoneNum;//设置/修改交易密码时，手机号码传入

@end

NS_ASSUME_NONNULL_END
