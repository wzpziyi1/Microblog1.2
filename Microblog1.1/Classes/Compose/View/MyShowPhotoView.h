//
//  MyShowPhotoView.h
//  Microblog1.1
//
//  Created by 王志盼 on 15/4/13.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyShowPhotoView : UIView
@property (nonatomic, strong) NSArray *imageArray;

- (void)addImage:(UIImage *)image;
@end
