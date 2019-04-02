//
//  BCReturnMoneyView.h
//  弩币商城
//
//  Created by Jack on 2019/3/28.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BCReturnMoneyView : UIView<UITextFieldDelegate>
@property (nonatomic,strong)UITextField * passwordTF;
@property (nonatomic,copy)NSString * money;
@property (nonatomic,strong) UIButton *submitB;
@property (nonatomic,copy)void(^backBlock)(BOOL result);
- (instancetype)initWithFrame:(CGRect)frame money:(NSString *)money;
@end

NS_ASSUME_NONNULL_END
