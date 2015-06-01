//
//  MyEmotionGirdView.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/5/20.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

// 表情的最大行数
#define MyEmotionMaxRows 3
// 表情的最大列数
#define MyEmotionMaxCols 7
// 每页最多显示多少个表情
#define MyEmotionMaxCountPerPage (MyEmotionMaxRows * MyEmotionMaxCols - 1)

#import "MyEmotionGirdView.h"
#import "MyEmotion.h"
#import "UIImage+Extension.h"
#import "MyEmotionView.h"

@interface MyEmotionGirdView ()
@property (nonatomic, strong) NSMutableArray *emotionViews;
@end

@implementation MyEmotionGirdView

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    // 添加新的表情
    int count = emotions.count;
    int currentEmotionViewCount = self.emotionViews.count;
    for (int i = 0; i<count; i++) {
        MyEmotionView *emotionView = nil;
        
        if (i >= currentEmotionViewCount) { // emotionView不够用
            emotionView = [[MyEmotionView alloc] init];
//            emotionView.backgroundColor = MyRandomColor;
            [self addSubview:emotionView];
            [self.emotionViews addObject:emotionView];
        } else { // emotionView够用
            emotionView = self.emotionViews[i];
        }
        // 传递模型数据
        emotionView.emotion = emotions[i];
        emotionView.hidden = NO;
    }
    
    // 隐藏多余的emotionView
    for (int i = count; i<currentEmotionViewCount; i++) {
        UIButton *emotionView = self.emotionViews[i];
        emotionView.hidden = YES;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat leftInset = 15;
    CGFloat topInset = 15;
//
    int count = self.emotions.count;
    CGFloat emotionViewW = (self.frame.size.width - 2 * leftInset) / MyEmotionMaxCols;
    CGFloat emotionViewH = (self.frame.size.height - topInset) / MyEmotionMaxRows;
    for (int i = 0; i<count; i++) {
        UIButton *emotionView = self.subviews[i];
        CGFloat emotionViewX = leftInset + (i % MyEmotionMaxCols) * emotionViewW;
        CGFloat emotionViewY = topInset + (i / MyEmotionMaxCols) * emotionViewH;
        emotionView.frame = CGRectMake(emotionViewX, emotionViewY, emotionViewW, emotionViewH);
    }
}
@end
