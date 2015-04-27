//
//  MyStatusDetailFrame.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/4/27.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyStatusDetailFrame.h"
#import "MyStatus.h"
#import "MyStatusOriginalFrame.h"
#import "MyStatusRetweetedFrame.h"
#import "MyCellCommonData.h"

@implementation MyStatusDetailFrame

- (void)setStatus:(MyStatus *)status
{
    _status = status;
    
    // 计算原创微博的frame
    MyStatusOriginalFrame *originalFrame = [[MyStatusOriginalFrame alloc] init];
    originalFrame.status = status;
    self.originalFrame = originalFrame;
    
    // 计算转发微博的frame
    CGFloat h = 0;
    if (status.retweeted_status) {
        MyStatusRetweetedFrame *retweetedFrame = [[MyStatusRetweetedFrame alloc] init];
        retweetedFrame.retweetedStatus = status.retweeted_status;
        
        // 计算转发微博frame的y值
        CGRect f = retweetedFrame.frame;
        f.origin.y = CGRectGetMaxY(originalFrame.frame);
        retweetedFrame.frame = f;
        
        self.retweetedFrame = retweetedFrame;
        
        h = CGRectGetMaxY(retweetedFrame.frame);
    } else {
        h = CGRectGetMaxY(originalFrame.frame);
    }
    
    // 自己的frame
    CGFloat x = 0;
    CGFloat y = MyStatusCellMargin;
    CGFloat w = MyScreenW;
    self.frame = CGRectMake(x, y, w, h);
}

@end
