//
//  MySearchBar.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/3/22.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MySearchBar.h"
#import "UIImage+Extension.h"

@implementation MySearchBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackground:[UIImage resizedImage:@"searchbar_textfield_background"]];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(0, 0, 35, 35);
        imageView.image = [UIImage imageWithName:@"searchbar_textfield_search_icon"];
        imageView.contentMode = UIViewContentModeCenter;
        self.leftView = imageView;      //UITextField 中不仅有leftView，还有rightView，但是默认情况下，他们都是从不显示的，所以需要修改其中属性，使得他们总是显示
        self.leftViewMode = UITextFieldViewModeAlways;   //设置leftView总是显示
        self.clearButtonMode = UITextFieldViewModeAlways; //设置清楚按钮显示
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//设置内容垂直居中，以免造成内容垂直方向偏上
    }
    return self;
}

+ (instancetype)searchBarWithRect:(CGRect)rect
{
    return [[self alloc] initWithFrame:rect];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}
@end
