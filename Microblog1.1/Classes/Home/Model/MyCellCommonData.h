//
//  MyCellCommonData.h
//  Microblog1.1
//
//  Created by 王志盼 on 15/4/27.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import <UIKit/UIKit.h>
// cell的计算参数
// cell之间的间距
#define MyStatusCellMargin 10

// cell的内边距
#define MyStatusCellInset 10

// 原创微博昵称字体
#define MyStatusOrginalNameFont [UIFont systemFontOfSize:13]
// 原创微博时间字体
#define MyStatusOrginalTimeFont [UIFont systemFontOfSize:11]
// 原创微博来源字体
#define MyStatusOrginalSourceFont MyStatusOrginalTimeFont
// 原创微博正文字体
#define MyStatusOrginalTextFont [UIFont systemFontOfSize:14]

// 转发微博昵称字体
#define MyStatusRetweetedNameFont MyStatusOrginalNameFont
// 转发微博正文字体
#define MyStatusRetweetedTextFont MyStatusOrginalTextFont

#define MyScreenW [UIScreen mainScreen].bounds.size.width
@interface MyCellCommonData : UIView

@end
