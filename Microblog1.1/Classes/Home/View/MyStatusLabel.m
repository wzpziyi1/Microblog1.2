//
//  MyStatusLabel.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/6/12.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyStatusLabel.h"
#import "MyCellCommonData.h"
#import "MyLink.h"

#define MyLinkBackgroundTag 300000


@interface MyStatusLabel ()
@property (nonatomic, strong) NSMutableArray *links;
@property (nonatomic, weak) UITextView *textView;
@end


@implementation MyStatusLabel

- (NSMutableArray *)links
{
    if (_links == nil) {
        _links = [NSMutableArray array];
       [ _attribute enumerateAttributesInRange:NSMakeRange(0, _attribute.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
           NSString *linkStr = attrs[MyLinkText];
           if (linkStr == nil) {
               return;
           }
           
           MyLink *link = [[MyLink alloc] init];
           link.text = linkStr;
           link.range = range;
           
           // 处理矩形框
           NSMutableArray *rects = [NSMutableArray array];
           // 设置选中的字符范围
           self.textView.selectedRange = range;
           // 算出选中的字符范围的边框
           NSArray *selectionRects = [self.textView selectionRectsForRange:self.textView.selectedTextRange];
           for (UITextSelectionRect *selectionRect in selectionRects) {
               if (selectionRect.rect.size.width == 0 || selectionRect.rect.size.height == 0) continue;
               [rects addObject:selectionRect];
           }
           link.rects = rects;
           
           [_links addObject:link];
       }];
    }
    return _links;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        UITextView *textView = [[UITextView alloc] init];
        // 不能编辑
        textView.editable = NO;
        // 不能滚动
        textView.scrollEnabled = NO;
        // 设置TextView不能跟用户交互
        textView.userInteractionEnabled = NO;
        
        textView.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5); //设置内边距，微调文字范围
        textView.backgroundColor = [UIColor clearColor];
        [self addSubview:textView];
        self.textView = textView;
    }
    return self;
}

- (void)setAttribute:(NSAttributedString *)attribute
{
    _attribute = attribute;
    
    self.textView.attributedText = attribute;
    
    self.links = nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textView.frame = self.bounds;
}
#pragma mark - 事件处理
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    
    // 得出被点击的那个链接
    MyLink *touchingLink = [self touchingLinkWithPoint:point];
    
    // 设置链接选中的背景
    [self showLinkBackground:touchingLink];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    
    // 得出被点击的那个链接
    MyLink *touchingLink = [self touchingLinkWithPoint:point];
    if (touchingLink) {
        // 说明手指在某个链接上面抬起来, 发出通知
        [[NSNotificationCenter defaultCenter] postNotificationName:MyLinkDidSelectedNotification object:nil userInfo:@{MyLinkText : touchingLink.text}];
    }
    
    // 相当于触摸被取消
    [self touchesCancelled:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeAllLinkBackground];
    });
}

#pragma mark - 链接背景处理
/**
 *  根据触摸点找出被触摸的链接
 *
 *  @param point 触摸点
 */
- (MyLink *)touchingLinkWithPoint:(CGPoint)point
{
    __block MyLink *touchingLink = nil;
    [self.links enumerateObjectsUsingBlock:^(MyLink *link, NSUInteger idx, BOOL *stop) {
        for (UITextSelectionRect *selectionRect in link.rects) {
            if (CGRectContainsPoint(selectionRect.rect, point)) {
                touchingLink = link;
                break;
            }
        }
    }];
    return touchingLink;
}

/**
 *  显示链接的背景
 *
 *  @param link 需要显示背景的link
 */
- (void)showLinkBackground:(MyLink *)link
{
    for (UITextSelectionRect *selectionRect in link.rects) {
        UIView *bg = [[UIView alloc] init];
        bg.tag = MyLinkBackgroundTag;
        bg.layer.cornerRadius = 3;
        bg.frame = selectionRect.rect;
        bg.backgroundColor = [UIColor redColor];
        [self insertSubview:bg atIndex:0];
    }
}

- (void)removeAllLinkBackground
{
    for (UIView *child in self.subviews) {
        if (child.tag == MyLinkBackgroundTag) {
            [child removeFromSuperview];
        }
    }
}
@end
