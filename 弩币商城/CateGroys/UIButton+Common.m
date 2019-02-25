//
//  UIButton+Common.m
//  Fast
//
//  Created by 詹姆斯 on 2017/8/28.
//  Copyright © 2017年 詹姆斯. All rights reserved.
//

#import "UIButton+Common.h"
#import <objc/runtime.h>
@implementation UIButton (Common)
static void *blockKey = &blockKey;

- (void)setSuccessButton:(SuccessClick)successButton {
    objc_setAssociatedObject(self, &blockKey, successButton, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

- (SuccessClick)successButton {
    
    return objc_getAssociatedObject(self, &blockKey);
    
    
}




#pragma mark button 用block方式
- (void)addtargetBlock:(SuccessClick)btn {
    
    self.successButton = btn;
    [self addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)clickButton:(UIButton *)btn {
    
    
    if (self.successButton) {
        self.successButton(btn);
    }
}


#pragma mark
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    
    //这个方法实际上是将图片作为背景颜色，所以这个方法存在时就不能再调用setBackgroundImage
    [self setBackgroundImage:[UIButton imageWithColor:backgroundColor] forState:state];
    
    
}


+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


#pragma mark 避免点击事件重复

static void *timeKey = &timeKey;
static void *timeKey1 = &timeKey1;
- (NSTimeInterval)acceptEventInterval{
    
    return [objc_getAssociatedObject(self, &timeKey) doubleValue];
    
}


- (void)setAcceptEventInterval:(NSTimeInterval)acceptEventInterval {
    
    objc_setAssociatedObject(self, &timeKey, @(acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (NSTimeInterval)acceptEventTime {
    
    return [objc_getAssociatedObject(self, &timeKey1) doubleValue];
    
}

- (void)setAcceptEventTime:(NSTimeInterval)acceptEventTime {
    
    objc_setAssociatedObject(self, &timeKey1, @(acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}



- (void)avoidClick {
    // 交换dealoc
    
 
        Method a = class_getInstanceMethod([self class], @selector(sendAction:to:forEvent:));
        Method b = class_getInstanceMethod([self class], @selector(avoid_sendAction:to:forEvent:));
        method_exchangeImplementations(a, b);
   
    
    if (!self.acceptEventTime) {
        self.acceptEventTime = 2;
    }
    
    
   
    
}
- (void)avoid_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    
    
    
    if (NSDate.date.timeIntervalSince1970 - self.acceptEventTime < self.acceptEventTime) {
        
        NSLog(@"请不要频繁点击");
        return;
    }
    
    if (self.acceptEventInterval > 0)
    {
        self.acceptEventTime = NSDate.date.timeIntervalSince1970;
    }
    
    [self avoid_sendAction:action to:target forEvent:event];
    
}


- (void)imagePositionStyle:(ButtonImageType)imagePositionStyle spacing:(CGFloat)spacing {

    if (imagePositionStyle == ImagePositionStyleDefault) {
        self.imageEdgeInsets = UIEdgeInsetsMake(0, - 0.5 * spacing, 0, 0.5 * spacing);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 0.5 * spacing, 0, - 0.5 * spacing);
    } else if (imagePositionStyle == ImagePositionStyleRight) {
        CGFloat imageW = self.imageView.image.size.width;
        CGFloat titleW = self.titleLabel.frame.size.width;
        CGFloat imageOffset = titleW + 0.5 * spacing;
        CGFloat titleOffset = imageW + 0.5 * spacing;
        self.imageEdgeInsets = UIEdgeInsetsMake(0, imageOffset, 0, - imageOffset);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, - titleOffset, 0, titleOffset);
    } else if (imagePositionStyle == ImagePositionStyleTop) {
        CGFloat imageW = self.imageView.frame.size.width;
        CGFloat imageH = self.imageView.frame.size.height;
        CGFloat titleIntrinsicContentSizeW = self.titleLabel.intrinsicContentSize.width;
        CGFloat titleIntrinsicContentSizeH = self.titleLabel.intrinsicContentSize.height;
        self.imageEdgeInsets = UIEdgeInsetsMake(- titleIntrinsicContentSizeH - spacing, 0, 0, - titleIntrinsicContentSizeW);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageW, - imageH - spacing, 0);
    } else if (imagePositionStyle == ImagePositionStyleBottom) {
        CGFloat imageW = self.imageView.frame.size.width;
        CGFloat imageH = self.imageView.frame.size.height;
        CGFloat titleIntrinsicContentSizeW = self.titleLabel.intrinsicContentSize.width;
        CGFloat titleIntrinsicContentSizeH = self.titleLabel.intrinsicContentSize.height;
        self.imageEdgeInsets = UIEdgeInsetsMake(titleIntrinsicContentSizeH + spacing, 0, 0, - titleIntrinsicContentSizeW);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageW, imageH + spacing, 0);
    }


}


#pragma mark kvo监听按钮点击

static void *kvoKey = &kvoKey;

- (void)setButtonSelect:(SelectBlock)buttonSelect {
    objc_setAssociatedObject(self, &kvoKey, buttonSelect, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

- (SelectBlock)buttonSelect {
    
    return objc_getAssociatedObject(self, &kvoKey);
    
    
}


- (void)observerButtonOnClick:(SelectBlock)select {
    
    self.buttonSelect = select;
    
    [self addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew context:nil];
    
    
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    
    if ([keyPath isEqualToString:@"selected"] && object == self) {
        
        if ([[change objectForKey:@"new"] integerValue] == 1) {
            if (self.buttonSelect) {
                self.buttonSelect(YES);
            }
            
        } else {
            
            if (self.buttonSelect) {
                self.buttonSelect(NO);
            }
        }
        
    } else {
        
        
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:nil];
    }
    
}

- (void)willMoveToWindow:(UIWindow *)newWindow{
    
    
    if (!newWindow) {
        
//        [self removeObserver:self forKeyPath:@"selected" context:nil];
    }
}


- (void)addMoreParams:(id)param {
    
    
    
    objc_setAssociatedObject(self, "key", param, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (id)getMoreParams {
    
    
    return objc_getAssociatedObject(self, "key");
}


static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;



- (void)setEnlargeEdge:(CGFloat)size {
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left {
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)enlargedRect {
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge) {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    } else {
        return self.bounds;
    }
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds)) {
        return [super pointInside:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? YES : NO;
}


@end
