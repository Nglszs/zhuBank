//
//  UITapGestureRecognizer+Common.h
//  Fast
//
//  Created by Jack on 2017/9/8.
//  Copyright © 2017年 詹姆斯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ClickTapGesture)(void);

@interface UITapGestureRecognizer (Common)

@property (nonatomic, copy) ClickTapGesture successTap;

/**
 点击手势block

 @param clickTap nil
 */
- (void)addtargetForBlock:(ClickTapGesture) clickTap;
@end
