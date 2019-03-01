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
@property (nonatomic,copy)void(^backBlock)(void);
- (instancetype)initWithFrame:(CGRect)frame andUserID:(NSString *)ID withMoney:(BOOL)isMoney;//是否是满减券
@end

NS_ASSUME_NONNULL_END
