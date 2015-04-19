//
//  MyUnreadCountResult.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/4/19.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyUnreadCountResult.h"

@implementation MyUnreadCountResult
- (int)messageCount
{
    return self.cmt + self.dm + self.mention_cmt + self.mention_status;
}

- (int)totalCount
{
    return self.messageCount + self.status + self.follower;
}
@end
