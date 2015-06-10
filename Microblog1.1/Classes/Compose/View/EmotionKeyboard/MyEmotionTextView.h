//
//  MyEmotionTextView.h
//  Microblog1.1
//
//  Created by 王志盼 on 15/6/6.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyTextView.h"

@class MyEmotion;

@interface MyEmotionTextView : MyTextView
/**
 *  拼接表情到最后面
 */
- (void)appendEmotion:(MyEmotion *)emotion;


/**
 *  text里面的具体内容（需要把图片（用正则表达式）转化为文本，然后，在发出成果显示的时候，再转化回图片）
 *
 */
- (NSString *)realText;
@end
