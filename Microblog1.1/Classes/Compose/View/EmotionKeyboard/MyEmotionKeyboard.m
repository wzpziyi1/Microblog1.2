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
@interface MyEmotionKeyboard () <MyEmotionToolbarDelegate>
@property (nonatomic, weak) MyEmotionToolbar *toolbar;
@property (nonatomic, weak) MyEmotionListView *listView;

@property (nonatomic, strong) NSArray *defaultEmotions;
/**  emoji  */
@property (nonatomic, strong) NSArray *emojiEmotions;
/**  浪小花  */
@property (nonatomic, strong) NSArray *lxhEmotions;
@end

@implementation MyEmotionKeyboard

- (NSArray *)defaultEmotions
{
    if (_defaultEmotions == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        _defaultEmotions = [MyEmotion objectArrayWithFile:path];
//        NSLog(@"%@",_defaultEmotions);
    }
    return _defaultEmotions;
}

- (NSArray *)emojiEmotions
{
    if (_emojiEmotions == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        _emojiEmotions = [MyEmotion objectArrayWithFile:path];
    }
    return _emojiEmotions;
}

- (NSArray *)lxhEmotions
{
    if (_lxhEmotions == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        _lxhEmotions = [MyEmotion objectArrayWithFile:path];
    }
    return _lxhEmotions;
}
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
            self.listView.emotions = self.defaultEmotions;
            break;
            
        case MyEmotionTypeEmoji: // Emoji
            self.listView.emotions = self.emojiEmotions;
            break;
            
        case MyEmotionTypeLxh: // 浪小花
            self.listView.emotions = self.lxhEmotions;
            break;
            
        default:
            break;
    }
}

@end
