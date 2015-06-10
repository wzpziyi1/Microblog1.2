//
//  MyEmotionAttachment.h
//  Microblog1.1
//
//  Created by 王志盼 on 15/6/7.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyEmotion;

@interface MyEmotionAttachment : NSTextAttachment
@property (nonatomic, strong) MyEmotion *emotion;
@end
