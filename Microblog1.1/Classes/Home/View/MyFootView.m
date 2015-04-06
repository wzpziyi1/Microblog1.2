//
//  MyFootView.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/4/6.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyFootView.h"

@interface MyFootView ()
@property (weak, nonatomic) IBOutlet UILabel *loadMoreBnt;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *gray;
@end

@implementation MyFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"MyFootView" owner:nil options:nil] lastObject];
    }
    return self;
}

+ (instancetype)footView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"MyFootView" owner:nil options:nil] lastObject];
}
- (void)beginLoad
{
    self.loadMoreBnt.text = @"正在加载更多数据...";
    [self.gray startAnimating];
    self.refreshing = YES;
}
- (void)endLoad
{
    self.loadMoreBnt.text = @"上拉可以加载更多数据";
    [self.gray stopAnimating];
    self.refreshing = NO;
}
@end
