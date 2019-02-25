//
//  UIViewController+Common.m
//  映币
//
//  Created by Jack on 2018/12/11.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "UIViewController+Common.h"

@implementation UIViewController (Common)

- (void)showSystemAlertTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle cancel:(void (^)(void))cancel confirm:(void (^)(void))confirm {
    
    
      UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
   
       
    if (cancelTitle.length > 0) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancel) {
                cancel();
            }
        }];
        [alert addAction:cancelAction];
    }
    
   
       
    
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (confirm) {
            confirm();
        };
    }];
    
    [alert addAction:defaultAction];
    
    
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)showSystemSheetTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSArray *)buttonArray handler:(void (^)(NSUInteger)) handler{
    
    
    
    UIAlertController *sheetController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    
   
    
    
    for (int i = 0; i < buttonArray.count; i ++) {
        
        UIAlertAction *confimAction = [UIAlertAction actionWithTitle:buttonArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (handler) {
                handler((i));
            }
           
        }];
        [sheetController addAction:confimAction];
    }
    
    
   
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
   
 
    
    [sheetController addAction:cancelAction];
    
    [self presentViewController:sheetController animated:YES completion:nil];
}
@end
