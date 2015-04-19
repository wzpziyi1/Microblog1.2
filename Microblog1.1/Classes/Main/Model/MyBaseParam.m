//
//  MyBaseParam.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/4/19.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyBaseParam.h"
#import "MyAccountTool.h"
#import "MyAccount.h"

@implementation MyBaseParam
- (id)init
{
    if (self = [super init]) {
        self.access_token = [[MyAccountTool account] access_token];
    }
    return self;
}

+ (instancetype)param
{
    return [[self alloc] init];
}
@end
