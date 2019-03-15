//
//  CoinBrowseStatusViewController.h
//  弩币商城
//
//  Created by Jack on 2019/3/5.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoinBrowseStatusViewController : CoinBaseViewController
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, assign) BOOL isBrowse;//yes是借款状态，no是放款状态
@end

NS_ASSUME_NONNULL_END
