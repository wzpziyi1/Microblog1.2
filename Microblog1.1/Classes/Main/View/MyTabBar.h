//
//  MyTabBar.h
//  Microblog1.1
//
//  Created by 王志盼 on 15/3/25.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyTabBar;

@protocol MyTabBarDelegate <NSObject>
@optional
- (void)tabBarDidPlusBntClick;

@end

@interface MyTabBar : UITabBar
@property (nonatomic, weak) id <MyTabBarDelegate>delegatePlus;
@end
