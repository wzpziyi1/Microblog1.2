//
//  MyTabBarController.m
//  Microblog
//
//  Created by 王志盼 on 15/3/20.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyTabBarController.h"
#import "MyNavigationController.h"
#import "UIImage+Extension.h"
#import "UINavigationItem+Extension.h"

#import "MyHomeViewController.h"
#import "MyMessageViewController.h"
#import "MyDiscoverViewController.h"
#import "MyProfileViewController.h"
@interface MyTabBarController ()

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    MyHomeViewController *homeController = [[MyHomeViewController alloc] init];
    //[homeController.view setBackgroundColor:[UIColor redColor]];
    
    [self addOneChildVC:homeController title:@"首页" imageName:@"tabbar_home" selectedName:@"tabbar_home_selected"];
    
    MyMessageViewController *messageController = [[MyMessageViewController alloc] init];
    //[messageController.view setBackgroundColor:[UIColor greenColor]];
    
    [self addOneChildVC:messageController title:@"消息" imageName:@"tabbar_message_center" selectedName:@"tabbar_message_center_selected"];
    
    
    MyDiscoverViewController *discoverController = [[MyDiscoverViewController alloc] init];
    //[discoverController.view setBackgroundColor:[UIColor blueColor]];
   
    [self addOneChildVC:discoverController title:@"发现" imageName:@"tabbar_discover" selectedName:@"tabbar_discover_selected"];
    
    MyProfileViewController *profile = [[MyProfileViewController alloc] init];
    //[profile.view setBackgroundColor:[UIColor yellowColor]];
    
    [self addOneChildVC:profile title:@"我" imageName:@"tabbar_profile" selectedName:@"tabbar_profile_selected"];
    
}

- (void)addOneChildVC:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedName:(NSString *)selectedName
{
    childVc.tabBarItem.title = title;
    childVc.navigationItem.title = title;
    UIImage *selectImage;
    if ([title isEqualToString:@"首页"]) {
        childVc.tabBarItem.image = [UIImage imageNamed:imageName];
        selectImage = [UIImage imageNamed:selectedName];
    }
    else
    {
        childVc.tabBarItem.image = [UIImage imageWithName:imageName];
        selectImage = [UIImage imageWithName:selectedName];
    }
    selectImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectImage;
    MyNavigationController *navigation = [[MyNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:navigation];
}


@end
