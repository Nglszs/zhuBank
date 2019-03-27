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
    
    NSString *MOBILE = @"^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$";
//
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];

    return [regextestmobile evaluateWithObject:mobileNum];
    

    
}

@end
