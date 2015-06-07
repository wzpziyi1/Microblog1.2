//
//  MyEmotionKeyboard.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/5/19.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyEmotionKeyboard.h"
#import "MyEmotionListView.h"
#import "MyEmotionToolbar.h"
#import "MJExtension.h"
#import "MyEmotion.h"

#import "MyEmotionTool.h"
@interface MyEmotionKeyboard () <MyEmotionToolbarDelegate>
@property (nonatomic, weak) MyEmotionToolbar *toolbar;
@property (nonatomic, weak) MyEmotionListView *listView;

@end

@implementation MyEmotionKeyboard

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
//    self.backgroundColor = [UIColor redColor];
    MyEmotionToolbar *toolbar = [[MyEmotionToolbar alloc] init];
    [self addSubview:toolbar];
    self.toolbar = toolbar;
    
    
    MyEmotionListView *listView = [[MyEmotionListView alloc] init];
    [self addSubview:listView];
    self.listView = listView;
//    [listView setBackgroundColor:[UIColor redColor]];
    
    toolbar.delegate = self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat toolbarW = self.frame.size.width;
    CGFloat toolbarH = 35;
    CGFloat toolbarX = 0;
    CGFloat toolbarY = self.frame.size.height - toolbarH;
    self.toolbar.frame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    
    CGFloat listViewX = 0;
    CGFloat listViewY = 0;
    CGFloat listViewW = toolbarW;
    CGFloat listViewH = self.frame.size.height - toolbarH;
    self.listView.frame = CGRectMake(listViewX, listViewY, listViewW, listViewH);
}

#pragma MyEmotionToolbarDelegate
- (void)emotionToolbar:(MyEmotionToolbar *)toolbar didSelectedButton:(MyEmotionType)emotionType
{
    switch (emotionType) {
        case MyEmotionTypeDefault:// 默认
            self.listView.emotions = [MyEmotionTool defaultEmotions];
            break;
            
        case MyEmotionTypeEmoji: // Emoji
            self.listView.emotions = [MyEmotionTool emojiEmotions];
            break;
            
        case MyEmotionTypeLxh: // 浪小花
            self.listView.emotions = [MyEmotionTool lxhEmotions];
            break;
            
        default:
            self.listView.emotions = [MyEmotionTool recentEmotions];
            break;
    }
}

@end
