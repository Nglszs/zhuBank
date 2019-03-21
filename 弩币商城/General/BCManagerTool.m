//
//  BCManagerTool.m
//  映币
//
//  Created by Jack on 2018/12/11.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "BCManagerTool.h"
#import "Reachability.h"
#import <sys/utsname.h>//要导入头文件
#import <TCWebCodesSDK/TCWebCodesBridge.h>

@implementation BCManagerTool
static NSString *boundaryStr = @"--";
static BCManagerTool *_instanceTool;

+ (instancetype)defaultManagerTool {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instanceTool = [[self alloc] init];
        
    });
    
    return _instanceTool;
    
}


+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instanceTool = [super allocWithZone:zone];
    });
    
    return _instanceTool;
    
}

- (instancetype) copy {
    
    return _instanceTool;
    
}


#pragma mark 网络数据请求

- (void)requestwithUrl:(NSString *)urlString withMethod:(NSString *)method withParams:(NSDictionary *)params withSuccessBlock:(BCSuccessBlock)successBlock withFailBlock:(BCFailureBlock)failBlock {
    
    
    
    self.successBlock = successBlock;
    self.failureBlock = failBlock;
    
 
    
    //这里用表单上传参数，设置请求体
    NSMutableData *bodyContent = [NSMutableData data];
    
//    for ( NSString *newkey in params.allKeys ){
//        
//        id value = [params objectForKey:newkey];
//        [bodyContent appendData:[[NSString stringWithFormat:@"--%@\r\n", boundaryStr] dataUsingEncoding:NSUTF8StringEncoding]];
//        //拼接key值
//        [bodyContent appendData:[[NSString stringWithFormat:@"Content-Disposition:form-data;name=\"%@\"\r\n",newkey] dataUsingEncoding:NSUTF8StringEncoding]];
//        
//        [bodyContent appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//        
//        //拼接参数值
//        if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
//            
//            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:value options:NSJSONWritingPrettyPrinted error:nil];
//            
//            [bodyContent appendData:jsonData];
//            
//            
//        } else {
//            
//            
//            
//            [bodyContent appendData:[value dataUsingEncoding:NSUTF8StringEncoding]];
//            
//        }
//        
//        
//        [bodyContent appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//        
//        
//        
//    }
    
//    [bodyContent appendData:[[NSString stringWithFormat:@"--%@--", boundaryStr] dataUsingEncoding:NSUTF8StringEncoding]];
   

    
    
    //网络请求
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",urlString,method]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:6];
    [request setHTTPMethod:@"GET"];
    
//    [request setHTTPBody:bodyContent];
    
    
    //表单上传需要加上下面的数据，json上传时不加
//    [request setValue:[NSString stringWithFormat:@"multipart/form-data;boundary=%@", boundaryStr] forHTTPHeaderField:@"Content-Type"];
//    [request setValue:[NSString stringWithFormat:@"%ld", bodyContent.length] forHTTPHeaderField:@"Content-Length"];
    
 
    
    //这里使用nsurlsession
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *postSession = [NSURLSession sessionWithConfiguration:configuration];
   
    NSURLSessionTask *task = [postSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        if (error) {//请求失败
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                
                if (self.failureBlock) {
                    
                    
                    if (error.localizedDescription.length> 0 && error.localizedDescription.length <= 20) {
                        
                        failBlock(error.localizedDescription);
                        
                    } else {
                        
                        failBlock([NSString stringWithFormat:@"网络请求似乎出现了错误"]);
                    }
                }
                
            });
            
        } else {//请求成功
            
            
            //rc4解密
            
//            NSData *returnData = [encryptCommon encyptAndUnencyptDataWithRC4:data Key:key];
//
//            //解压
//            NSData *UncompressedData = [self uncompressZippedData:returnData];
            
            
             NSDictionary  *dicResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
           
          
            
//             NSDictionary *receiveData = [NSDictionary cleanNull:[dicResult objectForKey:@"data"]];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
//                if ([[receiveData objectForKey:@"statusCode"] integerValue] == 1 ) {//返回数据成功
                
//                这里不能用self。sucee网络请求相近的时候会被覆盖
                successBlock(dicResult);
                
            });
        }
        
    }];
    
    [task resume];
    
   
    
    
    
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




- (MJRefreshHeader *)loadDropRefresh:(void (^)(void))completion{
    
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        if (completion) {
            completion();
        }
    }];
    
    
    
    return header;
}



- (MJRefreshFooter *)loadPullRefresh:(void (^)(void))completion {
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       
        if (completion) {
            completion();
        }
        
    }];
    
    
    return footer;
}

- (BOOL)isCustomObject:(id)customClass {
    
    
    NSBundle *newBundle = [NSBundle bundleForClass:[customClass class]];
    
    if (newBundle == [NSBundle mainBundle]) {
        
        return YES;
        
    } else {
        
        
        return NO;
    }
    
}


- (BOOL)isIphoneXSerise {
    
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    
    return iPhoneXSeries;
}


- (BOOL)isIphonePlus {
    
    
    BOOL isPlues = ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO);
    
    
    
    return isPlues;
    
  
}

- (BOOL)isIphoneXAndIphoneXS {
    
    BOOL isPlues = ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO);
    
    
    return isPlues;
    

    
}


- (BOOL)isIphoneXSMax {
    
    BOOL isPlues = ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO);

    
    
    return isPlues;
    
    
    
}


- (BOOL)isIphoneXR {
    
    BOOL isPlues = ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO);
    
   
    return  isPlues;
}

- (CGFloat)suitIphonxSerise:(CGFloat)iphonX {
    
//    iphonX和XS的尺寸一样的（375*812），XSMax和XR的尺寸又是一样的（414*896）
    
    
// 适配高度时采用此方法，因为iPhone X的宽度和普通的iPhone7都是375
    
    CGFloat realV = (iphonX * BCWidth/375);
    
    
    return realV;
    
}
- (BOOL)isLogin {
    
   
    if ([USER_DEFAULTS objectForKey:USER_Token]) {
        
        
        return YES;
    } else {
        
        
        return NO;
    }
    

}

- (BOOL)isVip {
   
 return [USER_DEFAULTS  boolForKey:@"isvip"];
    
}

- (BOOL)isCreait {
    
    return [USER_DEFAULTS  boolForKey:@"iscredit"];
    
}
+ (void)loadTencentCaptcha:(UIView *)view callback:(void(^)(NSString * Ticket,NSString * Randstr))success{
    [[TCWebCodesBridge sharedBridge]loadTencentCaptcha:view appid:TencentCaptchAppID callback:^(NSDictionary *resultJSON) {
        if(0==[resultJSON[@"ret"] intValue]) {
            /**
             验证成功
             返回内容：
             resultJSON[@"appid"]为回传的业务appid
             resultJSON[@"ticket"]为验证码票据
             resultJSON[@"randstr"]为随机串
             */
            success(resultJSON[@"ticket"],resultJSON[@"randstr"]);
        } else {
            /**
             验证失败
             返回内容：
             ret=-1001为验证码js加载错误
             ret=-1002一般为网络错误
             ret=-1为返回票据数据解析错误，业务可根据需要重试处理
             ret的其他返回值，为验证失败，比如用户主动关闭了验证码弹框
             */
            success(nil,nil);
        }
    }];
}


+ (NSString *)getCurrentDeviceModel{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    
    if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone10,1"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,4"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,2"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,5"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([deviceModel isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([deviceModel isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
    if ([deviceModel isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";
    if ([deviceModel isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceModel isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceModel isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceModel isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceModel isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceModel isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceModel isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceModel isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    
    if ([deviceModel isEqualToString:@"AppleTV2,1"])      return @"Apple TV 2";
    if ([deviceModel isEqualToString:@"AppleTV3,1"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV3,2"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV5,3"])      return @"Apple TV 4";
    
    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    return deviceModel;
}


@end
