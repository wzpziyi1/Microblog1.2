//
//  HMStatusTool.h
//  Microblog1.1
//
//  Created by 王志盼 on 15/4/19.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyBaseTool.h"
#import "MyHomeStatusesParam.h"
#import "MyHomeStatusesResult.h"
#import "MySendStatusParam.h"
#import "MySendStatusResult.h"

@interface MyStatusTool : MyBaseTool
/**
 *  加载首页的微博数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)homeStatusesWithParam:(MyHomeStatusesParam *)param success:(void (^)(MyHomeStatusesResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  发没有图片的微博
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)sendStatusWithParam:(MySendStatusParam *)param success:(void (^)(MySendStatusResult *result))success failure:(void (^)(NSError *error))failure;
@end
