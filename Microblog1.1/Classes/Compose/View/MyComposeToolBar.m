//
//  MyComposeToolBar.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/4/7.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyComposeToolBar.h"
#import "UIImage+Extension.h"


@interface MyComposeToolBar ()
@property (nonatomic, weak) UIButton *emotionButton;
@end

@implementation MyComposeToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加所有的子控件
//        [UIImage imageNamed:@"compose_mentionbutton_background"]
//
        [self addButtonWithIcon:@"compose_camerabutton_background" highIcon:@"compose_camerabutton_background_highlighted" tag:MyComposeToolBarButtonCamera];
        
        [self addButtonWithIcon:@"compose_toolbar_picture" highIcon:@"compose_toolbar_picture_highlighted" tag:MyComposeToolBarButtonPicture];
        
        [self addButtonWithIcon:@"compose_trendbutton_background" highIcon:@"compose_trendbutton_background_highlighted" tag:MyComposeToolBarButtonTrend];
        
        [self addButtonWithIcon:@"compose_mentionbutton_background" highIcon:@"compose_mentionbutton_background_highlighted" tag:MyComposeToolBarButtonMention];
        
        
        self.emotionButton = [self addButtonWithIcon:@"compose_emoticonbutton_background" highIcon:@"compose_emoticonbutton_background_highlighted" tag:MyComposeToolBarButtonEmotion];
        
    }
    return self;
}

- (UIButton *)addButtonWithIcon:(NSString *)icon highIcon:(NSString *)highIcon tag:(MyComposeToolBarButtonType)buttonType
{
    UIButton *bnt = [[UIButton alloc] init];
    bnt.tag = buttonType;
    [bnt setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [bnt setImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    
    [bnt addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:bnt];
    
    return bnt;
}

- (void)buttonDidClick:(UIButton *)bnt
{
    if ([self.delegate respondsToSelector:@selector(didClickButton:)]) {
        [self.delegate didClickButton:bnt];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width / self.subviews.count;
    
    CGFloat hight = self.frame.size.height;
    
    for (int i = 0; i < self.subviews.count; i++) {
        UIButton *bnt = self.subviews[i];
        
        bnt.frame = CGRectMake(i * width, 0, width, hight);
    }
}

- (void)setShowEmotionButton:(BOOL)showEmotionButton
{
    _showEmotionButton = showEmotionButton;
    
    if (_showEmotionButton) { // 显示表情按钮
        [self.emotionButton setImage:[UIImage imageWithName:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageWithName:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
    } else { // 切换为键盘按钮
        [self.emotionButton setImage:[UIImage imageWithName:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageWithName:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }
}
@end
