//
//  MyStatusOriginalFrame.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/4/27.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyStatusOriginalFrame.h"
#import "MyStatus.h"
#import "MyUser.h"
#import "MyCellCommonData.h"
@implementation MyStatusOriginalFrame

- (void)setStatus:(MyStatus *)status
{
    _status = status;
    
    // 头像
    CGFloat iconX = MyStatusCellInset;
    CGFloat iconY = MyStatusCellInset;
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 昵称
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + MyStatusCellInset;
    CGFloat nameY = iconY;
    CGSize nameSize = [status.user.name sizeWithFont:MyStatusOrginalNameFont];
    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    if (status.user.isVip) { // 计算会员图标的位置
        CGFloat vipX = CGRectGetMaxX(self.nameFrame) + MyStatusCellInset;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = vipH;
        self.vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    // 时间
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameFrame) + MyStatusCellInset * 0.5;
    CGSize timeSize = [status.created_at sizeWithFont:MyStatusOrginalTimeFont];
    self.timeFrame = (CGRect){{timeX, timeY}, timeSize};
    
    // 来源
    CGFloat sourceX = CGRectGetMaxX(self.timeFrame) + MyStatusCellInset;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:MyStatusOrginalSourceFont];
    self.sourceFrame = (CGRect){{sourceX, sourceY}, sourceSize};
    
    // 正文
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(self.iconFrame) + MyStatusCellInset;
    CGFloat maxW = MyScreenW - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [status.text sizeWithFont:MyStatusOrginalTextFont constrainedToSize:maxSize];
    self.textFrame = (CGRect){{textX, textY}, textSize};
    
    // 自己
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = MyScreenW;
    CGFloat h = CGRectGetMaxY(self.textFrame) + MyStatusCellInset;
    self.frame = CGRectMake(x, y, w, h);
}

@end
