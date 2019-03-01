//
//  BCDatePickView.m
//  映币
//
//  Created by Jack on 2018/12/24.
//  Copyright © 2018 Jack. All rights reserved.
//

#import "BCDatePickView.h"

@implementation BCDatePickView

{
    NSArray *dataArr;//数据源
    NSString *selectValue;//选择的数据
    UIView *topView; // 标题行顶部视图
}



- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        
        [self initView];
        
    }
    return self;
}

- (void)initView {
    
    
    //背景
    UIView *backView = [[UIView alloc]initWithFrame:self.frame];
    backView.backgroundColor = ThemeColor;
    backView.alpha = 0.35;
    [self addSubview:backView];
    
    
//    取消确定
    
    
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, BCHeight - 125, BCWidth, 35)];
    topView.backgroundColor = COLOR(151, 151, 151);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:topView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10,10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = topView.bounds;
    maskLayer.path = maskPath.CGPath;
    topView.layer.mask = maskLayer;
    [self addSubview:topView];
    
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:COLOR(28, 0, 95) forState:UIControlStateNormal];
    [cancelButton setTitleColor:COLOR(28, 0, 95) forState:UIControlStateHighlighted];
    cancelButton.tag = 0;
    cancelButton.contentHorizontalAlignment = 1;
    cancelButton.titleLabel.font = MediumFont(15);
    [cancelButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(LEFT_Margin);
        make.width.mas_equalTo(BCWidth/2);
        make.height.mas_equalTo(35);
    }];
    
    
    UIButton *sureButton = [[UIButton alloc]init];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:COLOR(28, 0, 95) forState:UIControlStateNormal];
    [sureButton setTitleColor:COLOR(28, 0, 95) forState:UIControlStateHighlighted];
    sureButton.titleLabel.font = MediumFont(15);
    sureButton.tag = 1;
    sureButton.contentHorizontalAlignment = 2;
    [topView addSubview: sureButton];
    [sureButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-LEFT_Margin);
        make.width.mas_equalTo(BCWidth/2);
        make.height.mas_equalTo(35);
    }];
    
    
    
    //内容,
    UIView *mainView = [[UIView alloc]  init];
    mainView.backgroundColor = [UIColor whiteColor];
    [self addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(BCWidth);
        make.height.mas_equalTo(90);
        make.bottom.mas_equalTo(0);
    }];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    
    //设置地区: zh-中国
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    
    
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    [datePicker setDate:[NSDate date] animated:YES];
    // 设置显示最大时间（此处为当前时间）
    [datePicker setMaximumDate:[NSDate date]];
    
    //设置时间格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    //设置时间格式
    formatter.dateFormat = @"yyyy年 MM月 dd日";
    NSString *dateStr = [formatter  stringFromDate:datePicker.date];
    selectValue = dateStr;
    
    //监听DataPicker的滚动
    [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    
    [mainView addSubview:datePicker];
   
    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.mas_equalTo(0);
        make.height.mas_equalTo(90);
        make.width.mas_equalTo(BCWidth);
    }];
    

    
}

- (void)dateChange:(UIDatePicker *)datePicker {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    //设置时间格式
    formatter.dateFormat = @"yyyy年 MM月 dd日";
    NSString *dateStr = [formatter  stringFromDate:datePicker.date];
    selectValue = dateStr;
    
}


#pragma mark 点击按钮

- (void)clickButton:(UIButton *)btn {
  
    if (btn.tag == 1) {
        if (self.selectBlock) {
            self.selectBlock(selectValue);
        }
    }
   
    [self removeCommentCuView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self removeCommentCuView];
}


- (void)removeCommentCuView {
    
    if (self) {
        
        
        [UIView animateWithDuration:.25 animations:^{
            self.top = BCHeight;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
        
       
    }
    
}
@end
