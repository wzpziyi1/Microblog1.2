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

#import "MyComposeViewController.h"

#import "MyTabBar.h"
@interface MyTabBarController ()<UITabBarControllerDelegate, MyTabBarDelegate>

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    MyHomeViewController *homeController = [[MyHomeViewController alloc] init];
    
    [self addOneChildVC:homeController title:@"首页" imageName:@"tabbar_home" selectedName:@"tabbar_home_selected"];
    
    MyMessageViewController *messageController = [[MyMessageViewController alloc] init];
    
    [self addOneChildVC:messageController title:@"消息" imageName:@"tabbar_message_center" selectedName:@"tabbar_message_center_selected"];
    
    
    MyDiscoverViewController *discoverController = [[MyDiscoverViewController alloc] init];

   
    [self addOneChildVC:discoverController title:@"发现" imageName:@"tabbar_discover" selectedName:@"tabbar_discover_selected"];
    
    MyProfileViewController *profile = [[MyProfileViewController alloc] init];
    
    [self addOneChildVC:profile title:@"我" imageName:@"tabbar_profile" selectedName:@"tabbar_profile_selected"];
    
    
    //调整tabbar，将加号按钮添加到tarBar上去
    MyTabBar *tabBar = [[MyTabBar alloc] init];
    tabBar.delegatePlus = self;
    //利用kvc取代系统自带的tabbar，因为系统自带tabbar是只读，所以只能用kvc,这一句是重点，不然得完全自定义控件
    [self setValue:tabBar forKey:@"tabBar"];
    self.delegate = self;
}

- (void)tabBarDidPlusBntClick
{
    MyNavigationController *Vc = [[MyNavigationController alloc] initWithRootViewController:[[MyComposeViewController alloc] init]];
    
    [self presentViewController:Vc animated:YES completion:nil];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [self.tabBar setNeedsLayout];
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
