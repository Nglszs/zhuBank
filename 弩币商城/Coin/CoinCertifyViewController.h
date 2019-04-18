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

// 1, 是身份验证 2是人脸识别 3是绑定银行卡  4 是信用分评估
@property(nonatomic, assign) NSInteger indexType;

@property (nonatomic, assign) BOOL isFenqi;//是否分期需要还是贷款需要认证


@property (nonatomic, copy) NSString *IDCard;//身份证

@property (nonatomic, copy) NSString *IDName;//姓名
@end

NS_ASSUME_NONNULL_END
