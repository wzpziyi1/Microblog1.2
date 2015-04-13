//
//  MyShowPhotoView.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/4/13.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#define imageCount 4

#import "MyShowPhotoView.h"

@implementation MyShowPhotoView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)addImage:(UIImage *)image
{
    UIImageView *photo = [[UIImageView alloc] init];
    photo.image = image;
    
    photo.contentMode = UIViewContentModeScaleAspectFill; //全部显示，多余的剪掉
    photo.clipsToBounds = YES;
    
    [self addSubview:photo];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat distant = 10;
    
    CGFloat width = (self.frame.size.width - (imageCount + 1) * distant ) / imageCount;
    
    CGFloat height = width;
    
    for (int i = 0; i < self.subviews.count; i++) {
        int row = i / imageCount;
        int col = i % imageCount;
        
        UIImageView *imageView = self.subviews[i];
        
        CGFloat imageViewX = col * width + (col + 1) * distant;
        CGFloat imageViewY = row * (height + distant);
        CGFloat imageViewW = width;
        CGFloat imageViewH = height;
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    }
}
- (NSArray *)imageArray
{
    NSMutableArray *imageArray = [NSMutableArray array];
    
    for (UIImageView *tempImage in self.subviews) {
        [imageArray addObject:tempImage.image];
    }
    _imageArray = imageArray;
    return _imageArray;
}
@end
