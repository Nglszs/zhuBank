//
//  AppDelegate.m
//  弩币商城
//
//  Created by Jack on 2019/2/25.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "AppDelegate.h"
#import "CateGroys/AppDelegate+Common.h"
#import "HttpTool.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import <Bugly/Bugly.h>
@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //    根视图
    [self setProgameRootViewController];
   
    //  键盘小时
    [self openKeyBoardManager];
    
    //    更新用户信息
    [self updateUserInfo];
   
    // 请求是否APP通过审核
    [self requestAuditState];
    
    // NOTE: 调用支付结果开始支付
    [WXApi registerApp:@"wx3007c71783deadc3"];
    [Bugly startWithAppId:@"02599bb342"];
    return YES;
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    if ([url.host isEqualToString:@"pay"]) {
        return [WXApi handleOpenURL:url delegate:self];
    }
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            [self AlipayPayresultDic:resultDic];
            
        }];
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"pay"]) {
        return [WXApi handleOpenURL:url delegate:self];
    }
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
           [self AlipayPayresultDic:resultDic];
            
        }];
    }
    return YES;
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
  
    if ([url.host isEqualToString:@"pay"]) {
        return [WXApi handleOpenURL:url delegate:self];
    }
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            [self AlipayPayresultDic:resultDic];
        }];
    }
    return YES;
}

- (void)AlipayPayresultDic:(NSDictionary *)resultDic{
    if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]){
        [[NSNotificationCenter defaultCenter] postNotificationName:PaySuccess object:nil];
    }else{
         [[NSNotificationCenter defaultCenter] postNotificationName:PayError object:nil];
    }
    
}

-(void)onReq:(BaseReq*)reqonReq{
    
}

-(void)onResp:(BaseResp*)resp{
    //启动微信支付的response
    NSString *payResoult = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case 0:
                  [[NSNotificationCenter defaultCenter] postNotificationName:PaySuccess object:nil];
                payResoult = @"支付结果：成功！";
                break;
//            case -1:
//                payResoult = @"支付结果：失败！";
//                break;
//            case -2:
//                payResoult = @"用户已经退出支付！";
//                break;
            default:
                 [[NSNotificationCenter defaultCenter] postNotificationName:PayError object:nil];
                payResoult = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                break;
        }
    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
