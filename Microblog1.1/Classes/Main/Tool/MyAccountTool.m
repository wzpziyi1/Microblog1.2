//
//  MyAccountTool.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/3/29.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyAccountTool.h"
#import "MyAccount.h"

#define accountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.txt"]

@implementation MyAccountTool

+ (id)account
{
    MyAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:accountPath];
    
    //NSLog(@"%@",account);
    
    NSDate *now = [NSDate date];
//    NSLog(@"--now--%@---account.expires_time---%@",now,account.expires_time);
    
    if ([now compare:account.expires_time] != NSOrderedAscending) {
        account = nil;
//        NSLog(@"-----------====");
    }
    return account;
}
+ (void)save:(MyAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:accountPath];
}
+ (void)accessTokenWithParam:(MyAccessTokenParam *)param success:(void (^)(MyAccount *))success failure:(void (^)(NSError *))failure
{
    [self postWithUrl:@"https://api.weibo.com/oauth2/access_token" param:param resultClass:[MyAccount class] success:success failure:failure];
}
@end
