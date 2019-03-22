//
//  FOSAuthController.h
//  FOSHCTDemo
//
//  Created by Wei Niu on 2019/2/14.
//  Copyright © 2019年 Fosafer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FOSAuthController : UIViewController
@property (nonatomic,copy) void(^backBlock)(id result);
@property (nonatomic, copy) NSDictionary *params;

@end

NS_ASSUME_NONNULL_END
