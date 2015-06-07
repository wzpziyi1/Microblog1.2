//
//  MyEmotionTextView.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/6/6.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyEmotionTextView.h"
#import "MyEmotion.h"


@implementation MyEmotionTextView

- (void)appendEmotion:(MyEmotion *)emotion
{
    if (emotion.emoji) {
        [self insertText:emotion.emoji];
    }else
    {
        [self insertText:emotion.chs];
    }
}

@end
