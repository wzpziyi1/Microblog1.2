//
//  MyTextView.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/4/5.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyTextView.h"

@interface MyTextView ()
@property (nonatomic, weak) UILabel *placeLabel;
@end

@implementation MyTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UILabel *placeLabel = [[UILabel alloc] init];
        placeLabel.text = @"分享新鲜事...";
        placeLabel.numberOfLines = 0;
        
        placeLabel.backgroundColor = [UIColor clearColor];
        placeLabel.textColor = [UIColor lightGrayColor];
        placeLabel.font = [UIFont systemFontOfSize:14];
        
        self.font = placeLabel.font;
        [self addSubview:placeLabel];
        self.placeLabel = placeLabel;
        
#warning 不要设置自己的代理为自己本身
        // 监听内部文字改变
        //        self.delegate = self;
        
        /**
         监听控件的事件：
         1.delegate
         2.- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
         3.通知
         */
        
        // 当用户通过键盘修改了self的文字，self就会自动发出一个UITextViewTextDidChangeNotification通知
        // 一旦发出上面的通知，就会调用self的textDidChange方法
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
        
    }
    return self;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange];  //当TextView文字用代码改变时，需要调用，因为通知、代理只能监听键盘、鼠标的事件
}

- (void )setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeLabel.font = font;
    
    [self setNeedsLayout];     //当TextView字体改变时，palceLabel应该对应改变，改变之后，需要调用layoutSubviews重新计算文字尺寸等
}

- (void)setPlaceText:(NSString *)placeText
{
    _placeText = [placeText copy];
    
    self.placeLabel.text = _placeText;
    
    [self setNeedsLayout];  //占位文字发生改变时，应该重新计算占位文字尺寸
}

- (void)setPlaceTextColor:(UIColor *)placeTextColor
{
    _placeTextColor = placeTextColor;
    
    self.placeLabel.textColor = placeTextColor;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    CGFloat placeLabelX = 0;
    CGFloat placeLabelY = 8;
    CGFloat placeLabelW = self.frame.size.width - 2 * placeLabelX;
    
    CGSize tempSize = CGSizeMake(placeLabelW, MAXFLOAT);
    CGSize placeSize = [self.placeLabel.text sizeWithFont:self.placeLabel.font constrainedToSize:tempSize];
    CGFloat placeLabelH = placeSize.height;
    self.placeLabel.frame = CGRectMake(placeLabelX, placeLabelY, placeLabelW, placeLabelH);
}

/**
 *  监听textView文本框情况
 */
- (void)textDidChange
{
    self.placeLabel.hidden = self.hasText;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
