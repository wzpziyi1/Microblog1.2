//
//  MyStatus.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/3/29.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyStatus.h"
#import "MJExtension.h"
#import "MyPhoto.h"
#import "NSDate+NSDate_Extension.h"
#import "RegexKitLite.h"
#import "MyEmotion.h"
#import "MyEmotionTool.h"
#import "MyRegexResult.h"
#import "MyEmotionAttachment.h"
#import "MyCellCommonData.h"

#define MyColor(a,b,c) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1]
// 转发微博正文字体
#define MyStatusHighTextColor MyColor(88, 161, 253)



@implementation MyStatus
+ (NSMutableDictionary *)objectClassInArray
{
    return @{@"pic_urls":[MyPhoto class]};
    
}

- (NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    NSLocale* local =[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ;
    [fmt setLocale:local];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    
//    Mon May 18 22:11:56 +0800 2015    _created_at
    
    NSDate *createDate = [fmt dateFromString:_created_at];
    
//    NSLog(@"*****%@-----%@",createDate,_created_at);
    //NSLog：*****2015-05-18 16:12:21 +0000-----Tue May 19 00:12:21 +0800 2015
    //Why?Thanks.
    
    // 判断是否为今年
    if (createDate.isThisYear) {
        if (createDate.isToday) { // 今天
            NSDateComponents *cmps = [createDate deltaWithNow];
            if (cmps.hour >= 1) { // 至少是1小时前发的
                return [NSString stringWithFormat:@"%d小时前", (int)cmps.hour];
            } else if (cmps.minute >= 1) { // 1~59分钟之前发的
                return [NSString stringWithFormat:@"%d分钟前", (int)cmps.minute];
            } else { // 1分钟内发的
                return @"刚刚";
            }
        } else if (createDate.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else { // 至少是前天
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt stringFromDate:createDate];
    }
}

- (void)setSource:(NSString *)source
{
    // 截取范围
    NSRange range;
    range.location = [source rangeOfString:@">"].location + 1;
    range.length = [source rangeOfString:@"</"].location - range.location;
    // 开始截取
    NSString *subsource = [source substringWithRange:range];
    
    _source = [NSString stringWithFormat:@"来自%@", subsource];
}

- (NSArray *)regexResultsWithText:(NSString *)text
{
    NSMutableArray *attributeArray = [NSMutableArray array];
    
    // 匹配表情
    NSString *emotionRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    
    [text enumerateStringsMatchedByRegex:emotionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        MyRegexResult *result = [[MyRegexResult alloc] init];
        result.string = *capturedStrings;
        result.range = *capturedRanges;
        result.emotion = YES;
        [attributeArray addObject:result];
    }];
    
    // 匹配非表情
    [text enumerateStringsSeparatedByRegex:emotionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        MyRegexResult *rr = [[MyRegexResult alloc] init];
        rr.string = *capturedStrings;
        rr.range = *capturedRanges;
        rr.emotion = NO;
        [attributeArray addObject:rr];
    }];
    
    [attributeArray sortUsingComparator:^NSComparisonResult(MyRegexResult *obj1, MyRegexResult *obj2) {
        int loc1 = obj1.range.location;
        int loc2 = obj2.range.location;
        if (loc1 < loc2) {
            return NSOrderedAscending; // 升序（右边越来越大）
        } else if (loc1 > loc2) {
            return NSOrderedDescending; // 降序（右边越来越小）
        } else {
            return NSOrderedSame;
        }
    }];
    
    return attributeArray;
}

- (void)setText:(NSString *)text
{
    _text = text;
    NSArray *regexResults = [self regexResultsWithText:text];
    
    // 根据匹配结果，拼接对应的图片表情和普通文本
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    // 遍历
    [regexResults enumerateObjectsUsingBlock:^(MyRegexResult *result, NSUInteger idx, BOOL *stop) {
        if (result.isEmotion) { // 表情
            // 创建附件对象
            MyEmotionAttachment *attach = [[MyEmotionAttachment alloc] init];
            
            // 传递表情
            attach.emotion = [MyEmotionTool emotionWithDesc:result.string];
            attach.bounds = CGRectMake(0, -3, MyStatusOrginalTextFont.lineHeight, MyStatusOrginalTextFont.lineHeight);
            
            // 将附件包装成富文本
            NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
            [attributedText appendAttributedString:attachString];
        } else { // 非表情（直接拼接普通文本）
            NSMutableAttributedString *substr = [[NSMutableAttributedString alloc] initWithString:result.string];
            
            // 匹配#话题#
            NSString *trendRegex = @"#[a-zA-Z0-9\\u4e00-\\u9fa5]+#";
            [result.string enumerateStringsMatchedByRegex:trendRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [substr addAttribute:NSForegroundColorAttributeName value:MyStatusHighTextColor range:*capturedRanges];
            }];
            
            // 匹配@提到
            NSString *mentionRegex = @"@[a-zA-Z0-9\\u4e00-\\u9fa5\\-]+ ?";
            [result.string enumerateStringsMatchedByRegex:mentionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [substr addAttribute:NSForegroundColorAttributeName value:MyStatusHighTextColor range:*capturedRanges];
            }];
            
            // 匹配超链接
            NSString *httpRegex = @"http(s)?://([a-zA-Z|\\d]+\\.)+[a-zA-Z|\\d]+(/[a-zA-Z|\\d|\\-|\\+|_./?%&=]*)?";
            [result.string enumerateStringsMatchedByRegex:httpRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [substr addAttribute:NSForegroundColorAttributeName value:MyStatusHighTextColor range:*capturedRanges];
            }];
            
            [attributedText appendAttributedString:substr];
        }
    }];
    
    // 设置字体
    [attributedText addAttribute:NSFontAttributeName value:MyStatusRichTextFont range:NSMakeRange(0, attributedText.length)];
    
    self.attribute = attributedText;
}

@end
