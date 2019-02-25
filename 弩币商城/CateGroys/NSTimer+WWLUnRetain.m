//
//  NSTimer+WWLUnRetain.m
//  WormwormLife
//
//  Created by Rocco on 2018/5/8.
//  Copyright © 2018年 张文彬. All rights reserved.
//

#import "NSTimer+WWLUnRetain.h"

@implementation NSTimer (WWLUnRetain)

+ (NSTimer *)wwl_scheduledTimerWithTimeInterval:(NSTimeInterval)inerval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block{
    return [NSTimer scheduledTimerWithTimeInterval:inerval target:self selector:@selector(wwl_blcokInvoke:) userInfo:[block copy] repeats:repeats];
    
}

+ (void)wwl_blcokInvoke:(NSTimer *)timer {
    void (^block)(NSTimer *timer) = timer.userInfo;
    if (block) {
        block(timer);
    }
}

@end
