//
//  MyEmotionPopView.h
//  Microblog1.1
//
//  Created by 王志盼 on 15/6/1.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyEmotionView;

@interface MyEmotionPopView : UIView
+ (instancetype)popView;

/**
 *  显示表情弹出控件
 *
 *  @param emotionView 从哪个表情上面弹出
 */
- (void)showFromEmotionView:(MyEmotionView *)fromEmotionView;
- (void)dismiss;
@end
