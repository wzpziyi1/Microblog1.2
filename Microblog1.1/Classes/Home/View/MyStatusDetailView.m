//
//  MyStatusDetailView.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/4/27.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyStatusDetailView.h"
#import "MyStatusRetweetedView.h"
#import "MyStatusOriginalView.h"
#import "MyStatusDetailFrame.h"
#import "UIImage+Extension.h"

@interface MyStatusDetailView()
@property (nonatomic, weak) MyStatusOriginalView *originalView;
@property (nonatomic, weak) MyStatusRetweetedView *retweetedView;
@end

@implementation MyStatusDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) { // 初始化子控件
        self.image = [UIImage resizedImage:@"timeline_card_top_background"];
        
        // 添加原创微博
        MyStatusOriginalView *originalView = [[MyStatusOriginalView alloc] init];
        [self addSubview:originalView];
        self.originalView = originalView;
        
        // 添加转发微博
        MyStatusRetweetedView *retweetedView = [[MyStatusRetweetedView alloc] init];
        [self addSubview:retweetedView];
        self.retweetedView = retweetedView;
        
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setDetailFrame:(MyStatusDetailFrame *)detailFrame
{
    _detailFrame = detailFrame;
    
    self.frame = detailFrame.frame;
    
    self.originalView.originalFrame = detailFrame.originalFrame;
    
    self.retweetedView.retweetedFrame = detailFrame.retweetedFrame;
}

@end
