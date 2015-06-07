//
//  MyEmotionTool.h
//  Microblog1.1
//
//  Created by 王志盼 on 15/6/4.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyEmotion;

@interface MyEmotionTool : UIView
/**
 *  默认表情
 */
+ (NSArray *)defaultEmotions;
/**
 *  emoji表情
 */
+ (NSArray *)emojiEmotions;
/**
 *  浪小花表情
 */
+ (NSArray *)lxhEmotions;
/**
 *  最近表情
 */
+ (NSArray *)recentEmotions;

/**
 *  保存最近使用的表情
 */
+ (void)addRecentEmotion:(MyEmotion *)emotion;
@end
