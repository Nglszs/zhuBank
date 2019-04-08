//
//  BCUseCouPonView.h
//  弩币商城
//
//  Created by Jack on 2019/3/1.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BCUseCouPonView : UIView


@property (nonatomic,copy) void(^backBlock)(id result);
- (instancetype)initWithFrame:(CGRect)frame andUserID:(NSString *)ID withMoney:(NSInteger)isMoney withItemID:(NSString *)itemID endNum:(NSInteger)num;//0是现金券，1是运费q券

@property (nonatomic,copy)NSString * selectID;

@end

NS_ASSUME_NONNULL_END
