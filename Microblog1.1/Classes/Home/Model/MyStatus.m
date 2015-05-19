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

@end
