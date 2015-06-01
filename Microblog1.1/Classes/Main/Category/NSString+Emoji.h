//
//  NSString+Emoji.h
//  Microblog1.1
//
//  Created by 王志盼 on 15/5/21.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//
//  需要对emoji进行编码，判断

#import <Foundation/Foundation.h>

@interface NSString (Emoji)
/**
 *  将十六进制的编码转为emoji字符
 */
+ (NSString *)emojiWithIntCode:(int)intCode;

/**
 *  将十六进制的编码转为emoji字符
 */
+ (NSString *)emojiWithStringCode:(NSString *)stringCode;

/**
 *  是否为emoji字符
 */
- (BOOL)isEmoji;
@end
