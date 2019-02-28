//
//  CoinChangePayCodeViewController.h
//  弩币商城
//
//  Created by Jack on 2019/2/28.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoinChangePayCodeViewController : CoinBaseViewController
/**
 yes 是修改交易密码，no是设置交易密码
 */
@property(nonatomic,assign) BOOL isChangePay;
@end

NS_ASSUME_NONNULL_END
