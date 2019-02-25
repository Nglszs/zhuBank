//
//  CarouselView.h
//  test
//
//  Created by Jack on 16/12/29.
//  Copyright © 2016年 毕研超. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ClickImageLoopViewDelegate <NSObject>

@optional

- (void)didClickImageLoopIndex:(NSInteger)index;


@end

@interface CarouselView : UIView<UIScrollViewDelegate>

@property (nonatomic,weak) id<ClickImageLoopViewDelegate>delegete;



/**
 创建轮播图

 @param frame 尺寸
 @param images 图片
 @param flag 是否可以点击
 @return nil
 */
- (instancetype)initWithFrame:(CGRect)frame displayImages:(NSArray *)images andClickEnable:(BOOL)flag;


@end
