//
//  MyTitleButton.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/3/22.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyTitleButton.h"

@implementation MyTitleButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {                                 //一些控件属性，是一样的，所以最好在初始化设置一次就好，若需要特殊要求，那么覆盖掉已经设置好的属性即可
        
        self.imageView.contentMode = UIViewContentModeCenter;  //图片按照原样居中显示
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //self.titleLabel.font = [UIFont systemFontOfSize:20.0];
        //图片高亮时不需要灰色显示
        self.adjustsImageWhenHighlighted = NO;
//        NSLog(@"%@",self.titleLabel)
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        
        
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect  //重写此方法，调整图片位置
{
    CGFloat imageH = self.frame.size.height;
    CGFloat imageW = imageH;
    CGFloat imageX = self.frame.size.width - imageW;
    CGFloat imageY = 0;
    return CGRectMake(imageX, imageY, imageW, imageH);
    
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect  //重写此方法，调整文字显示位置
{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = self.frame.size.width - self.frame.size.height;
    CGFloat titleH = self.frame.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end
