//
//  UIButton+Common.h
//  Fast
//
//  Created by 詹姆斯 on 2017/8/28.
//  Copyright © 2017年 詹姆斯. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SuccessClick)(UIButton *button);

typedef void (^SelectBlock)(BOOL selectState);

typedef NS_ENUM (NSInteger,ButtonImageType){
    /// 图片在左，文字在右
    ImagePositionStyleDefault = 0,
    /// 图片在右，文字在左
    ImagePositionStyleRight,
    /// 图片在上，文字在下
    ImagePositionStyleTop,
    /// 图片在下，文字在上
    ImagePositionStyleBottom,
};

@interface UIButton (Common)


@property (nonatomic, copy) SuccessClick successButton;

@property (nonatomic, copy) SelectBlock buttonSelect;



/**
 *  点击事件以block形式调用
 *
 *  @param btn 实例
 */
- (void)addtargetBlock:(SuccessClick)btn;



/**
 *  设置按钮的背景颜色
 *
 *  @param backgroundColor 色值
 *  @param state           状态
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;







/**
 *  设置图片与文字样式
 *
 *  @param imagePositionStyle     图片位置样式
 *  @param spacing                图片与文字之间的间距
 */
- (void)imagePositionStyle:(ButtonImageType)imagePositionStyle spacing:(CGFloat)spacing;





/**
 KVO监听按钮是不是被点击,一种反射机制,可以同时和按钮点击事件一起触发，

 @param select 选中状态
 */
- (void)observerButtonOnClick:(SelectBlock)select;




/**
 利用runtime携带多个参数

 @param param 参数
 
 */
- (void)addMoreParams:(id)param;



/**
 利用runtime取参数

 @return 返回
 */
- (id)getMoreParams;


//避免重复点击
- (void)avoidClick;
@property (nonatomic, assign) NSTimeInterval acceptEventInterval;//点击事件间隔
@property (nonatomic, assign) NSTimeInterval acceptEventTime;//用来计算时间的过渡量



//  扩大按钮点击范围


/** 设置可点击范围到按钮边缘的距离 */
- (void)setEnlargeEdge:(CGFloat)size;

/** 设置可点击范围到按钮上、右、下、左的距离 */
- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;


@end
