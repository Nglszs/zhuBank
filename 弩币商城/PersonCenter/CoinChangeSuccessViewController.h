//
//  CoinChangeSuccessViewController.h
//  弩币商城
//
//  Created by Jack on 2019/2/28.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoinChangeSuccessViewController : CoinBaseViewController
/**
 yes 是修改手机号成功，no是修改登录密码成功
 */
@property(nonatomic,assign) BOOL isChangePhone;
@end

NS_ASSUME_NONNULL_END
