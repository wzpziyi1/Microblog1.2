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
#import "MyUnreadCountParam.h"
#import "MyAccountTool.h"
#import "MyUserTool.h"
#import "MyUnreadCountResult.h"
@interface MyTabBarController ()<UITabBarControllerDelegate, MyTabBarDelegate>

@property (nonatomic, weak) MyHomeViewController *homeVc;
@property (nonatomic, weak) MyMessageViewController *messageVc;
@property (nonatomic, weak) MyDiscoverViewController *discoverVc;
@property (nonatomic, weak) MyProfileViewController *profileVc;

@property (nonatomic, weak) UIViewController *lastSelectedVc;
@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTabBar];
    
    //让选定的为第一个控制器
    self.lastSelectedVc = self.homeVc;
    
   // self.delegate = self;
    
    // 利用定时器获得用户的未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(getUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)getUnreadCount
{
    // 请求参数
    MyUnreadCountParam *param = [MyUnreadCountParam param];
    param.uid = [[MyAccountTool account] uid];
    
    // 获得未读数
    [MyUserTool unreadCountWithParam:param success:^(MyUnreadCountResult *result) {
        // 显示微博未读数
        if (result.status == 0) {
            self.homeVc.tabBarItem.badgeValue = nil;
        } else {
            self.homeVc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        }
        
        // 显示消息未读数
        if (result.messageCount == 0) {
            self.messageVc.tabBarItem.badgeValue = nil;
        } else {
            self.messageVc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.messageCount];
        }
        
        // 显示新粉丝数
        if (result.follower == 0) {
            self.profileVc.tabBarItem.badgeValue = nil;
        } else {
            self.profileVc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.follower];
        }
        
        // 在图标上显示所有的未读数
//        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalCount;
    } failure:^(NSError *error) {
        NSLog(@"获得未读数失败---%@", error);
    }];
}



- (void)setupTabBar
{
    MyHomeViewController *homeController = [[MyHomeViewController alloc] init];
    
    [self addOneChildVC:homeController title:@"首页" imageName:@"tabbar_home" selectedName:@"tabbar_home_selected"];
    self.homeVc = homeController;
    
    MyMessageViewController *messageController = [[MyMessageViewController alloc] init];
    
    [self addOneChildVC:messageController title:@"消息" imageName:@"tabbar_message_center" selectedName:@"tabbar_message_center_selected"];
    self.messageVc = messageController;
    
    
    MyDiscoverViewController *discoverController = [[MyDiscoverViewController alloc] init];
    
    
    [self addOneChildVC:discoverController title:@"发现" imageName:@"tabbar_discover" selectedName:@"tabbar_discover_selected"];
    self.discoverVc = discoverController;
    
    MyProfileViewController *profile = [[MyProfileViewController alloc] init];
    
    [self addOneChildVC:profile title:@"我" imageName:@"tabbar_profile" selectedName:@"tabbar_profile_selected"];
    self.profileVc = profile;
    
    
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

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UINavigationController *)viewController
{
    [self.tabBar setNeedsLayout];
    
    UIViewController *Vc = [viewController.viewControllers firstObject];
    
    if ([Vc isKindOfClass:[self.homeVc class]]) {
        
        [self.homeVc refresh:self.lastSelectedVc == Vc];
    }
    self.lastSelectedVc = Vc;
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
