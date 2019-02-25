//
//  UITextField+Common.h
//  Fast
//
//  Created by 詹姆斯 on 2017/8/28.
//  Copyright © 2017年 詹姆斯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Common)
@property (nonatomic, strong) NSString *previousTextFieldContent;
@property (nonatomic, strong) UITextRange *previousSelection;
@property (nonatomic, assign) NSUInteger targetCursorPosition;



/**
 *  格式化手机号码
 */
- (void)textfieldWithPhoneNumber;



/**
 *  修改提示文字颜色
 *
 *  @param color 颜色
 */
- (void)changePlaceholderColor:(UIColor *)color;


/**
 *  修改提示文字大小
 *
 *  @param font 尺寸
 */
- (void)changePlaceholderFont:(UIFont *)font;


/**
 只能输入数字,适用手机号码，写在textfield代理中

 @param string 输入代理的string
 @return 是否可以
 */
- (BOOL)onlyInputNumber:(NSString *)string;



/**
 只能输入字母和数字，适用于密码，写在textfield代理中

 @param string 输入代理的string
 @return 是否可以
 */
- (BOOL)onlyInputNumberAndAlpha:(NSString *)string;
@end
