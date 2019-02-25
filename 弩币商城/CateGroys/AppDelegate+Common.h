//
//  AppDelegate+Common.h
//  映币
//
//  Created by Jack on 2018/12/11.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"

@interface AppDelegate (Common)

@property (nonatomic ,strong) Reachability *netWorkAvliblity;



/**
 设置项目根试图
 */
- (void)setProgameRootViewController;



/**
 开启网络监听
 */
- (void)startNetWorkObserver;



/**
 开启iIQkeyboard
 */
- (void)openKeyBoardManager;



/**
 每次打开app，刷新用户数据
 */
- (void)updateUserInfo;



/**
 集成阿里云推送
 */
- (void)initAliCloudPush;



/**
 集成友盟分享
 */
- (void)initUMShare;
@end


