//
//  NSTimer+WWLUnRetain.h
//  WormwormLife
//
//  Created by Rocco on 2018/5/8.
//  Copyright © 2018年 张文彬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (WWLUnRetain)

+ (NSTimer *)wwl_scheduledTimerWithTimeInterval:(NSTimeInterval)inerval
                                        repeats:(BOOL)repeats
                                          block:(void(^)(NSTimer *timer))block;

@end
