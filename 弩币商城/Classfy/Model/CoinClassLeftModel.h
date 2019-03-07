//
//  CoinClassLeftModel.h
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/7.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoinClassItemModel : NSObject

@property (nonatomic,copy)NSString * typeId;
@property (nonatomic,copy)NSString * name;
@property (nonatomic,copy)NSString * image;
@end


@interface CoinClassRightModel : NSObject

@property (nonatomic,copy)NSString * typeId;
@property (nonatomic,copy)NSString * name;
@property (nonatomic,strong)NSArray <CoinClassItemModel *> *sub_menu;
@end

@interface CoinClassLeftModel : NSObject

@property (nonatomic,copy)NSString * typeId;
@property (nonatomic,copy)NSString * name;
@property (nonatomic,strong)NSArray <CoinClassRightModel *> *tmenu;
@end
NS_ASSUME_NONNULL_END
