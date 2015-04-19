//
//  MyUserTool.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/4/19.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyUserTool.h"
#import "MJExtension.h"
#import "MyHttpTool.h"
#import "MyUserInfoParam.h"
#import "MyUserInfoResult.h"

@implementation MyUserTool
+ (void)userInfoWithParam:(MyUserInfoParam *)param success:(void (^)(MyUserInfoResult *result))success failure:(void (^)(NSError *error))failure
{
    [self getWithUrl:@"https://api.weibo.com/2/users/show.json" param:param resultClass:[MyUserInfoResult class] success:success failure:failure];
}
@end
