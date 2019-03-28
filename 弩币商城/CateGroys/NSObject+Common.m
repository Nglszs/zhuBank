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
-(BOOL)isBankCard:(NSString *)cardNumber{
    
  if(cardNumber.length==0){
        
    return NO;
        
   }
    
 NSString *digitsOnly = @"";
    
 char c;
    
   for (int i = 0; i < cardNumber.length; i++){
        
       c = [cardNumber characterAtIndex:i];
        
       if (isdigit(c)){
            
       digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
            
         }
        
       }
    
   int sum = 0;
    
    int digit = 0;
    
   int addend = 0;
    
    BOOL timesTwo = false;
    
  for (NSInteger i = digitsOnly.length - 1; i >= 0; i--){
        
       digit = [digitsOnly characterAtIndex:i] - '0';
        
  if (timesTwo){
            
addend = digit * 2;
            
   if (addend > 9) {
                
           addend -= 9;
                
      }
            
   }
        
   else {
            
 addend = digit;
            
            }
        
   sum += addend;
        
    timesTwo = !timesTwo;
        
     }
    
 int modulus = sum % 10;
    
 return modulus == 0;
    
}

@end
