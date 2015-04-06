//
//  MyFootView.h
//  Microblog1.1
//
//  Created by 王志盼 on 15/4/6.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyFootView : UIView
+ (instancetype)footView;
- (void)beginLoad;
- (void)endLoad;

@property (nonatomic, assign, getter=isRefreshing) BOOL refreshing;
@end
