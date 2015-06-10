//
//  MyEmotionAttachment.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/6/7.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyEmotionAttachment.h"
#import "MyEmotion.h"

@implementation MyEmotionAttachment
- (void)setEmotion:(MyEmotion *)emotion
{
    _emotion = emotion;
    self.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", emotion.directory, emotion.png]];
}
@end
