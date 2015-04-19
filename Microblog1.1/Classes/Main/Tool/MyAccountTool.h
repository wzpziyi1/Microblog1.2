//
//  MyAccountTool.h
//  Microblog1.1
//
//  Created by 王志盼 on 15/3/29.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyBaseTool.h"
@class MyAccount,MyAccessTokenParam;

@interface MyAccountTool : MyBaseTool
+ (id)account;
+ (void)save:(MyAccount *)account;

/**
 *  获得accesToken
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)accessTokenWithParam:(MyAccessTokenParam *)param success:(void (^)(MyAccount *account))success failure:(void (^)(NSError *error))failure;
@end
