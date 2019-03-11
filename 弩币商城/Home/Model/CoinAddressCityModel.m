//
//  CoinAddressCityModel.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/11.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinAddressCityModel.h"

// 省
@implementation CoinAddressCityModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{@"idStr" : @"id",};
}

// 声明自定义类参数类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value使用[YYEatModel class]或YYEatModel.class或@"YYEatModel"没有区别
    return @{@"child_info" : [CoinAddressCityChildModel class]};
}

@end


// 市
@implementation CoinAddressCityChildModel


+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{@"idStr" : @"id",};
}

// 声明自定义类参数类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value使用[YYEatModel class]或YYEatModel.class或@"YYEatModel"没有区别
    return @{@"child_info2" : [CoinAddressCityChild2Mode class]};
}


@end


// 区
@implementation CoinAddressCityChild2Mode

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{@"idStr" : @"id",};
}


@end
