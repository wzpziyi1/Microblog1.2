//
//  MyStatusRetweetedFrame.h
//  Microblog1.1
//
//  Created by 王志盼 on 15/4/27.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyStatus;
@interface MyStatusRetweetedFrame : UIView
/** 昵称 */
@property (nonatomic, assign) CGRect nameFrame;
/** 正文 */
@property (nonatomic, assign) CGRect textFrame;

/** 自己的frame */
@property (nonatomic, assign) CGRect frame;

/** 转发微博的数据 */
@property (nonatomic, strong) MyStatus *retweetedStatus;
@end
