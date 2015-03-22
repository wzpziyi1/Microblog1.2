//
//  UIImage+Extension.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/3/20.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
+ (UIImage *)imageWithName:(NSString *)name
{
    NSString *actualName = name;
    if ([[UIDevice currentDevice].systemVersion floatValue] > 7.0) {
        actualName = [actualName stringByAppendingFormat:@"_os7"];
    }
    if ([UIImage imageNamed:actualName] == nil) {
        actualName = name;
    }
    //NSLog(@"%@",actualName);
    return [UIImage imageNamed:actualName];
}
+ (UIImage *)resizedImage:(NSString *)name
{
    
    UIImage *image = [UIImage imageWithName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}
@end
