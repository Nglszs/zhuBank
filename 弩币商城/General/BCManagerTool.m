//
//  BCManagerTool.m
//  映币
//
//  Created by Jack on 2018/12/11.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "BCManagerTool.h"
#import "Reachability.h"

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
    
   
    
    BOOL login = [USER_DEFAULTS boolForKey:ISLogin];
    
    
    
    return login;
    
    
    
}
@end
