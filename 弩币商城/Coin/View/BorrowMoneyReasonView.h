//
//  BorrowMoneyReasonView.h
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/4.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BRSelectUse)(NSString * use);
@interface BorrowMoneyReasonView : UIView
- (instancetype)initWithFrame:(CGRect)frame withData:(NSArray *)dataArray;
@property (nonatomic,copy)BRSelectUse use;
@end

NS_ASSUME_NONNULL_END
