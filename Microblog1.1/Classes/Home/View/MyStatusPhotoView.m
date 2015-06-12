//
//  MyStatusPhotoView.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/5/19.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyStatusPhotoView.h"
#import "MyPhoto.h"
#import "UIImageView+WebCache.h"

#import "UIImage+Extension.h"

@interface MyStatusPhotoView()
@property (nonatomic, weak) UIImageView *gifView;
@end

@implementation MyStatusPhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        
        // 添加一个gif图标
        UIImage *image = [UIImage imageWithName:@"timeline_image_gif"];
        
        // 这种情况下创建的UIImageView的尺寸跟图片尺寸一样
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return self;
}

- (void)setPhoto:(MyPhoto *)photo
{
    _photo = photo;
    
    //下载图片
    [self setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
    
    //控制gif图标的显示
    NSString *extension = photo.thumbnail_pic.pathExtension.lowercaseString;
    self.gifView.hidden = ![extension isEqualToString:@"gif"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat x = self.frame.size.width - self.gifView.frame.size.width;
    CGFloat y = self.frame.size.height - self.gifView.frame.size.height;
    self.gifView.frame = CGRectMake(x, y, self.gifView.frame.size.width, self.gifView.frame.size.height);
}

@end
