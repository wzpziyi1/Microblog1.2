//
//  MyStatus.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/3/29.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyStatus.h"
#import "MJExtension.h"
#import "MyPhoto.h"
@implementation MyStatus
+ (NSMutableDictionary *)objectClassInArray
{
    return @{@"pic_urls":[MyPhoto class]};
}
@end
