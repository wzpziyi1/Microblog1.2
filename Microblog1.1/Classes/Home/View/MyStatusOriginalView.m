//
//  MyStatusOriginalView.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/4/27.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyStatusOriginalView.h"
#import "MyStatusOriginalFrame.h"
#import "MyStatus.h"
#import "MyUser.h"
#import "UIImageView+WebCache.h"
#import "MyCellCommonData.h"
#import "UIImage+Extension.h"

@interface MyStatusOriginalView()
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 正文 */
@property (nonatomic, weak) UILabel *textLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;

/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
@end

@implementation MyStatusOriginalView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = MyStatusOrginalNameFont;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 正文（内容）
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.font = MyStatusOrginalTextFont;
        textLabel.numberOfLines = 0;
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        
        // 时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textColor = [UIColor orangeColor];
        timeLabel.font = MyStatusOrginalTimeFont;
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        // 来源
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.textColor = [UIColor lightGrayColor];
        sourceLabel.font = MyStatusOrginalSourceFont;
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        // 头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        // 会员图标
        UIImageView *vipView = [[UIImageView alloc] init];
        vipView.contentMode = UIViewContentModeCenter;
        [self addSubview:vipView];
        self.vipView = vipView;
    }
    return self;
}

- (void)setOriginalFrame:(MyStatusOriginalFrame *)originalFrame
{
    _originalFrame = originalFrame;
    
    self.frame = originalFrame.frame;
    
    // 取出微博数据
    MyStatus *status = originalFrame.status;
    // 取出用户数据
    MyUser *user = status.user;
    
    // 昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = originalFrame.nameFrame;
    if (user.isVip) { // 会员
        self.nameLabel.textColor = [UIColor orangeColor];
        self.vipView.hidden = NO;
        self.vipView.frame = originalFrame.vipFrame;
        self.vipView.image = [UIImage imageWithName:[NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank]];
    } else {
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    // 正文（内容）
    self.textLabel.text = status.text;
    self.textLabel.frame = originalFrame.textFrame;
    
    // 时间
    self.timeLabel.text = status.created_at;
    self.timeLabel.frame = originalFrame.timeFrame;
    
    // 来源
    self.sourceLabel.text = status.source;
    self.sourceLabel.frame = originalFrame.sourceFrame;
    
    // 头像
    self.iconView.frame = originalFrame.iconFrame;
    [self.iconView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
}

@end
