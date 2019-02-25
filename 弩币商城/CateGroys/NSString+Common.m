//
//  NSString+Common.m
//  Fast
//
//  Created by 詹姆斯 on 2017/8/28.
//  Copyright © 2017年 詹姆斯. All rights reserved.
//

#import "NSString+Common.h"

@implementation NSString (Common)

+ (NSString *)changePhoneText:(NSString *)phone {
    
    NSString *phoneStr = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    return phoneStr;
}
+ (NSString *)changePhoneTextToFormat:(NSString *)phoneString {
    
   
    NSMutableString *strOne = [NSMutableString stringWithString:phoneString];
    [strOne insertString:@" " atIndex:3];
    [strOne insertString:@" " atIndex:8];
    
    return strOne;
    
}

+ (NSString *)phoneNumberFormatter:(NSString *)phoneNumber {
   
       
    
    
    
    NSString *numberString = [phoneNumber stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    
    
    return numberString;
}
    

+(NSString *)changeToUTF8:(NSString *)content {
    
    
    NSString *newS = [content stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    
    return newS;
}
@end
