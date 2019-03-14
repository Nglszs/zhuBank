//
//  CoinInvoiceViewController.h
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/1.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^BCSelectInvoiceBlock)(NSString * invoice_rise,NSString * invoice_content);
@interface CoinInvoiceViewController : CoinBaseViewController
@property (nonatomic,copy)BCSelectInvoiceBlock block;
@end

NS_ASSUME_NONNULL_END
