//
//  NSString+Common.h
//  Fast
//
//  Created by 詹姆斯 on 2017/8/28.
//  Copyright © 2017年 詹姆斯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Common)
/**
 *  去掉格式化手机号码的空格
 *
 *  @param phone 电话号码
 *
 *  @return 正常电话号码
 */
+ (NSString *)changePhoneText:(NSString *)phone;


/**
 *  电话号码格式化
 *
 *  @param phoneString 电话号码
 *
 *  @return 字符串
 */
+ (NSString *)changePhoneTextToFormat:(NSString *)phoneString;



/**
 将手机号码中间4位隐藏

 @param phoneNumber 电话号码
 @return nil
 */
+(NSString *)phoneNumberFormatter:(NSString *)phoneNumber;



/**
 utf8编码

 @param content 内容
 @return nil
 */
+(NSString *)changeToUTF8:(NSString *)content;
@end
