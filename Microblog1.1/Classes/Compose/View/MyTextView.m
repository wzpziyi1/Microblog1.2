//
//  MyTextView.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/4/5.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyTextView.h"

@interface MyTextView ()
@property (nonatomic, weak)UITextField *textField;
@end

@implementation MyTextView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super init]) {
        UITextField *textField = [[UITextField alloc] init];
        textField.placeholder = @"分享新鲜事...";
        [self addSubview:textField];
        self.textField = textField;
    }
    return self;
}

- (void)layoutSubviews
{
    
}

@end
