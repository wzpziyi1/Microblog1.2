//
//  MyEmotion.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/5/20.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyEmotion.h"
#import "NSString+Emoji.h"
@implementation MyEmotion


- (void)setCode:(NSString *)code
{
    _code = [code copy];
    
    if (code == nil) {
        return;
    }
    
    self.emoji = [NSString emojiWithStringCode:code];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.chs = [aDecoder decodeObjectForKey:@"chs"];
        self.png = [aDecoder decodeObjectForKey:@"png"];
        self.code = [aDecoder decodeObjectForKey:@"code"];
        self.directory = [aDecoder decodeObjectForKey:@"directory"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.chs forKey:@"chs"];
    [encoder encodeObject:self.png forKey:@"png"];
    [encoder encodeObject:self.code forKey:@"code"];
    [encoder encodeObject:self.directory forKey:@"directory"];
}

- (BOOL)isEqual:(MyEmotion *)emotion
{
    if (self.code) { // emoji表情
        return [self.code isEqualToString:emotion.code];
    } else { // 图片表情
        return [self.png isEqualToString:emotion.png] && [self.chs isEqualToString:emotion.chs];
    }
}
@end
