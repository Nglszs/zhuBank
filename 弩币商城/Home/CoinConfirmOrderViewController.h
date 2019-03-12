//
//  CoinConfirmOrderViewController.h
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/2/27.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoinConfirmOrderViewController : CoinBaseViewController

@property (nonatomic,copy)NSString * q_fenqi; // 是否分期
@property (nonatomic,copy)NSString * goods_id; // 商品id
@property (nonatomic,copy)NSString * item_id; // 规格id
@property (nonatomic,copy)NSString * num;// 购买数量
@property (nonatomic,copy)NSString * periods;// 期数
@property (nonatomic,copy)NSString * stages;// 首付比例
@end

NS_ASSUME_NONNULL_END
