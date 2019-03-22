//
//  BCGoodView.h
//  弩币商城
//
//  Created by Jack on 2019/2/27.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BCGoodView : UIView<UITextFieldDelegate>
/**
 商品数量输入框
 */
@property (nonatomic, strong) UITextField *countTextField;
@property (nonatomic,copy)void(^backBlock)(id result);
- (instancetype)initWithFrame:(CGRect)frame andGoodID:(NSString *)ID withPara:(NSDictionary *)params;
@end

NS_ASSUME_NONNULL_END
