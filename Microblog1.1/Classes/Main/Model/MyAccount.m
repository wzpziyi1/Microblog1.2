//
//  MyAccount.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/3/29.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyAccount.h"

@implementation MyAccount


- (void)setExpires_in:(NSString *)expires_in
{
    _expires_in =  [expires_in copy];
    
    // 确定帐号的过期时间 ： 帐号创建时间 + 有效期
    NSDate *now = [NSDate date];
    self.expires_time = [now dateByAddingTimeInterval:expires_in.doubleValue];
}

- (id)initWithCoder:(NSCoder *)decode
{
    if (self = [super init]) {
        self.expires_in = [decode decodeObjectForKey:@"expires_in"];
        self.access_token = [decode decodeObjectForKey:@"access_token"];
        self.uid = [decode decodeObjectForKey:@"uid"];
        self.expires_time = [decode decodeObjectForKey:@"expires_time"];
        self.name = [decode decodeObjectForKey:@"name"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)encode
{
    [encode encodeObject:self.expires_in forKey:@"expires_in"];
    [encode encodeObject:self.access_token forKey:@"access_token"];
    [encode encodeObject:self.uid forKey:@"uid"];
    [encode encodeObject:self.expires_time forKey:@"expires_time"];
    [encode encodeObject:self.name forKey:@"name"];
}

@end
