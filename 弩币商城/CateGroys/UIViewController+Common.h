//
//  UIViewController+Common.h
//  映币
//
//  Created by Jack on 2018/12/11.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Common)



//显示系统弹窗

- (void)showSystemAlertTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle cancel:(void(^)(void))cancel confirm:(void(^)(void))confirm;


//显示系统底部选择栏

- (void)showSystemSheetTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSArray *)buttonArray handler:(void(^)(NSUInteger buttonIndex)) handler;
@end
