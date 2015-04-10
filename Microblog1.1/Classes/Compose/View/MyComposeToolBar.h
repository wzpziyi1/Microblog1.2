//
//  MyComposeToolBar.h
//  Microblog1.1
//
//  Created by 王志盼 on 15/4/7.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    MyComposeToolBarButtonCamera, // 照相机
    MyComposeToolBarButtonPicture, // 相册
    MyComposeToolBarButtonMention, // 提到@
    MyComposeToolBarButtonTrend, // 话题
    MyComposeToolBarButtonEmotion // 表情
    
}MyComposeToolBarButtonType;

@protocol MyComposeToolBarDelegate <NSObject>
@optional
- (void)didClickButton:(UIButton *)button;

@end


@interface MyComposeToolBar : UIView
@property (nonatomic, weak) id <MyComposeToolBarDelegate> delegate;
@end
