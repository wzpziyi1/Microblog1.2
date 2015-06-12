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

// 富文本字体
#define MyStatusRichTextFont [UIFont systemFontOfSize:13]

#define MyColor(a,b,c) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1]
// 转发微博正文字体
#define MyStatusHighTextColor MyColor(88, 161, 253)

// 超链接文本
#define MyLinkText @"MyLinkText"

//链接被选的通知
#define MyLinkDidSelectedNotification @"MyLinkDidSelectedNotification"
