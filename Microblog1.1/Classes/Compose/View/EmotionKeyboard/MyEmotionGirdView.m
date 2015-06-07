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
#import "MyEmotionPopView.h"
#import "MyEmotionNotification.h"

#import "MyEmotionTool.h"

@interface MyEmotionGirdView ()
@property (nonatomic, strong) NSMutableArray *emotionViews;

@property (nonatomic, weak) UIButton *deleteButton;

@property (nonatomic, strong) MyEmotionPopView *popView;
@end

@implementation MyEmotionGirdView

- (MyEmotionPopView *)popView
{
    if (!_popView) {
        _popView = [MyEmotionPopView popView];
    }
    return _popView;
}

- (NSMutableArray *)emotionViews
{
    if (!_emotionViews) {
        self.emotionViews = [NSMutableArray array];
    }
    return _emotionViews;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加删除按钮
        UIButton *deleteButton = [[UIButton alloc] init];
        [deleteButton setImage:[UIImage imageWithName:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageWithName:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        self.deleteButton = deleteButton;
        
        // 添加一个长按手势识别器
        UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] init];
        [recognizer addTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:recognizer];
    }
    return self;
}


/**
 *  触发长按手势
 *
 */
- (void)longPress:(UILongPressGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView:recognizer.view];
    
    // 检测触摸点落在哪个表情上
    MyEmotionView *emotionView = [self emotionViewWithPoint:point];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) { // 手松开了
        // 移除表情弹出控件
        [self.popView dismiss];
        
        // 选中表情
        [self selecteEmotion:emotionView.emotion];
    } else { // 手没有松开
        // 显示表情弹出控件
        [self.popView showFromEmotionView:emotionView];
    }
}

/**
 *  选中表情
 */
- (void)selecteEmotion:(MyEmotion *)emotion
{
    if (emotion == nil) return;
    
#warning 注意：先添加使用的表情，再发通知
    // 保存使用记录
    [MyEmotionTool addRecentEmotion:emotion];
    
    // 发出一个选中表情的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:MyEmotionDidSelectedNotification object:nil userInfo:@{MySelectedEmotion : emotion}];
}

/**
 *  根据触摸点返回对应的表情控件
 */
- (MyEmotionView *)emotionViewWithPoint:(CGPoint)point
{
    __block MyEmotionView *foundEmotionView = nil;
    [self.emotionViews enumerateObjectsUsingBlock:^(MyEmotionView *emotionView, NSUInteger idx, BOOL *stop) {
        if (CGRectContainsPoint(emotionView.frame, point)) {
            foundEmotionView = emotionView;
            *stop = YES;
        }
    }];
    return foundEmotionView;
}

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
            [emotionView addTarget:self action:@selector(emotionClick:) forControlEvents:UIControlEventTouchUpInside];
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

/**
 *  监听表情的单击
 */
- (void)emotionClick:(MyEmotionView *)emotionView
{
    [self.popView showFromEmotionView:emotionView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView dismiss];
    });
    
    // 选中表情
    [self selecteEmotion:emotionView.emotion];
}

/**
 *  点击了删除按钮
 */
- (void)deleteClick
{
    [[NSNotificationCenter defaultCenter] postNotificationName:MyEmotionDidDeletedNotification object:nil userInfo:nil];
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
        UIButton *emotionView = self.emotionViews[i];
        CGFloat emotionViewX = leftInset + (i % MyEmotionMaxCols) * emotionViewW;
        CGFloat emotionViewY = topInset + (i / MyEmotionMaxCols) * emotionViewH;
        emotionView.frame = CGRectMake(emotionViewX, emotionViewY, emotionViewW, emotionViewH);
    }
    
    // 删除按钮
    self.deleteButton.frame = CGRectMake(self.frame.size.width - leftInset - self.deleteButton.frame.size.width, self.frame.size.height - self.deleteButton.frame.size.height, emotionViewW, emotionViewH);
}
@end
