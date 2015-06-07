//
//  MyEmotionView.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/5/20.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyEmotionView.h"
#import "MyEmotion.h"
@implementation MyEmotionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

- (void)setEmotion:(MyEmotion *)emotion
{
    _emotion = emotion;
    
    if (emotion.code) { // emoji表情
        // 取消动画效果
        [UIView setAnimationsEnabled:NO];
        // 设置emoji表情
        self.titleLabel.font = [UIFont systemFontOfSize:32];
        [self setTitle:emotion.emoji forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
        // 再次开启动画
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView setAnimationsEnabled:YES];
        });
    } else { // 图片表情
        NSString *icon = [NSString stringWithFormat:@"%@/%@", emotion.directory, emotion.png];
        UIImage *image = [UIImage imageNamed:icon];
        //不要渲染图片
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self setImage:image forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
    }
}

@end
