//
//  MyEmotionTextView.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/6/6.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyEmotionTextView.h"
#import "MyEmotion.h"
#import "MyEmotionAttachment.h"

@implementation MyEmotionTextView

- (void)appendEmotion:(MyEmotion *)emotion
{
    if (emotion.emoji) {
        [self insertText:emotion.emoji];
    }else
    {
        NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        
        // 创建一个带有图片表情的富文本
        MyEmotionAttachment *attachment = [[MyEmotionAttachment alloc] init];
        
        attachment.emotion = emotion;
        //设置偏差（-3）
        attachment.bounds = CGRectMake(0, -3, self.font.lineHeight, self.font.lineHeight);
        NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attachment];
        
        // 记录表情的插入位置
        int index = self.selectedRange.location;
        
        // 插入表情图片到光标位置
        [attribute insertAttributedString:attachString atIndex:index];
        
        // 设置字体
        [attribute addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attribute.length)];
        
        // 重新赋值(光标会自动回到文字的最后面)
        self.attributedText = attribute;
        
        // 让光标回到表情后面的位置
        self.selectedRange = NSMakeRange(index + 1, 0);
    }
}

- (NSString *)realText
{
    // 用来拼接所有文字
    NSMutableString *string = [NSMutableString string];
    
    // 遍历富文本里面的所有内容
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        MyEmotionAttachment *attach = attrs[@"NSAttachment"];
        if (attach) { // 如果是带有附件的富文本
            [string appendString:attach.emotion.chs];
        } else { // 普通的文本
            // 截取range范围的普通文本
            NSString *substr = [self.attributedText attributedSubstringFromRange:range].string;
            [string appendString:substr];
        }
    }];
    
    return string;
}

@end
