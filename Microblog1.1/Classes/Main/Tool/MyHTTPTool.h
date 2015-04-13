//
//  MyHTTPTool.h
//  Microblog1.1
//
//  Created by 王志盼 on 15/4/10.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFMultipartFormData;

@interface MyHTTPTool : NSObject
/**
 *  GET请求
 *
 *  @param urlStr  请求url
 *  @param params  请求参数
 *  @param success 请求成功需要执行的block
 *  @param failure 请求失败需要执行的block
 */
+ (void)get:(NSString *)urlStr params:(id)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

/**
 *  POST请求
 *
 *  @param urlStr  请求url
 *  @param params  请求参数
 *  @param success 请求成功需要执行的block
 *  @param failure 请求失败需要执行的block
 */
+ (void)post:(NSString *)urlStr params:(id)params success:(void (^)(id json))success failure:(void (^) (NSError *error))failure;
/**
 *  POST请求
 *
 *  @param urlStr   请求url
 *  @param params   请求参数
 *  @param data     需要上传的数据
 *  @param name
 *  @param fileName 
 *  @param mimeType 类型
 *  @param success  请求成功需要执行的block
 *  @param failure  请求失败需要执行的block
 */
+ (void)post:(NSString *)urlStr params:(id)params data:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
/**
 *  监控网络状态
 */
+ (void)setReachabilityStatusChangeBlock;
@end
