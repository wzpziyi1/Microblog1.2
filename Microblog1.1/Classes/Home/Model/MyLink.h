//
//  MyLink.h
//  Microblog1.1
//
//  Created by 王志盼 on 15/6/12.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyLink : UIView
/** 链接文字 */
@property (nonatomic, copy) NSString *text;
/** 链接的范围 */
@property (nonatomic, assign) NSRange range;
/** 链接的边框 (由于存在换行问题，可能会有多个边框)*/
@property (nonatomic, strong) NSArray *rects;
@end
