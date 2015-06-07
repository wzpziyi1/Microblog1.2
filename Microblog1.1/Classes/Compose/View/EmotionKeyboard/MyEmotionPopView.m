//
//  MyEmotionPopView.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/6/1.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyEmotionPopView.h"
#import "MyEmotionView.h"

@interface MyEmotionPopView ()
@property (weak, nonatomic) IBOutlet MyEmotionView *emotionView;
@end

@implementation MyEmotionPopView
+ (instancetype)popView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"MyEmotionPopView" owner:nil options:nil] lastObject];
}

- (void)showFromEmotionView:(MyEmotionView *)fromEmotionView
{
    if (fromEmotionView == nil) {
        return;
    }
    
    self.emotionView.emotion = fromEmotionView.emotion;
//    NSLog(@"fromEmotionView.frame---%@",NSStringFromCGRect(fromEmotionView.frame));
//    NSLog(@"self.frame---%@",NSStringFromCGRect(self.frame));
    
    // 添加到窗口上
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
//    NSLog(@"window.frame---%@",NSStringFromCGRect(window.frame));
    CGFloat centerX = fromEmotionView.center.x;
    CGFloat centerY = fromEmotionView.center.y - self.frame.size.height * 0.5;
    CGPoint center = CGPointMake(centerX, centerY);
    // 将指标转换到window上
    self.center = [window convertPoint:center fromView:fromEmotionView.superview];
}

- (void)dismiss
{
    [self removeFromSuperview];
}

/**
 *  当一个控件显示之前会调用一次（如果控件在显示之前没有尺寸，不会调用这个方法）
 *
 *  @param rect 控件的bounds
 */
- (void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"emoticon_keyboard_magnifier"] drawInRect:rect];
}

@end
