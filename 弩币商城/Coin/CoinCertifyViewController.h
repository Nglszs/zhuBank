//
//  CoinCertifyViewController.h
//  弩币商城
//
//  Created by Jack on 2019/3/6.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoinCertifyViewController : CoinBaseViewController

// 1, 是身份验证  2是绑定银行卡  3 是信用分评估
@property(nonatomic, assign) NSInteger indexType;
@end

NS_ASSUME_NONNULL_END
