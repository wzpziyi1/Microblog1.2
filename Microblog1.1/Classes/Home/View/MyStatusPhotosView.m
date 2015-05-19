//
//  MyStatusPhotosView.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/5/19.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyStatusPhotosView.h"
#import "MyStatusPhotoView.h"
#import "UIImageView+WebCache.h"
#import "MyPhoto.h"

#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#define MyStatusPhotosMaxCount 9
#define MyStatusPhotosMaxCols(photosCount) ((photosCount==4)?2:3)
#define MyStatusPhotoW 70
#define MyStatusPhotoH MyStatusPhotoW
#define MyStatusPhotoMargin 10

@interface MyStatusPhotosView()
@end

@implementation MyStatusPhotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 预先创建9个图片控件
        for (int i = 0; i<MyStatusPhotosMaxCount; i++) {
            MyStatusPhotoView *photoView = [[MyStatusPhotoView alloc] init];
            photoView.userInteractionEnabled = YES;
            photoView.tag = i;
            [self addSubview:photoView];
            
            // 添加手势监听器（一个手势监听器只能监听对应的一个view）
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] init];
            [recognizer addTarget:self action:@selector(tapPhoto:)];
            [photoView addGestureRecognizer:recognizer];
            
//            self.userInteractionEnabled = YES;
        }
    }
    return self;
}

/**
 *  监听图片的点击
 */
- (void)tapPhoto:(UITapGestureRecognizer *)recognizer
{
//    NSLog(@"-----tapPhoto");
    // 创建图片浏览器
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    
    // 设置图片浏览器显示的所有图片
    NSMutableArray *photos = [NSMutableArray array];
    int count = self.pic_urls.count;
    for (int i = 0; i<count; i++) {
        MyPhoto *pic = self.pic_urls[i];
        
        MJPhoto *photo = [[MJPhoto alloc] init];
        // 设置图片的路径
        photo.url = [NSURL URLWithString:pic.bmiddle_pic];
        // 设置来源于哪一个UIImageView
        photo.srcImageView = self.subviews[i];
        [photos addObject:photo];
    }
    browser.photos = photos;
    
    // 3.设置默认显示的图片索引
    browser.currentPhotoIndex = recognizer.view.tag;
    
    // 3.显示浏览器
    [browser show];
}

- (void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    
    for (int i = 0; i<MyStatusPhotosMaxCount; i++) {
        MyStatusPhotoView *photoView = self.subviews[i];
        
        if (i < pic_urls.count) { // 显示图片
            photoView.photo = pic_urls[i];
            photoView.hidden = NO;
        } else { // 隐藏
            photoView.hidden = YES;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = self.pic_urls.count;
    int maxCols = MyStatusPhotosMaxCols(count);
    for (int i = 0; i<count; i++) {
        MyStatusPhotoView *photoView = self.subviews[i];
        
        
        CGFloat width = MyStatusPhotoW;
        CGFloat height = MyStatusPhotoH;
        CGFloat x = (i % maxCols) * (MyStatusPhotoW + MyStatusPhotoMargin);
        CGFloat y = (i / maxCols) * (MyStatusPhotoH + MyStatusPhotoMargin);
        
        photoView.frame = CGRectMake(x, y, width, height);
    }
}

+ (CGSize)sizeWithPhotosCount:(int)photosCount
{
    int maxCols = MyStatusPhotosMaxCols(photosCount);
    
    // 总列数
    int totalCols = photosCount >= maxCols ?  maxCols : photosCount;
    
    // 总行数
    int totalRows = (photosCount + maxCols - 1) / maxCols;
    
    // 计算尺寸
    CGFloat photosW = totalCols * MyStatusPhotoW + (totalCols - 1) * MyStatusPhotoMargin;
    CGFloat photosH = totalRows * MyStatusPhotoH + (totalRows - 1) * MyStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}
@end
