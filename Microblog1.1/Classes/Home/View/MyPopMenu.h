//
//  MyPopMenu.h
//  Microblog1.1
//
//  Created by 王志盼 on 15/3/22.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MyPopMenu;

@protocol MyPopMenuDelegate <NSObject>

@optional
- (void)popMenuDidDismissed:(MyPopMenu *)popMenu;

@end

@interface MyPopMenu : UIView

@property (nonatomic, weak)id <MyPopMenuDelegate>delegate;
- (void)showInRect:(CGRect)rect;

- (void)setBackground:(UIImage *)background;

+ (instancetype)popMenuWithContentView:(UIView *)contentView;

- (instancetype)initWithContentView:(UIView *)contentView;


@end
