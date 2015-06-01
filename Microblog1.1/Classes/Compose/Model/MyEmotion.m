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
@end
