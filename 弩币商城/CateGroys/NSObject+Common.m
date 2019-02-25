//
//  NSObject+Common.m
//  映币
//
//  Created by Jack on 2018/12/11.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "NSObject+Common.h"

@implementation NSObject (Common)


#pragma mark  判断是否为手机号码
- (BOOL)isMobileNumber:(NSString *)mobileNum {
    
//    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
//
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//
//    return [regextestmobile evaluateWithObject:mobileNum];
    
    NSString *regexStr = @"^1[3,8]\\d{9}|14[5,7,9]\\d{8}|15[^4]\\d{8}|17[^2,4,9]\\d{8}$";
    NSError *error;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:&error];
    if (error) return NO;
    NSInteger count = [regular numberOfMatchesInString:mobileNum options:NSMatchingReportCompletion range:NSMakeRange(0, mobileNum.length)];
    if (count > 0) {
        return YES;
    } else {
        return NO;
    }
    
   
    
}

@end
