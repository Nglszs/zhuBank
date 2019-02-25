//
//  BCHUDAlert.h
//  Fast
//
//  Created by Jack on 2017/10/14.
//  Copyright © 2017年 詹姆斯. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BCHUDType) {
    BCHUDError = 0,
    BCHUDSuccess,
    BCHUDInfo
};

@interface BCHUDAlert : UIView

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, assign) BCHUDType hudType;

- (instancetype) initWithHudType:(BCHUDType)type content:(NSString *)contentText delayMiss:(NSInteger)time;
@end
