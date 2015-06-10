//
//  MyEmotion.h
//  Microblog1.1
//
//  Created by 王志盼 on 15/5/20.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyEmotion : UIView <NSCoding>
/** 表情的文字描述(简体中文) */
@property (nonatomic, copy) NSString *chs;

/** 表情的文字描述 (繁体中文)*/
@property (nonatomic, copy) NSString *cht;
/** 表情的文png图片名 */
@property (nonatomic, copy) NSString *png;
/** 表情的存放文件夹\目录 */
@property (nonatomic, copy) NSString *directory;
/** emoji表情的编码 */
@property (nonatomic, copy) NSString *code;
/** emoji表情的字符 */
@property (nonatomic, copy) NSString *emoji;
@end
