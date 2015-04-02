//
//  MyAccount.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/3/29.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyAccount.h"

@implementation MyAccount

+ (id)accountWithDict:(NSDictionary *)dict
{
    MyAccount *account = [[MyAccount  alloc] init];
    account.expires_in = dict[@"expires_in"];
    account.access_token = dict[@"access_token"];
    account.uid = dict[@"uid"];
    
    //获取现在时间
    NSDate *now = [NSDate date];
    //计算账号过期时间
    account.expires_time = [now dateByAddingTimeInterval:account.expires_in.doubleValue];
    return account;
}

- (id)initWithCoder:(NSCoder *)decode
{
    if (self = [super init]) {
        self.expires_in = [decode decodeObjectForKey:@"expires_in"];
        self.access_token = [decode decodeObjectForKey:@"access_token"];
        self.uid = [decode decodeObjectForKey:@"uid"];
        self.expires_time = [decode decodeObjectForKey:@"expires_time"];

    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)encode
{
    [encode encodeObject:self.expires_in forKey:@"expires_in"];
    [encode encodeObject:self.access_token forKey:@"access_token"];
    [encode encodeObject:self.uid forKey:@"uid"];
    [encode encodeObject:self.expires_time forKey:@"expires_time"];
}

@end
