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

#import "MyStatusPhotosView.h"

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

/** 配图相册 */
@property (nonatomic, weak) MyStatusPhotosView *photosView;
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
        
        // 配图相册
        MyStatusPhotosView *photosView = [[MyStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
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
//    self.textLabel.text = status.text;
    self.textLabel.attributedText = status.attribute;
    self.textLabel.frame = originalFrame.textFrame;
    
#warning 需要时刻根据现在的时间字符串来计算时间label的frame
    // 时间
    NSString *time = status.created_at;
   // NSLog(@"-------%@----%@",time,status.created_at);
    self.timeLabel.text = time; // 刚刚 --> 1分钟前 --> 10分钟前
    CGFloat timeX = CGRectGetMinX(self.nameLabel.frame);
    CGFloat timeY = CGRectGetMaxY(self.nameLabel.frame) + MyStatusCellInset * 0.5;
    CGSize timeSize = [time sizeWithFont:MyStatusOrginalTimeFont];
    self.timeLabel.frame = (CGRect){{timeX, timeY}, timeSize};
    
    // 来源
    self.sourceLabel.text = status.source;
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + MyStatusCellInset;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:MyStatusOrginalSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceX, sourceY}, sourceSize};
    
    // 头像
    self.iconView.frame = originalFrame.iconFrame;
    [self.iconView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    
    // 配图相册
    if (status.pic_urls.count) { // 有配图
        self.photosView.frame = originalFrame.photosFrame;
        self.photosView.pic_urls = status.pic_urls;
        self.photosView.hidden = NO;
    } else {
        self.photosView.hidden = YES;
    }
}



@end
