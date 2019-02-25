//
//  BCHUDAlert.m
//  Fast
//
//  Created by Jack on 2017/10/14.
//  Copyright © 2017年 詹姆斯. All rights reserved.
//

#import "BCHUDAlert.h"

@implementation BCHUDAlert
{
    
    UILabel *contentLabel;
    UIView *mainView;
    NSString *contentString;

}
- (instancetype)initWithHudType:(BCHUDType)type content:(NSString *)contentText delayMiss:(NSInteger)time {
    
    
    self.hudType = type;
    contentString = contentText;
    
     return [self initWithFrame:[UIScreen mainScreen].bounds];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        //背景
        UIView *backView = [[UIView alloc]initWithFrame:self.frame];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0.35;
        [self addSubview:backView];
        
        
        
        
        //内容,这里不做界面适配，需要的自己做，很简单
        mainView = [[UIView alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - 270)/2, (CGRectGetHeight(self.frame) - 132)/2, 120, 90)];
        
        mainView.layer.cornerRadius = 10;
        mainView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.8];
        mainView.layer.masksToBounds = YES;
        [self addSubview:mainView];
        
        //图片
        
        UIImage *someImage;
        switch (_hudType) {
            case BCHUDInfo:
                someImage = [UIImage imageNamed:@"icon-info"];
                
                break;
            case BCHUDError:
                someImage = [UIImage imageNamed:@"icon-error"];
                break;
            case BCHUDSuccess:
                someImage = [UIImage imageNamed:@"icon-success"];
                break;
           
            default:
                 someImage = [UIImage imageNamed:@""];
                break;
        }
        
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((mainView.width - 36)/2, 10, 36, 36)];
        iconImageView.image = someImage;
        [mainView addSubview:iconImageView];
        
     
        
        contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(iconImageView.frame) + 10, mainView.width - 20, 24)];
        contentLabel.font = [UIFont systemFontOfSize:12];
        contentLabel.numberOfLines = 0;
        contentLabel.text = contentString;
        contentLabel.textColor = ThemeColor;
        contentLabel.textAlignment = NSTextAlignmentCenter;
        [mainView addSubview:contentLabel];
       
                
         [self adjustView];
        
    }

    
    return self;
}
- (void)adjustView {//判断，各种可能性，然后调整view
    
//    AppDelegate *delegate = (AppDelegate *)[SHARE_APPLICATION delegate];
//    if (delegate.isShowHUD) {
//        return;
//    }
//
    CGFloat tempHeight = [self getStringHeightWith:contentString width:contentLabel.width font:[UIFont systemFontOfSize:14]];
    
     contentLabel.height = tempHeight;
    
    mainView.frame = CGRectMake((CGRectGetWidth(self.frame) - 120)/2, (CGRectGetHeight(self.frame) - contentLabel.bottom - 10)/2, 120, contentLabel.bottom + 10);
    
    
    //这里可以按照自己需求加上动画，这里不再写
    _window = [[UIWindow alloc]initWithFrame:self.frame];
    _window.windowLevel = UIWindowLevelAlert + 1;
    
    [_window addSubview:self];
    [_window makeKeyAndVisible];
    
    
    //动画
    mainView.transform = CGAffineTransformMakeScale(1.45, 1.45);
    mainView.alpha = 0.0;
    
    [UIView animateWithDuration:.3 animations:^{
        
        mainView.alpha = 1.0;
        mainView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
//         delegate.isShowHUD = YES;
        
        //消失动画
        [UIView animateWithDuration:0.5 delay:.75 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            mainView.alpha = .0f;
            mainView.transform = CGAffineTransformMakeScale(0.65, 0.65);
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            [_window resignKeyWindow];
            _window = nil;
//            AppDelegate *applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//            applegate.isShowHUD = NO;
        }];
    }];
    
}


//获取字符串高度
- (CGFloat)getStringHeightWith:(NSString*)tempStr width:(CGFloat)tempWidth font:(UIFont*)tempFont {
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineHeightMultiple = 4.f;    //行间距
    paragraphStyle.maximumLineHeight = 20.f;    //每行的最大高度
    paragraphStyle.minimumLineHeight = 16.f;    //每行的最小高度
    paragraphStyle.alignment = NSTextAlignmentJustified;
    
    CGRect rect = [tempStr boundingRectWithSize:CGSizeMake(tempWidth, 0)
                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine
                                     attributes:@{NSFontAttributeName:tempFont,NSParagraphStyleAttributeName:paragraphStyle}
                                        context:nil];
    //文字的高度
    CGFloat tempHeight = rect.size.height;
    
    return tempHeight;
}
@end
