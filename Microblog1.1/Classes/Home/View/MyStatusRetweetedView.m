//
//  MyStatusRetweetedView.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/4/27.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyStatusRetweetedView.h"
#import "MyStatusRetweetedFrame.h"
#import "MyStatus.h"
#import "MyUser.h"
#import "UIImage+Extension.h"
#import "MyCellCommonData.h"

@interface MyStatusRetweetedView()
/**  昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 正文 */
@property (nonatomic, weak) UILabel *textLabel;
@end

@implementation MyStatusRetweetedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage resizedImage:@"timeline_retweet_background"];
        
        // 1.昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = [UIColor colorWithRed:74 / 255.0 green:102 / 255.0 blue:105 / 255.0 alpha:1.0];
        
        nameLabel.font = MyStatusRetweetedNameFont;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 2.正文（内容）
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.font = MyStatusRetweetedTextFont;
        textLabel.numberOfLines = 0;
        [self addSubview:textLabel];
        self.textLabel = textLabel;
    }
    return self;
}

- (void)setRetweetedFrame:(MyStatusRetweetedFrame *)retweetedFrame
{
    _retweetedFrame = retweetedFrame;
    
    self.frame = retweetedFrame.frame;
    
    // 取出微博数据
    MyStatus *retweetedStatus = retweetedFrame.retweetedStatus;
    // 取出用户数据
    MyUser *user = retweetedStatus.user;
    
    // 1.昵称
    self.nameLabel.text = [NSString stringWithFormat:@"@%@", user.name];
    self.nameLabel.frame = retweetedFrame.nameFrame;
    
    // 2.正文（内容）
    self.textLabel.text = retweetedStatus.text;
    self.textLabel.frame = retweetedFrame.textFrame;
}


@end
