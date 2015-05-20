//
//  MyEmotionToolbar.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/5/19.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#define MyEmotionToolbarButtonMaxCount 4

#import "MyEmotionToolbar.h"
#import "UIImage+Extension.h"

@interface MyEmotionToolbar()
/** 记录当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;
@end

@implementation MyEmotionToolbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.添加4个按钮
        [self setupButton:@"最近" tag:MyEmotionTypeRecent];
        UIButton *defaultButton = [self setupButton:@"默认" tag:MyEmotionTypeDefault];
        [self setupButton:@"Emoji" tag:MyEmotionTypeEmoji];
        [self setupButton:@"浪小花" tag:MyEmotionTypeLxh];
        
        // 2.默认选中“默认”按钮
        [self buttonClick:defaultButton];
    }
    return self;
}

/**
 *  在这里选择默认按钮
 *
 */
- (void)setDelegate:(id<MyEmotionToolbarDelegate>)delegate
{
    _delegate = delegate;
    
    // 获得“默认”按钮
    UIButton *defaultButton = (UIButton *)[self viewWithTag:MyEmotionTypeDefault];
    // 默认选中“默认”按钮
    [self buttonClick:defaultButton];
}

/**
 *  添加按钮
 *
 *  @param title 按钮文字
 */
- (UIButton *)setupButton:(NSString *)title tag:(MyEmotionType)tag
{
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    
    // 文字
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    
    // 添加按钮
    [self addSubview:button];
    
    // 设置背景图片
    int count = self.subviews.count;
    if (count == 1) { // 第一个按钮
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_left_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_left_selected"] forState:UIControlStateSelected];
    } else if (count == MyEmotionToolbarButtonMaxCount) { // 最后一个按钮
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_right_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_right_selected"] forState:UIControlStateSelected];
    } else { // 中间按钮
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_mid_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_mid_selected"] forState:UIControlStateSelected];
    }
    
    return button;
}

/**
 *  监听按钮点击
 */
- (void)buttonClick:(UIButton *)button
{
    // 1.控制按钮状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    // 2.通知代理
    if ([self.delegate respondsToSelector:@selector(emotionToolbar:didSelectedButton:)]) {
        [self.delegate emotionToolbar:self didSelectedButton:button.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置工具条按钮的frame
    CGFloat buttonW = self.frame.size.width / MyEmotionToolbarButtonMaxCount;
    CGFloat buttonH = self.frame.size.height;
    for (int i = 0; i<MyEmotionToolbarButtonMaxCount; i++) {
        UIButton *button = self.subviews[i];
        CGFloat width = buttonW;
        CGFloat height = buttonH;
        CGFloat x = i * buttonW;
        
        button.frame = CGRectMake(x, 0, width, height);
    }
}

@end
