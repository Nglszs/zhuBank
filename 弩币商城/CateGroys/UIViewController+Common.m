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

- (void)SetNavTitleColor{
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:Regular(17),  NSForegroundColorAttributeName:COLOR(51, 51, 51)}];
    
}
- (void)SetReturnButton{
    UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(0, 0, 25, 25);
    [btn addTarget:self action:@selector(BackAction) forControlEvents:(UIControlEventTouchUpInside)];
    UIView * view = [[UIView alloc] initWithFrame: btn.bounds];
    [view addSubview:btn];
    [btn setImage:[UIImage imageNamed:@"Back"] forState:(UIControlStateNormal)];
    [btn setImage:[UIImage imageNamed:@"Back"] forState:(UIControlStateHighlighted)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    btn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
}

- (void)setNavitem:(NSString *)title type:(SetNavItem)type{
    if (title == nil) {
        if (type == LeftNavItem) {
            self.navigationItem.leftBarButtonItem = nil;
        }else{
            self.navigationItem.rightBarButtonItem = nil;
        }
        
        return;
    }
    SEL jj;
    if (type == LeftNavItem) {
        jj = @selector(LeftItemAction);
    }else{
        jj = @selector(RightItemAction);
    }
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithTitle:title style:(UIBarButtonItemStyleDone) target:self action:jj];
    UILabel * label = [UILabel new];
    
    label.font = TextFont(12);
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:label.font,NSFontAttributeName, nil] forState:UIControlStateNormal];
     [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:label.font,NSFontAttributeName, nil] forState:UIControlStateHighlighted];
    if (type == LeftNavItem) {
        self.navigationItem.leftBarButtonItem = item;
    }else{
        self.navigationItem.rightBarButtonItem = item;
    }
    
}
- (void)setNavitemImage:(NSString *)imageString type:(SetNavItem)type{
    SEL jj;
    if (type == LeftNavItem) {
        jj = @selector(LeftItemAction);
    }else{
        jj = @selector(RightItemAction);
    }
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithImage: [UIImage imageNamed:imageString] style:(UIBarButtonItemStyleDone) target:self action:jj];
    if (type == LeftNavItem) {
        self.navigationItem.leftBarButtonItem = item;
    }else{
        self.navigationItem.rightBarButtonItem = item;
    }
    
}

- (void)LeftItemAction{
    
    
}
- (void)RightItemAction{
    
    
}



- (void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
