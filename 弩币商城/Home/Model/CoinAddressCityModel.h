//
//  CoinAddressCityModel.h
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/11.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


// 区或者县
@interface CoinAddressCityChild2Mode: NSObject
@property (nonatomic,copy)NSString * parent_id;
@property (nonatomic,copy)NSString * idStr;
@property (nonatomic,copy)NSString * level;
@property (nonatomic,copy)NSString * name;
@end


// 市
@interface CoinAddressCityChildModel : NSObject

@property (nonatomic,copy)NSString * parent_id;
@property (nonatomic,copy)NSString * idStr;
@property (nonatomic,copy)NSArray<CoinAddressCityChild2Mode *> * child_info2;
@property (nonatomic,copy)NSString * level;
@property (nonatomic,copy)NSString * name;
@end

// 省
@interface CoinAddressCityModel : NSObject
@property (nonatomic,copy)NSString * parent_id;
@property (nonatomic,copy)NSString * idStr;
@property (nonatomic,copy)NSArray<CoinAddressCityChildModel *> * child_info;
@property (nonatomic,copy)NSString * level;
@property (nonatomic,copy)NSString * name;
@end






NS_ASSUME_NONNULL_END
