//
//  HttpTool.h
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/6.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BRRequestSuccess)(NSURLSessionDataTask * task,id responseObject);
typedef void(^BRRequestFailure)(NSURLSessionDataTask * task,NSError * error);
@interface HttpTool : NSObject


+(instancetype)sharedHttpTool;

- (void)HttpPostWithUrl:(NSString *)urlString parameters:(id )parameters loadString:(NSString *)loadString success:(BRRequestSuccess)success failure:(BRRequestFailure)failure;


- (void)HttpGetWithUrl:(NSString *)urlString parameters:(id )parameters loadString:(NSString *)loadString success:(BRRequestSuccess)success failure:(BRRequestFailure)failure;
@end

NS_ASSUME_NONNULL_END
