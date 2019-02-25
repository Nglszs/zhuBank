//
//  NSArray+Common.h
//  映币
//
//  Created by Jack on 2018/12/11.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Common)


/**
 避免取到数组越界

 @param index nil
 @return nil
 */
- (id)objectAtIndexCheck:(NSUInteger)index;
@end
