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
        // emotion.code == 0x1f603 --> \u54367
        // emoji的大小取决于字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:32];
        [self setTitle:emotion.emoji forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
    } else { // 图片表情
        NSString *icon = [NSString stringWithFormat:@"%@/%@", emotion.directory, emotion.png];
        [self setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
    }
}

@end
