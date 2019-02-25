//
//  UITextView+Common.h
//  test
//
//  Created by Jack on 17/1/12.
//  Copyright © 2017年 毕研超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Common)<UITextViewDelegate>
@property (nonatomic,strong) NSString *placeholder;//占位符
@property (copy, nonatomic) NSNumber *limitLength;//限制字数




/**
 *  下面两个属性不要直接调用
 */
@property (nonatomic,strong) UILabel *placeholderLabel;//占位符
@property (nonatomic,strong) UILabel *wordCountLabel;//计算字数
@end
