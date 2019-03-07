//
//  CoinClassLeftModel.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/7.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinClassLeftModel.h"

@implementation CoinClassLeftModel


+ (NSDictionary *)modelCustomPropertyMapper {
return @{@"typeId":@"id"};
}

// 声明自定义类参数类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value使用[YYEatModel class]或YYEatModel.class或@"YYEatModel"没有区别
    return @{@"tmenu" : [CoinClassRightModel class]};
}

@end


@implementation CoinClassRightModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"typeId":@"id"};
}

// 声明自定义类参数类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value使用[YYEatModel class]或YYEatModel.class或@"YYEatModel"没有区别
    return @{@"sub_menu" : [CoinClassItemModel class]};
}
@end


@implementation CoinClassItemModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"typeId":@"id"};
}



@end
