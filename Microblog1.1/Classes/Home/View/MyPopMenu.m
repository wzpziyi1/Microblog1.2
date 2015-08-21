//
//  MyPopMenu.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/3/22.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyPopMenu.h"
#import "UIImage+Extension.h"

@interface MyPopMenu ()

@property (nonatomic, weak) UIView *contentView;
/**需要一个透明的按钮覆盖整个界面，并监听点击*/
@property (nonatomic, weak) UIButton *cover;

/**容器，用来容纳具体的contentView*/
@property (nonatomic, weak) UIImageView *container;
@end

@implementation MyPopMenu

- (void)setBlackBackground:(BOOL)blackBackground
{
    _blackBackground = blackBackground;
    if (_blackBackground == YES) {
        [self.cover setBackgroundColor:[UIColor blackColor]];
        self.cover.alpha = 0.35;
    }
    else
    {
        [self.cover setBackgroundColor:[UIColor clearColor]];
        self.cover.alpha = 1.0;
    }
}

- (void)setArrowPosition:(MyPopMenuArrowPosition)arrowPosition
{
    _arrowPosition = arrowPosition;
    switch (_arrowPosition) {
        case MyPopMenuArrowPositionCenter:
            self.container.image = [UIImage resizedImage:@"popover_background"];
            break;
        case MyPopMenuArrowPositionLeft:
            self.container.image = [UIImage resizedImage:@"popover_background_left"];
            break;
        case MyPopMenuArrowPositionRight:
            self.container.image = [UIImage resizedImage:@"popover_background_right"];
            break;
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *cover = [[UIButton alloc] init];
        cover.backgroundColor = [UIColor clearColor];
        [cover addTarget:self action:@selector(didmiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cover];
        self.cover = cover;
        
        //用来加载带箭头的图片
        UIImageView *container = [[UIImageView alloc] init];
        container.image = [UIImage resizedImage:@"popover_background"];
        //在这里，这张图片必须响应用户的交互
        container.userInteractionEnabled = YES; //该属性值为布尔类型，如属性本身的名称所释，该属性决定UIView是否接受并响应用户的交互。当值设置为NO后，UIView会忽略那些原本应该发生在其自身的诸如touch和keyboard等用户事件，并将这些事件从消息队列中移除出去。当值设置为YES后，这些用户事件会正常的派发至UIView本身(前提事件确实发生在该view上)，UIView会按照之前注册的事件处理方法来响应这些事件。
        [self addSubview:container];
        self.container = container;
        
    }
    return self;
}

- (void)didmiss
{
    if ([self.delegate respondsToSelector:@selector(popMenuDidDismissed:)]) {
        [self.delegate popMenuDidDismissed:self];
    }
    [self removeFromSuperview];
}


- (void)layoutSubviews
{
    
    self.cover.frame = self.bounds;
}


- (instancetype)initWithContentView:(UIView *)contentView
{
    if (self = [super init]) {
        self.contentView = contentView;
    }
    return self;
}


+ (instancetype)popMenuWithContentView:(UIView *)contentView
{
    return [[self alloc] initWithContentView:contentView];
}


- (void)setBackground:(UIImage *)background
{
    self.container.image = background;
}

- (void)showInRect:(CGRect)rect
{
    
    UIWindow *window= [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
    
    self.container.frame = rect;
    [self.container addSubview:self.contentView];  //为什么在这个时候才添加contentView呢？因为在其他地方添加，是不知contentView是否为空
    
    // 设置容器里面内容的frame
    CGFloat topDistance = 12;
    CGFloat leftDistance = 5;
    CGFloat rightDistance = 5;
    CGFloat bottomDistance = 8;
    
    self.contentView.frame = CGRectMake(leftDistance, topDistance, self.container.frame.size.width - leftDistance - rightDistance, self.container.frame.size.height - topDistance - bottomDistance);
}
@end
