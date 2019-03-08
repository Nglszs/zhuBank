//
//  CoinH5ViewController.h
//  弩币商城
//
//  Created by Jack on 2019/3/7.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinBaseViewController.h"
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CoinH5ViewController : CoinBaseViewController
@property(nonatomic,strong)WKWebView *commWebView;
@property(nonatomic,copy) NSString *url;
@property (nonatomic, copy) void(^backBlock)(void);
@property (nonatomic,copy)NSString * titleStr;
@end

NS_ASSUME_NONNULL_END
