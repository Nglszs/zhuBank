//
//  UITapGestureRecognizer+Common.m
//  Fast
//
//  Created by Jack on 2017/9/8.
//  Copyright © 2017年 詹姆斯. All rights reserved.
//

#import "UITapGestureRecognizer+Common.h"
#import <objc/runtime.h>
@implementation UITapGestureRecognizer (Common)

static void *blockKey = &blockKey;

- (void)setSuccessTap:(ClickTapGesture)successTap {
    objc_setAssociatedObject(self, &blockKey, successTap, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

- (ClickTapGesture)successTap {
    
    return objc_getAssociatedObject(self, &blockKey);
    
    
}



- (void)addtargetForBlock:(ClickTapGesture)clickTap {

    self.successTap = clickTap;

    [self addTarget:self action:@selector(clickTap)];

}
- (void)clickTap{
    
    
    if (self.successTap) {
        self.successTap();
    }
}

@end
