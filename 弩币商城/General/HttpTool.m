//
//  HttpTool.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/6.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "HttpTool.h"
#import <AFNetworking/AFNetworking.h>
#import "Reachability.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "CoinLoginViewController.h"

static HttpTool * tool;
@interface HttpTool()
@property (nonatomic,strong)AFHTTPSessionManager * manager;
@end
@implementation HttpTool
+(instancetype)sharedHttpTool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[HttpTool alloc] init];
        
        AFHTTPSessionManager * manage = [AFHTTPSessionManager manager];
        manage.responseSerializer = [AFJSONResponseSerializer new];
        
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
        tool.manager = manage;
        
    });
    return tool;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [super allocWithZone:zone];
    });
    
    return tool;
    
}

- (instancetype) copy {
    
    return tool;
    
}


-(void)HttpPostWithUrl:(NSString *)urlString parameters:(id )parameters loadString:(NSString * )loadString success:(BRRequestSuccess)success failure:(BRRequestFailure)failure{
    if (urlString.length == 0) {
        return;
    }
    if (![urlString hasPrefix:@"http"]) {
        urlString = [NSString stringWithFormat:@"%@%@",BCBaseUrl,urlString];
    }
    if (parameters == nil) {
        parameters = [NSDictionary dictionary];
    }
    if (!BCStringIsEmpty(loadString)) {
        [SVProgressHUD showWithStatus:loadString];
    }
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    // 公共参数
    NSString * user_id  = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID];
    if (!BCStringIsEmpty(user_id)) {
        dict[@"user_id"] = user_id;
    }
    
    NSString * token  = [[NSUserDefaults standardUserDefaults] objectForKey:USER_Token];
    if (!BCStringIsEmpty(token)) {
        dict[@"token"] = token;
    }
    dict[@"reg_from"] = @"3";
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    dict[@"version"] = app_Version;
    dict[@"device"] = [self getUUID];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        dict[key] = [NSString stringWithFormat:@"%@",obj];
    }];
    
    if ([Tool checkProxySetting]) {
        [SVProgressHUD showErrorWithStatus:@"检测到网络代理，请关闭"];
        return;
    }

    [self.manager POST:urlString parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        
        if ([[NSString stringWithFormat:@"%@",responseObject[@"status"]] isEqualToString:@"8"]) {
            //您的账号已在别处登录
             [SVProgressHUD showInfoWithStatus:@"您的账号已在别处登录"];
            [self GoLogin];
            return;
        }
        
        if ([[NSString stringWithFormat:@"%@",responseObject[@"status"]] isEqualToString:@"9"]) {
            // 登录过期，请重新登录
            [SVProgressHUD showInfoWithStatus:@"登录过期，请重新登录"];
            [self GoLogin];
            return;
        }
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [SVProgressHUD dismiss];
        [SHARE_APPLICATION.keyWindow makeToast:@"网络断开连接,请检查网络" duration:1 position:CSToastPositionCenter];
        failure(task,error);
    }];
    
}


- (void)HttpGetWithUrl:(NSString *)urlString parameters:(id )parameters loadString:(NSString *)loadString success:(BRRequestSuccess)success failure:(BRRequestFailure)failure{
    if (urlString.length == 0) {
        return;
    }
    if (![urlString hasPrefix:@"http"]) {
        urlString = [NSString stringWithFormat:@"%@%@",BCBaseUrl,urlString];
    }
    
    if (parameters == nil) {
        parameters = [NSDictionary dictionary];
    }
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    // 公共参数
    //    dict[@"user_id"] =
    dict[@"reg_from"] = @"3";
    //    dict[@"token"] =
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    dict[@"version"] = app_Version;
    dict[@"device"] = [self getUUID];
    
    [self.manager GET:urlString parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}

- (void)GoLogin{
    [NOTIFICATION_CENTER postNotificationName:Exit_login object:nil];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_ID];
     [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_Token];
    
    UIViewController *VC = [self getCurrentViewController];
    [VC.navigationController pushViewController:[CoinLoginViewController new] animated:YES];
    
}

- (UIViewController *)getCurrentViewController {
    
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    UIViewController *topViewController = [window rootViewController];
    
    while (true) {
        
        if (topViewController.presentedViewController) {
            
            topViewController = topViewController.presentedViewController;
            
        } else if ([topViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)topViewController topViewController]) {
            
            topViewController = [(UINavigationController *)topViewController topViewController];
            
        } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
            
            UITabBarController *tab = (UITabBarController *)topViewController;
            topViewController = tab.selectedViewController;
            
        } else {
            break;
        }
    }
    return topViewController;
}

- (BOOL)isConnectionAvalible {
    
    BOOL isExistenceNetwork = NO;
    
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    
    switch ([reach currentReachabilityStatus]) {
            
        case NotReachable:
            isExistenceNetwork = NO;
            break;
            
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            break;
            
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            break;
            
        default:
            break;
    }
    
    return isExistenceNetwork;
}



- (BOOL)isCurrentNetWIFI {
    
    BOOL isExistenceNetwork = NO;
    
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    
    switch ([reach currentReachabilityStatus]) {
            
        case NotReachable:
            isExistenceNetwork = NO;
            
            break;
            
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            
            break;
            
        case ReachableViaWWAN:
            isExistenceNetwork = NO;
            
            break;
            
        default:
            break;
    }
    
    return isExistenceNetwork;
    
}


#pragma mark 保存数据相关

- (void)saveObject:(id)object forKey:(NSString *)key {
    
    [USER_DEFAULTS setObject:object forKey:key];
    [USER_DEFAULTS synchronize];
    
}


- (void)deleteObjectForKey:(NSString *)key {
    
    [USER_DEFAULTS removeObjectForKey:key];
    [USER_DEFAULTS synchronize];
}

- (NSString *)getUUID{
    
    CFUUIDRef puuid = CFUUIDCreate(nil);
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
    NSMutableString *tmpResult = result.mutableCopy;

    NSRange range = [tmpResult rangeOfString:@"-"];
    while (range.location != NSNotFound) {
        [tmpResult deleteCharactersInRange:range];
        range = [tmpResult rangeOfString:@"-"];
    }
    return tmpResult;
    
}

- (void)GetCodeWithMobile:(NSString *)mobile action:(int)action Ticket:(NSString *)Ticket randstr:(NSString *)Randstr success:(void(^)(BOOL isSucces))success{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"mobile"] = mobile;
    dict[@"action"] = [NSString stringWithFormat:@"%d",action];
    dict[@"Ticket"] = Ticket;
    dict[@"Randstr"] = Randstr;
    [KTooL HttpPostWithUrl:@"User/send_sms" parameters:dict loadString:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (BCStatus) {
            
           success(BCStatus);
            
        } else {
            
            [[UIApplication sharedApplication].keyWindow makeToast:BCMsg duration:1 position:CSToastPositionCenter];
            
        }
        
       
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
@end
