//
//  MyStatusToolbar.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/4/27.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyStatusToolbar.h"
#import "UIImage+Extension.h"
#import "MyStatus.h"
@interface MyStatusToolbar()
@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, strong) NSMutableArray *dividers;
@property (nonatomic, weak) UIButton *repostsBtn;
@property (nonatomic, weak) UIButton *commentsBtn;
@property (nonatomic, weak) UIButton *attitudesBtn;
@end

@implementation MyStatusToolbar
- (NSMutableArray *)btns
{
    if (_btns == nil) {
        self.btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)dividers
{
    if (_dividers == nil) {
        self.dividers = [NSMutableArray array];
    }
    return _dividers;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizedImage:@"timeline_card_bottom_background"];
        
        self.repostsBtn = [self setupBtnWithIcon:@"timeline_icon_retweet" title:@"转发"];
        self.commentsBtn = [self setupBtnWithIcon:@"timeline_icon_comment" title:@"评论"];
        self.attitudesBtn =[self setupBtnWithIcon:@"timeline_icon_unlike" title:@"赞"];
        
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}

/**
 *  分割线
 */
- (void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageWithName:@"timeline_card_bottom_line"];
    divider.contentMode = UIViewContentModeCenter;
    [self addSubview:divider];
    
    [self.dividers addObject:divider];
}

/**
 *  添加按钮
 *
 *  @param icon  图标
 *  @param title 标题
 */
- (UIButton *)setupBtnWithIcon:(NSString *)icon title:(NSString *)title
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    // 设置高亮时的背景
    [btn setBackgroundImage:[UIImage resizedImage:@"common_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    btn.adjustsImageWhenHighlighted = NO;
    
    // 设置间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    [self addSubview:btn];
    
    [self.btns addObject:btn];
    
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置按钮的frame
    int btnCount = self.btns.count;
    CGFloat btnW = self.frame.size.width / btnCount;
    CGFloat btnH = self.frame.size.height;
    for (int i = 0; i<btnCount; i++) {
        UIButton *btn = self.btns[i];
        
        btn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
    }
    
    // 设置分割线的frame
    int dividerCount = self.dividers.count;
    for (int i = 0; i<dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        
        divider.frame = CGRectMake(0, 0, 4, btnH);
        divider.center = CGPointMake((i + 1) * btnW, btnH * 0.5);
    }
}

- (void)setStatus:(MyStatus *)status
{
    _status = status;
    //
    //    status.reposts_count = 10223000;
    //    status.comments_count = 11980000;
    //    status.attitudes_count = 1995698;
    
    [self setupBtnTitle:self.repostsBtn count:status.reposts_count defaultTitle:@"转发"];
    [self setupBtnTitle:self.commentsBtn count:status.comments_count defaultTitle:@"评论"];
    [self setupBtnTitle:self.attitudesBtn count:status.attitudes_count defaultTitle:@"赞"];
}

/**
 *  设置按钮的文字
 *
 *  @param button       需要设置文字的按钮
 *  @param count        按钮显示的数字
 *  @param defaultTitle 数字为0时显示的默认文字
 */
- (void)setupBtnTitle:(UIButton *)button count:(int)count defaultTitle:(NSString *)defaultTitle
{
    /**
     小于1W ： 具体数字，比如9800，就显示9800
     大于等于1W：xx.x万，比如78985，就显示7.9万
     整W：xx万，比如800365，就显示80万
     */
    
    if (count >= 10000) {
        defaultTitle = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
        defaultTitle = [defaultTitle stringByReplacingOccurrencesOfString:@".0" withString:@""];
    } else if (count > 0) {
        defaultTitle = [NSString stringWithFormat:@"%d", count];
    }
    [button setTitle:defaultTitle forState:UIControlStateNormal];
}


@end

