//
//  UINavigationItem+Extension.h
//  Microblog1.1
//
//  Created by 王志盼 on 15/3/21.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (Extension)  //这个分类写错了，应该是扩展UIBarButtonItem
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)hightImageName target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title font:(CGFloat)font target:(UIViewController *)target action:(SEL)action;
@end
