//
//  MyStatusFrame.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/4/27.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyStatusFrame.h"
#import "MyStatus.h"
#import "MyStatusDetailFrame.h"
#import "MyCellCommonData.h"
@implementation MyStatusFrame

- (void)setStatus:(MyStatus *)status
{
    _status = status;
    
    // 计算微博具体内容
    [self setupDetailFrame];
    
    // 计算底部工具条
    [self setupToolbarFrame];
    
    // 计算cell的高度
    self.cellHeight = CGRectGetMaxY(self.toolbarFrame);
}

/**
 *  计算微博具体内容（微博整体）
 */
- (void)setupDetailFrame
{
    MyStatusDetailFrame *detailFrame = [[MyStatusDetailFrame alloc] init];
    detailFrame.status = self.status;
    self.detailFrame = detailFrame;
}

/**
 *  计算底部工具条
 */
- (void)setupToolbarFrame
{
    CGFloat toolbarX = 0;
    CGFloat toolbarY = CGRectGetMaxY(self.detailFrame.frame);
    CGFloat toolbarW = MyScreenW;
    CGFloat toolbarH = 35;
    self.toolbarFrame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
}

@end
