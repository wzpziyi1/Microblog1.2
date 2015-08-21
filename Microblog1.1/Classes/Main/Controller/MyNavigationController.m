//
//  MyNavigationController.m
//  Microblog
//
//  Created by 王志盼 on 15/3/20.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyNavigationController.h"
#import "UIImage+Extension.h"
#import "UINavigationItem+Extension.h"
#import "UIImage+Extension.h"

@interface MyNavigationController ()

@end

@implementation MyNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 * 这个方法，不管这个类被创建多少次，都只会调用一次，我们在这个方法里面可以做
 *导航栏的item属性的一些设置
 */
+ (void)initialize
{
    [self setBarButtonStyle];
    
    [self   setNaviagtionTheme];
}

+ (void)setNaviagtionTheme   //设置导航栏主题
{

    
    UINavigationBar *appearance = [UINavigationBar appearance];
    
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor] = [UIColor blackColor];
 

    textAttrs[UITextAttributeFont] = [UIFont boldSystemFontOfSize:20];//粗体，
    // UIOffsetZero是结构体, 只要包装成NSValue对象, 才能放进字典\数组中
    textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    [appearance setTitleTextAttributes:textAttrs];
}

+ (void)setBarButtonStyle     //需要注意
{
    
    //通过设置这个属性，可是设置整个导航栏的UIBarButtonItem的属性
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    //设置普通状态下得文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    //文字颜色
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    //文字字体
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:18.0];
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置高亮状态的文字属性
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionary];
    highTextAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    highTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    
    // 设置不可用状态(disable)的文字属性
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    disableTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [appearance setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    if (self.childViewControllers.count > 0) {   //这里应该是self，而不是viewController，因为当前的控制器就是viewController所在的导航控制器
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [UINavigationItem itemWithImageName:@"navigationbar_back" highImageName:@"navigationbar_back_highlighted" target:self action:@selector(back)];
        
        viewController.navigationItem.rightBarButtonItem = [UINavigationItem itemWithImageName:@"navigationbar_more" highImageName:@"navigationbar_more_highlighted" target:self action:@selector(more)];
    }
    [super pushViewController:viewController animated:YES];
}

- (void)back
{
    
    [self popViewControllerAnimated:YES];  //这里也是一样的原因，当前所在的导航控制器
}
- (void)more
{
    [self popToRootViewControllerAnimated:YES];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
