//
//  CoinPayMoneyOrderViewController.h
//  弩币商城
//
//  Created by Jack on 2019/3/19.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoinPayMoneyOrderViewController : CoinBaseViewController

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *orderNum;
@property (nonatomic, copy) NSString *money;

@end

NS_ASSUME_NONNULL_END
