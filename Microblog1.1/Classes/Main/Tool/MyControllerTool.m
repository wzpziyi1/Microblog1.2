//
//  MyControllerTool.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/3/29.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyControllerTool.h"
#import "MyTabBarController.h"
#import "MyNewfeatureViewController.h"

@implementation MyControllerTool
+ (void)chooseRootViewController
{
    // 从沙盒中取出上次存储的软件版本号(取出用户上次的使用记录)
    NSString *versionKey = @"CFBundleVersion";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults objectForKey:versionKey];
    
    // 获得当前打开软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    if ([currentVersion isEqualToString:lastVersion]) { // 当前版本号 == 上次使用的版本,直接进入
        MyTabBarController *tabController = [[MyTabBarController alloc] init];
        window.rootViewController = tabController;
    } else { // 当前版本号 != 上次使用的版本：显示版本新特性
        window.rootViewController = [[MyNewfeatureViewController alloc] init];
        
        // 存储这次使用的软件版本
        [defaults setObject:currentVersion forKey:versionKey];
        [defaults synchronize];
    }
}
@end
