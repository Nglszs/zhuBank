//
//  UIImageView+Common.h
//  映币
//
//  Created by Jack on 2018/12/11.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIImageView (Common)<UIScrollViewDelegate>


@property (nonatomic, strong) UIScrollView *backgroundView;

@property (nonatomic, strong) UIImageView *clickImageView;

@property (nonatomic, assign) CGRect newRect;

/**
 预览大图
 */
- (void)previewLagerImage;

@end


