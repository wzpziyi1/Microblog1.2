//
//  MyEmotionToolbar.h
//  Microblog1.1
//
//  Created by 王志盼 on 15/5/19.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyEmotionToolbar;

typedef enum {
    MyEmotionTypeRecent, // 最近
    MyEmotionTypeDefault, // 默认
    MyEmotionTypeEmoji, // Emoji
    MyEmotionTypeLxh // 浪小花
} MyEmotionType;

@protocol MyEmotionToolbarDelegate <NSObject>

@optional
- (void)emotionToolbar:(MyEmotionToolbar *)toolbar didSelectedButton:(MyEmotionType)emotionType;
@end

@interface MyEmotionToolbar : UIView
@property (nonatomic, weak) id<MyEmotionToolbarDelegate> delegate;
@end
