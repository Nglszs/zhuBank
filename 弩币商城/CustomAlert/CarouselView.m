//
//  CarouselView.m
//  test
//
//  Created by Jack on 16/12/29.
//  Copyright © 2016年 毕研超. All rights reserved.
//

#import "CarouselView.h"

@implementation CarouselView

{

    BOOL isClick;
    NSArray *imageArr;
    UIScrollView *testScrollview;
    UIPageControl *pageControl;
    NSTimer *testTime;
   

}

- (instancetype)initWithFrame:(CGRect)frame displayImages:(NSArray *)images andClickEnable:(BOOL)flag {


    isClick = flag;
    imageArr = images;
    
    
    return [self initWithFrame:frame];


}



- (instancetype)initWithFrame:(CGRect)frame {


    if (self = [super initWithFrame:frame]) {
      
        [self initView];
        
        
    }

    return self;
}



- (void)initView {

    testScrollview = [[UIScrollView alloc] initWithFrame:self.bounds];
    testScrollview.pagingEnabled = YES;
    testScrollview.showsHorizontalScrollIndicator = NO;
    testScrollview.showsVerticalScrollIndicator = NO;
    testScrollview.delegate = self;
    testScrollview.contentSize = CGSizeMake(self.bounds.size.width * (imageArr.count + 2), self.bounds.size.height);
    [self addSubview:testScrollview];
    
    
    NSMutableArray *newImageArr = [NSMutableArray arrayWithArray:imageArr];
    
    [newImageArr insertObject:imageArr[imageArr.count - 1] atIndex:0];
    [newImageArr insertObject:imageArr[0] atIndex:imageArr.count + 1];


    
    for (int i = 0; i < newImageArr.count; i ++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width * i, 0, self.bounds.size.width, self.bounds.size.height)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.image =[newImageArr objectAtIndex:i];
        [testScrollview addSubview:imageView];
        
        if (isClick) {
            
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(handleTap:)];
            [imageView addGestureRecognizer:singleTap];

        }
        
    }
    

    [testScrollview setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:YES];
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((self.bounds.size.width - 44)/2, self.bounds.size.height - 44, 44, 44)];
    
    pageControl.numberOfPages = imageArr.count;
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = White;
    [pageControl addTarget:self action:@selector(changePageControl:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:pageControl];
    
    //开启定时器
    
    [self loadTime];

}

- (void)loadTime {
    
    testTime = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(pageChanged) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:testTime forMode:NSRunLoopCommonModes];
    
}


- (void)pageChanged{
    
    NSInteger page = pageControl.currentPage;
    page++;
    if (page == imageArr.count + 1) {//当到了第四页，偷偷回到第二张图一，page至为0
        page = 0;
        [testScrollview scrollRectToVisible:CGRectMake(testScrollview.contentSize.width - 2 * testScrollview.bounds.size.width, 0, testScrollview.bounds.size.width, testScrollview.bounds.size.height) animated:NO];
    }
    
   
    [testScrollview scrollRectToVisible:CGRectMake((page + 1) * testScrollview.bounds.size.width, 0, testScrollview.bounds.size.width, testScrollview.bounds.size.height) animated:YES];
    
    
}


#pragma mark  UIPageControl点击事件
- (void)changePageControl:(UIPageControl *)page {
    
    [testScrollview scrollRectToVisible:CGRectMake(testScrollview.bounds.size.width *(pageControl.currentPage + 1), 0, testScrollview.bounds.size.width, testScrollview.bounds.size.height) animated:YES];
    
}



#pragma mark UIScrollView代理

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [testTime invalidate];
    testTime = nil;
    
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    
    [self loadTime];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == 0) {
        //用户滑到一号位置，显示第三张图，必须跳转到倒数第二个3.png
        [scrollView scrollRectToVisible:CGRectMake(scrollView.contentSize.width - 2 * scrollView.bounds.size.width, 0, scrollView.bounds.size.width, scrollView.bounds.size.height) animated:NO];
    }
    //用户滑到最后位置，显示第一张图，必须跳转到第二个1.png
    if (scrollView.contentOffset.x == scrollView.contentSize.width - scrollView.bounds.size.width) {
        [scrollView scrollRectToVisible:CGRectMake(scrollView.bounds.size.width, 0, scrollView.bounds.size.width, scrollView.bounds.size.height) animated:NO];
        
    }
    
    NSInteger page = scrollView.contentOffset.x /self.frame.size.width;
    [pageControl setCurrentPage:page-1];
    
    
}

- (void)willMoveToWindow:(UIWindow *)newWindow {

    if (!newWindow) {
        NSLog(@"释放定时器");

        [testTime invalidate];
        testTime = nil;

    }

}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    
   
        if ([self.delegete respondsToSelector:@selector(didClickImageLoopIndex:)]) {
            [self.delegete didClickImageLoopIndex:pageControl.currentPage];
        }
    
    
}
@end
