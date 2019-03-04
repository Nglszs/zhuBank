//
//  WOWONoDataView.h
//  WormwormLife
//
//  Created by 张文彬 on 2018/2/10.
//  Copyright © 2018年 张文彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WOWONoDataView : UIView
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) UILabel *text;
@property (nonatomic,strong) UILabel *detail;

@property (nonatomic, assign) BOOL isAdjust;//调整高度
- (instancetype)initWithImageName:(NSString *)imageName text:(NSString *)text detailText:(NSString *)detailText buttonTitle:(NSString *)buttonTitle;
@end
