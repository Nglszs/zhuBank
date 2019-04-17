//
//  CoinSearchResultViewController.h
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/2/26.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoinSearchResultViewController : CoinBaseViewController
//搜索关键字
@property (nonatomic,copy)NSString * keyword;
@property (nonatomic,copy)NSString * classifyID;// 分类ID
@end

NS_ASSUME_NONNULL_END
