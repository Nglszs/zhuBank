//
//  HttpTool.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/6.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "HttpTool.h"
#import <AFNetworking/AFNetworking.h>

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

-(void)HttpPostWithUrl:(NSString *)urlString parameters:(id )parameters loadString:(NSString *)loadString success:(BRRequestSuccess)success failure:(BRRequestFailure)failure{
    if (urlString.length == 0) {
        return;
    }
    if (![urlString hasPrefix:@"http"]) {
        urlString = [NSString stringWithFormat:@"%@%@",BCBaseUrl,urlString];
    }
    [self.manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
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
    [self.manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
    
}

@end
