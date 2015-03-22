//
//  UINavigationItem+Extension.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/3/21.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "UINavigationItem+Extension.h"
#import "UIImage+Extension.h"

@implementation UINavigationItem (Extension)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)hightImageName target:(id)target action:(SEL)action
{
    UIButton *bnt = [[UIButton alloc] init];
    
    [bnt setBackgroundImage:[UIImage imageWithName:imageName] forState:UIControlStateNormal];
    [bnt setBackgroundImage:[UIImage imageWithName:hightImageName] forState:UIControlStateHighlighted];
    [bnt addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    bnt.frame = CGRectMake(0, 0, bnt.currentBackgroundImage.size.width, bnt.currentBackgroundImage.size.height);
    return [[UIBarButtonItem alloc] initWithCustomView:bnt];
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title font:(CGFloat)font target:(UIViewController *)target action:(SEL)action
{
    UIButton *bnt = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [bnt setTitle:title forState:UIControlStateNormal];
    [bnt setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [bnt setTitle:title forState:UIControlStateHighlighted];
    [bnt setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [bnt setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    bnt.titleLabel.font = [UIFont systemFontOfSize:font];
    [bnt sizeToFit];
    [bnt addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return  [[UIBarButtonItem alloc] initWithCustomView:bnt];
}
@end
