//
//  MyPopMenu.h
//  Microblog1.1
//
//  Created by 王志盼 on 15/3/22.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    MyPopMenuArrowPositionCenter = 0,
    MyPopMenuArrowPositionLeft = 1,
    MyPopMenuArrowPositionRight = 2
}MyPopMenuArrowPosition;


@class MyPopMenu;

@protocol MyPopMenuDelegate <NSObject>

@optional
- (void)popMenuDidDismissed:(MyPopMenu *)popMenu;

@end

@interface MyPopMenu : UIView

@property (nonatomic, weak)id <MyPopMenuDelegate>delegate;

/**
 *  设置箭头位置
 */
@property (nonatomic, assign) MyPopMenuArrowPosition arrowPosition;
/**
 *  这个属性用来设置弹出的view是否显示黑色阴影
 */
@property (nonatomic, assign) BOOL blackBackground;

- (void)didmiss;
/**
 *  设置container的尺寸
 *
 */
- (void)showInRect:(CGRect)rect;
/**
 *  设置背景颜色
 *
 */
- (void)setBackground:(UIImage *)background;

+ (instancetype)popMenuWithContentView:(UIView *)contentView;

- (instancetype)initWithContentView:(UIView *)contentView;


@end
