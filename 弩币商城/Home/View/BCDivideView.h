//
//  BCDivideView.h
//  弩币商城
//
//  Created by Jack on 2019/2/27.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BCDivideView : UIView
@property (nonatomic,copy)void(^backBlock)(id result);
- (instancetype)initWithFrame:(CGRect)frame andGoodID:(NSString *)ID;
@end

NS_ASSUME_NONNULL_END
