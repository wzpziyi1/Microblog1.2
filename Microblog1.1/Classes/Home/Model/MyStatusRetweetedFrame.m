//
//  MyStatusRetweetedFrame.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/4/27.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyStatusRetweetedFrame.h"
#import "MyStatus.h"
#import "MyUser.h"
#import "MyCellCommonData.h"
@implementation MyStatusRetweetedFrame

- (void)setRetweetedStatus:(MyStatus *)retweetedStatus
{
    _retweetedStatus = retweetedStatus;
    
    // 昵称
    CGFloat nameX = MyStatusCellInset;
    CGFloat nameY = MyStatusCellInset * 0.5;
    NSString *name = [NSString stringWithFormat:@"@%@", retweetedStatus.user.name];
    CGSize nameSize = [name sizeWithFont:MyStatusRetweetedNameFont];
    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    // 正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(self.nameFrame) + MyStatusCellInset * 0.5;
    CGFloat maxW = MyScreenW - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [retweetedStatus.text sizeWithFont:MyStatusRetweetedTextFont constrainedToSize:maxSize];
    self.textFrame = (CGRect){{textX, textY}, textSize};
    
    // 自己
    CGFloat x = 0;
    CGFloat y = 0; // 高度 = 原创微博最大的Y值
    CGFloat w = MyScreenW;
    CGFloat h = CGRectGetMaxY(self.textFrame) + MyStatusCellInset;
    self.frame = CGRectMake(x, y, w, h);
}

@end
