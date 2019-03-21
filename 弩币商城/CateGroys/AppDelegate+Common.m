//
//  AppDelegate+Common.m
//  映币
//
//  Created by Jack on 2018/12/11.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "AppDelegate+Common.h"
#import "BCMainTabViewController.h"
#import <objc/runtime.h>
#import "BCNavigationViewController.h"





@implementation AppDelegate (Common)


static void *networkKey = &networkKey;



- (void)setNetworkAbility:(Reachability *)networkAbility {
    
    objc_setAssociatedObject(self, &networkKey, networkAbility, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (Reachability *)networkAbility {
    
    
    return objc_getAssociatedObject(self, &networkKey);
    
}


#pragma mark 根视图

- (void)setProgameRootViewController {
   
    
    
    self.window = [[UIWindow alloc] initWithFrame:BCBound];
    self.window.backgroundColor = ThemeColor;
    BCMainTabViewController *mainViewController = [[BCMainTabViewController alloc] init];
    
    self.window.rootViewController = mainViewController;
    [self.window makeKeyAndVisible];
    

}


#pragma mark 网络监听

- (void)startNetWorkObserver {
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BCNetworkStateChange:) name:kReachabilityChangedNotification object:nil];
    
    // 获得Reachability对象
    self.networkAbility = [Reachability reachabilityForInternetConnection];
    // 开始监控网络
    
    
    
    [self.networkAbility startNotifier];

}

-(void)BCNetworkStateChange:(NSNotification *)note {
    
    
    Reachability *currReach = [note object];
    
    //对连接改变做出响应处理动作
    NetworkStatus status = [currReach currentReachabilityStatus];
    //如果没有连接到网络就弹出提醒实况
    
    if(status == NotReachable){
        
//        self.isAvailableNet = NO;
//        [self.window.rootViewController showErrorAlert:@"网络连接失败"];
        
    } else {
        
//        self.isAvailableNet = YES;
        
    }
    
}


- (void)openKeyBoardManager {
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.enableAutoToolbar = NO;
    
    
    
}

- (void)updateUserInfo {
    
    
    
    if ([Tool isLogin]) {
        
       
        [KTooL HttpPostWithUrl:@"UserCenter/index" parameters:nil loadString:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            
            NSLog(@"===%@",responseObject);
            
            
            if (BCStatus) {
                
              NSDictionary *dataDic = [responseObject objectNilForKey:@"data"];
                
               
                [USER_DEFAULTS setBool:[[dataDic objectForKey:@"buy_vip"] boolValue] forKey:@"isvip"];
                 [USER_DEFAULTS setBool:[[dataDic objectForKey:@"credit"] boolValue] forKey:@"iscredit"];
                
                [USER_DEFAULTS synchronize];
                
            } else {
                
                
            }
            
        } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
            
        }];
    }
    
    
}


- (void)initAliCloudPush {
    
    // SDK初始化
//    [CloudPushSDK asyncInit:@"25576803" appSecret:@"8ecab260c3eb6b8506f1bcafb80176a3" callback:^(CloudPushCallbackResult *res) {
//        if (res.success) {
//            NSLog(@"Push SDK init success, deviceId: %@.", [CloudPushSDK getDeviceId]);
//        } else {
//            NSLog(@"Push SDK init failed, error: %@", res.error);
//        }
//    }];
    
    
   
    
}


- (void)initUMShare {
    
    
//    iOS （5c416289b465f5a339000c74）      Android（5c4161baf1f556b79f000c02）H5（5c416347f1f556a6ed000d38 ）
    
    
//    [[UMSocialManager defaultManager] setUmSocialAppkey:@"5c416289b465f5a339000c74"];
//
//
//
//    /* 设置微信的appKey和appSecret */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxeba74bdc074150fe" appSecret:@"d58b0cc6c302f6fcc952c8cf444920ac" redirectURL:@"http://mobile.umeng.com/social"];
//
   
}
@end
