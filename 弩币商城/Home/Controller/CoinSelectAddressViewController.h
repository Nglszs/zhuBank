//
//  CoinSelectAddressViewController.h
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/2/28.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinBaseViewController.h"

typedef void(^BRSelectAddress)(NSString * addressID,NSString * name,NSString * phone,NSString * address_area,NSString * address);
NS_ASSUME_NONNULL_BEGIN

@interface CoinSelectAddressViewController : CoinBaseViewController
@property (nonatomic,copy)BRSelectAddress address;
@end

NS_ASSUME_NONNULL_END
