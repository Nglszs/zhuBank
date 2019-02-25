//
//  UIImageView+Common.m
//  映币
//
//  Created by Jack on 2018/12/11.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "UIImageView+Common.h"
#import <objc/runtime.h>


@implementation UIImageView (Common)

static void *scrollKey = &scrollKey;
static void *imageKey = &imageKey;
static void *rectKey = &rectKey;


- (CGRect)newRect {
    
    NSValue *value = objc_getAssociatedObject(self, &rectKey);
    
    CGRect rect;
    [value getValue:&rect];
    
    return rect;
}


- (void)setNewRect:(CGRect)newRect {
    
    objc_setAssociatedObject(self, &rectKey, @(newRect), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}


- (void)setBackgroundView:(UIScrollView *)backgroundView {
    objc_setAssociatedObject(self, &scrollKey, backgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (UIScrollView *)backgroundView {
    
    return objc_getAssociatedObject(self, &scrollKey);
    
    
}

- (void)setClickImageView:(UIImageView *)clickImageView {
   
    objc_setAssociatedObject(self, &imageKey, clickImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (UIImageView *)clickImageView {
    
    return objc_getAssociatedObject(self, &imageKey);
    
    
}



- (void)previewLagerImage {
    
    WS(weakself);
    [weakself addTapGestureWithBlock:^{
       
        
        UIWindow *showWindow = [UIApplication sharedApplication].keyWindow;
        self.backgroundView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.backgroundView.backgroundColor = [UIColor blackColor];
       self.backgroundView.alpha = 0;
        
        
        
        //加关闭手势
        UITapGestureRecognizer *shutGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shutView:)];
        shutGesture.numberOfTapsRequired = 1;

        
        
        //双击放大
        UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
        [doubleTapGestureRecognizer setNumberOfTapsRequired:2];
        
        
        
        
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,BCWidth, BCHeight)];
        scrollView.delegate = self;
        scrollView.tag = 10000 ;
        scrollView.minimumZoomScale = 1.0;
        scrollView.maximumZoomScale = 3;
        
        scrollView.zoomScale = 1.0;
        //添加手势
        [scrollView addGestureRecognizer:shutGesture];
        [scrollView addGestureRecognizer:doubleTapGestureRecognizer];
        [shutGesture requireGestureRecognizerToFail:doubleTapGestureRecognizer];



        
        CGFloat tempWidth = self.image.size.width;
        CGFloat tempHeight = self.image.size.height;
        
        self.clickImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (BCHeight - BCWidth/tempWidth * tempHeight)/2, BCWidth, BCWidth/tempWidth * tempHeight)];
       self.clickImageView.image = self.image;

       self.newRect  = [self convertRect:self.bounds toView:showWindow];
        self.clickImageView.frame = self.newRect;
        
   
      
       

        
        [UIView animateWithDuration:.8 delay:0 usingSpringWithDamping:1 initialSpringVelocity:.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            //图片居中,这里以宽度为填充标准
            
            
          self.clickImageView.frame = CGRectMake(0, (BCHeight - tempHeight * BCWidth / tempWidth)/2, BCWidth,tempHeight * BCWidth / tempWidth);
            
            self.backgroundView.alpha = 1;

        } completion:nil];



        [scrollView addSubview:self.clickImageView];
        
        [self.backgroundView addSubview:scrollView];
        
        
        
        [showWindow addSubview:self.backgroundView];


    }];
    
}


- (void)shutView:(UITapGestureRecognizer *)tap {
    
    
    UIScrollView *sc = (UIScrollView *)tap.view;
    
    [UIView animateWithDuration:.8 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        sc.zoomScale = 1;
        self.clickImageView.frame = self.newRect;
        self.backgroundView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [self.backgroundView removeFromSuperview];
        self.backgroundView = nil;
        self.clickImageView = nil;
        
        
    }];
    

}


-(void)doubleTap:(UITapGestureRecognizer *)gesture {
    
    UIScrollView *scrollview = (UIScrollView *)gesture.view;
    CGPoint touchPoint = [gesture locationInView:scrollview];
    
    if (scrollview.zoomScale <= 1.0) {
        
        //这里还有优化的余地，他不能居中
        CGFloat scaleX = touchPoint.x + scrollview.contentOffset.x;//需要放大的图片的X点
        CGFloat sacleY = touchPoint.y + scrollview.contentOffset.y;//需要放大的图片的Y点
        [scrollview zoomToRect:CGRectMake(scaleX, sacleY, 10, 10) animated:YES];
        
        
    } else {
        
        [scrollview setZoomScale:1.0 animated:YES]; //还原
   
    }

        
    
    
}


#pragma mark 缩放代理
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    for (UIView *testView in scrollView.subviews) {
        return testView;
    }
    
    return nil;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    
    
    
    [scrollView.subviews lastObject].center = [self centerOfScrollViewContent:scrollView];;
}

- (CGPoint)centerOfScrollViewContent:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    CGPoint actualCenter = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                       scrollView.contentSize.height * 0.5 + offsetY);
    return actualCenter;
}


@end
