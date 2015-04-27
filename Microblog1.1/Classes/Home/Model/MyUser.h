//
//  MyUser.h
//  Microblog1.1
//
//  Created by 王志盼 on 15/3/29.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyUser : NSObject
/** string 	友好显示名称 */
@property (nonatomic, copy) NSString *name;

/** string 	用户头像地址（中图），50×50像素 */
@property (nonatomic, copy) NSString *profile_image_url;

/** 会员类型 */
@property (nonatomic, assign) int mbtype;

/** 会员等级 */
@property (nonatomic, assign) int mbrank;

@property (nonatomic, assign, getter = isVip, readonly) BOOL vip;
@end
