//
//  NSDictionary+Common.h
//  Fast
//
//  Created by 詹姆斯 on 2017/8/28.
//  Copyright © 2017年 詹姆斯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Common)


/**
 避免取到空值

 @param key nil
 @return nil
 */
- (id)objectNilForKey:(id)key;


/**
 递归去掉所有的null

 @param myObj ni
 @return nil
 */
+ (id)cleanNull:(id)myObj;
@end
