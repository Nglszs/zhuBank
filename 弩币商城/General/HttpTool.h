//
//  HttpTool.h
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/6.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef void(^BRRequestSuccess)(NSURLSessionDataTask * task,id responseObject);
typedef void(^BRRequestFailure)(NSURLSessionDataTask * task,NSError * error);
@interface HttpTool : NSObject


+(instancetype)sharedHttpTool;

- (void)HttpPostWithUrl:(NSString *)urlString parameters:(id)parameters loadString:(NSString *)loadString success:(BRRequestSuccess)success failure:(BRRequestFailure)failure;


- (void)HttpGetWithUrl:(NSString *)urlString parameters:(id )parameters loadString:(NSString *)loadString success:(BRRequestSuccess)success failure:(BRRequestFailure)failure;

/**
 判断当前网络是否可用
 
 @return 是否可用
 */
- (BOOL)isConnectionAvalible;



/**
 判断当前网络是否是WIFI
 
 @return nil
 */
- (BOOL)isCurrentNetWIFI;




/**
 
 NSUserdefualt保存数据
 
 @param object 保存的数据
 @param key key
 */
- (void)saveObject:(id)object forKey:(NSString *)key;



/**
 NSUserdefualt删除数据
 
 @param key key
 */
- (void)deleteObjectForKey:(NSString *)key;

@end


