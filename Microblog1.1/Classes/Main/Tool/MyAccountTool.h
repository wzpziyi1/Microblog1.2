//
//  MyAccountTool.h
//  Microblog1.1
//
//  Created by 王志盼 on 15/3/29.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyAccount;

@interface MyAccountTool : NSObject
+ (id)account;
+ (void)save:(MyAccount *)account;
@end
