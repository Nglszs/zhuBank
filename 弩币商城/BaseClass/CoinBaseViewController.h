//
//  CoinBaseViewController.h
//  弩币商城
//
//  Created by Jack on 2019/2/25.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//  各个vc之间交互
typedef void(^returnNeedData)(id resultData);
@interface CoinBaseViewController : UIViewController
/**
 两个VC之间传递数据专用
 */
@property (nonatomic, copy) returnNeedData resultData;

/**
 设置左侧返回按钮
 */
- (void)setBackLeftBar:(NSString *)backTitle;



/**
 设置导航栏右侧按钮
 */
- (void)setCustomRightBar:(NSString *)rightTitle click:(void(^)(void))clickRight;


@end

NS_ASSUME_NONNULL_END
