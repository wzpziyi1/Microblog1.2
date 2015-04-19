//
//  HMStatusTool.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/4/19.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyStatusTool.h"
#import "MyHTTPTool.h"

@implementation MyStatusTool
+ (void)homeStatusesWithParam:(MyHomeStatusesParam *)param success:(void (^)(MyHomeStatusesResult *result))success failure:(void (^)(NSError *error))failure
{
    [self getWithUrl:@"https://api.weibo.com/2/statuses/home_timeline.json" param:param resultClass:[MyHomeStatusesResult class] success:success failure:failure];
}
+ (void)sendStatusWithParam:(MySendStatusParam *)param success:(void (^)(MySendStatusResult *result))success failure:(void (^)(NSError *error))failure
{
    [self postWithUrl:@"https://api.weibo.com/2/statuses/update.json" param:param resultClass:[MySendStatusResult class] success:success failure:failure];
}
@end
