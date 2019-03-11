//
//  CoinChangeAddressView.h
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/2/28.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoinAddressCityModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CoinChangeAddressView : UIView
@property (nonatomic,copy)NSArray<CoinAddressCityModel *>  * dataArray;
@end

NS_ASSUME_NONNULL_END
