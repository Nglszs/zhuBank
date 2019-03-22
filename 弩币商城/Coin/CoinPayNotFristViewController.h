//
//  CoinPayNotFristViewController.h
//  弩币商城
//
//  Created by Jack on 2019/3/19.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoinPayNotFristViewController : CoinBaseViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *orderNum;
@property (nonatomic,strong)NSArray * dataArray;// 推荐商品

@end

NS_ASSUME_NONNULL_END
