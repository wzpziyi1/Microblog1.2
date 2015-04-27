//
//  MyStatusDetailFrame.h
//  Microblog1.1
//
//  Created by 王志盼 on 15/4/27.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyStatus, MyStatusOriginalFrame, MyStatusRetweetedFrame;
@interface MyStatusDetailFrame : UIView
@property (nonatomic, strong) MyStatusOriginalFrame *originalFrame;
@property (nonatomic, strong) MyStatusRetweetedFrame *retweetedFrame;

/** 微博数据 */
@property (nonatomic, strong) MyStatus *status;

/**
 *  自己的frame
 */
@property (nonatomic, assign) CGRect frame;
@end
