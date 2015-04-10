//
//  MyHTTPTool.h
//  Microblog1.1
//
//  Created by 王志盼 on 15/4/10.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import <Foundation/Foundation.h>

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
 *  POST请求（上传文件）
 *
 *  @param urlStr    请求url
 *  @param params    请求参数
 *  @param construct 需要上传的文件block
 *  @param success   请求成功需要执行的block
 *  @param failure   请求失败需要执行的block
 */
+ (void)post:(NSString *)urlStr params:(id)params constructingBodyWithBlock:(void (^)(id forData))construct success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
/**
 *  监控网络状态
 */
+ (void)setReachabilityStatusChangeBlock;
@end
