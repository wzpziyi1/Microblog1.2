//
//  MyEmotionListView.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/5/19.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//
// 表情的最大行数
#define MyEmotionMaxRows 3
// 表情的最大列数
#define MyEmotionMaxCols 7
// 每页最多显示多少个表情
#define MyEmotionMaxCountPerPage (MyEmotionMaxRows * MyEmotionMaxCols - 1)

// 颜色
#define MyColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define MyRandomColor MyColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#import "MyEmotionListView.h"
#import "MyEmotionGirdView.h"
#import "UIImage+Extension.h"

@interface MyEmotionListView () <UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation MyEmotionListView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        //图片样式不符合，无需自定义，直接kvc换掉
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        [pageControl setValue:[UIImage imageWithName:@"compose_keyboard_dot_normal"]  forKeyPath:@"_pageImage"];
        [pageControl setValue:[UIImage imageWithName:@"compose_keyboard_dot_selected"] forKeyPath:@"_currentPageImage"];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    self.pageControl.numberOfPages = (emotions.count - 1) / MyEmotionMaxCountPerPage + 1;
    
    //先从scrollView里面移除所有以前添加了的页码
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i = 0; i<self.pageControl.numberOfPages; i++) {
        UIView *gridView = [[UIView alloc] init];
        gridView.backgroundColor = MyRandomColor;
        [self.scrollView addSubview:gridView];
    }
//    self.scrollView.contentOffset = CGPointMake(0, 0);
    [self setNeedsLayout];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    

    CGFloat pageX = 0;
    CGFloat pageY = self.frame.size.height - self.pageControl.frame.size.height;
    CGFloat pageW = self.frame.size.width;
    CGFloat pageH = 35;
    self.pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);

    CGFloat scrollViewX = 0;
    CGFloat scrollViewY = 0;
    CGFloat scrollViewW = pageW;
    CGFloat scrollViewH = pageY;
    self.scrollView.frame = CGRectMake(scrollViewX, scrollViewY, scrollViewW, scrollViewH);
 
    
    // 设置UIScrollView内部控件的尺寸
    int count = self.pageControl.numberOfPages;
    CGFloat gridW = scrollViewW;
    CGFloat gridH = scrollViewH;
    self.scrollView.contentSize = CGSizeMake(count * gridW, 0);
    for (int i = 0; i<count; i++) {
        //这里需要注意，只要没有将scrollView的水平、垂直滚动条隐藏，那么就会包含这两个子控件
        UIView *gridView = self.scrollView.subviews[i];
        gridView.frame = CGRectMake(i * gridW, 0, gridW, gridH);
    }
}

#pragma mark-  UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = (int)(scrollView.contentOffset.x / self.frame.size.width + 0.5);
}
@end
