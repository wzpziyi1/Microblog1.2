//
//  MyHomeStatusesResult.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/4/19.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyHomeStatusesResult.h"
#import "MJExtension.h"
#import "MyStatus.h"

@implementation MyHomeStatusesResult
- (NSDictionary *)objectClassInArray
{
    return @{@"statuses" : [MyStatus class]};
}
@end
