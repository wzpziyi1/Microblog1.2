//
//  HMUserInfoParam.h
//  Microblog1.1
//
//  Created by 王志盼 on 15/4/19.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyBaseParam.h"
@interface MyUserInfoParam : MyBaseParam
///**	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。*/
//@property (nonatomic, copy) NSString *access_token;

/** false	int64	需要查询的用户ID。*/
@property (nonatomic, copy) NSString *uid;
@end
