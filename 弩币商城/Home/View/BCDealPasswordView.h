//
//  BCDealPasswordView.h
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/26.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BRPaySuccess)(BOOL isSuccess);
@interface BCDealPasswordView : UIView

- (instancetype)initWithFrame:(CGRect)frame money:(NSString *)money;
@property (nonatomic,copy)BRPaySuccess success;

@property (nonatomic,weak)UIViewController * vc;
@end

NS_ASSUME_NONNULL_END
