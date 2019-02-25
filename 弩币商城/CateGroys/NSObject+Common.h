//
//  NSObject+Common.h
//  映币
//
//  Created by Jack on 2018/12/11.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Common)


/**
 *  判断是否是手机号码
 *
 *  @param mobileNum 字符串
 *
 *  @return bool
 */
- (BOOL)isMobileNumber:(NSString *)mobileNum;
@end
