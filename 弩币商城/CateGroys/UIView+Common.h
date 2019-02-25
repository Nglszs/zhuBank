//
//  UIView+Common.h
//  映币
//
//  Created by Jack on 2018/12/11.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ClickTapGesture)(void);
@interface UIView (Common)


@property (nonatomic,assign) CGFloat left;
@property (nonatomic,assign) CGFloat right;
@property (nonatomic,assign) CGFloat top;
@property (nonatomic,assign) CGFloat bottom;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;


@property (nonatomic, copy) ClickTapGesture successTap;


/**
 显示提示弹窗
 
 @param content 内容
 */
- (void)showWarnHUD:(NSString *)content;

/**
 显示错误弹窗
 
 @param content 错误信息
 */
- (void)showErrorHUD:(NSString *)content;


/**
 显示成功弹窗
 
 @param content 内容
 */
- (void)showSuccessHUD:(NSString *)content;




/**
 获取当前view的控制器

 @return nil
 */
- (UIViewController *)getCurrentViewController;



/**
 为view添加点击手势并用block返回
 
 @param clickTap 点击手势
 */
- (void)addTapGestureWithBlock:(ClickTapGesture) clickTap;
@end
