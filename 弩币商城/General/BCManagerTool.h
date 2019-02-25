//
//  BCManagerTool.h
//  映币
//
//  Created by Jack on 2018/12/11.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJRefresh/MJRefresh.h"


typedef void(^ BCSuccessBlock) (id successResult);
typedef void(^ BCFailureBlock)  (NSString *errorResult);

@interface BCManagerTool : NSObject<NSURLSessionDataDelegate,NSURLSessionTaskDelegate,NSURLSessionDownloadDelegate>


@property (nonatomic, copy) BCSuccessBlock successBlock;
@property (nonatomic, copy) BCFailureBlock failureBlock;


@property (nonatomic, strong) NSURLSessionTask *requsetTask;

/**
 工具类单利

 @return nil
 */
+ (instancetype) defaultManagerTool;




/*------------------------------------------网络相关--------------------------------------------*/

/**
 *  网络请求
 *
 *  @param urlString    地址
 *  @param method       方法
 *  @param params       参数
 *  @param successBlock 成功时的数据
 *  @param failBlock    失败时的数据
 */
- (void)requestwithUrl:(NSString *)urlString
                          withMethod:(NSString *)method
                          withParams:(NSDictionary *)params
                    withSuccessBlock:(BCSuccessBlock)successBlock
                       withFailBlock:(BCFailureBlock)failBlock;





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





/**
 封装下拉刷新数据
 
 @param completion block
 @return nil
 */
- (MJRefreshHeader *)loadDropRefresh:(void(^)(void))completion;



/**
 封装上拉加载更多数据

 @param completion block
 @return nil
 */
- (MJRefreshFooter *)loadPullRefresh:(void(^)(void))completion;



/**
 判断是否是自定义类

 @param customClass 类
 @return nil
 */
- (BOOL)isCustomObject:(id)customClass;




/**
 是否是iPhone X系列

 @return nil
 */
- (BOOL)isIphoneXSerise;




/**
 是否是plus手机

 @return nil
 */
- (BOOL)isIphonePlus;



/**
 判断是否是iPhone X和XS，这两个设备尺寸一样大

 @return nil
 */
- (BOOL)isIphoneXAndIphoneXS;



- (BOOL)isIphoneXR;


- (BOOL)isIphoneXSMax;

/**
 适配iPhone X系列尺寸，注意仅需要适配高度才调用此方法

 @return 返回
 */
- (CGFloat)suitIphonxSerise:(CGFloat)iphonX;

/**
 是否是登录状态

 @return nil
 */
- (BOOL)isLogin;
@end
