//
//  CoinSearchResultModel.h
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/7.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoinSearchResultModel : NSObject
@property (nonatomic,copy)NSString *  fenqi_info;
@property (nonatomic,copy)NSString * goods_id;

@property (nonatomic,copy)NSString *  goods_name;
@property (nonatomic,copy)NSString * original_img;
@property (nonatomic,copy)NSString *  shop_price;
@end

NS_ASSUME_NONNULL_END
