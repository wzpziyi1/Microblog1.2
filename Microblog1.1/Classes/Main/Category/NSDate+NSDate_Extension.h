//
//  NSDate+NSDate_Extension.h
//  Microblog1.1
//
//  Created by 王志盼 on 15/5/18.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (NSDate_Extension)
/***  是否为今天  **/
- (BOOL)isToday;

/***  是否为昨天  **/
- (BOOL)isYesterday;

/***  是否为今年  **/
- (BOOL)isThisYear;

/**  返回一个只有年月日的时间  */
- (NSDate *)dateWithYMD;

/**  获得与当前时间的差距  */
- (NSDateComponents *)deltaWithNow;
@end
