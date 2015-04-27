//
//  MyStatusFrame.h
//  Microblog1.1
//
//  Created by 王志盼 on 15/4/27.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyStatus, MyStatusDetailFrame;
@interface MyStatusFrame : NSObject
/** 子控件的frame数据 */
@property (nonatomic, assign) CGRect toolbarFrame;

@property (nonatomic, strong) MyStatusDetailFrame *detailFrame;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

/** 微博数据 */
@property (nonatomic, strong) MyStatus *status;
@end
