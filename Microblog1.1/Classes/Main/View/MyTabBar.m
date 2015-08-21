//
//  MyTabBar.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/3/25.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyTabBar.h"
#import "UIImage+Extension.h"
#import "MyComposeViewController.h"


@interface MyTabBar ()
/**
 *  正中间的加号按钮
 */
@property (nonatomic, weak) UIButton *plusBnt;
@end

@implementation MyTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.plusBnt = [self setupPlusBnt];
    }
    return self;
}

- (UIButton *)setupPlusBnt
{
    UIButton *plusBnt = [[UIButton alloc] init];
    
    [plusBnt setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:UIControlStateNormal];
    
    [plusBnt setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    
    [plusBnt setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [plusBnt setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    
    [plusBnt addTarget:self action:@selector(plusBntClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:plusBnt];
    
    return plusBnt;
}

/**
 *  跳转到发微博界面
 */
- (void)plusBntClick
{
    //MyComposeViewController *Vc = [[MyComposeViewController alloc] init];
    if ([self.delegatePlus respondsToSelector:@selector(tabBarDidPlusBntClick)]) {
        [self.delegatePlus tabBarDidPlusBntClick];
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setPlusBntFrame];
    [self setTabBarButtonFrame];
}

- (void)setPlusBntFrame
{
    self.plusBnt.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height *0.5);
    CGRect frame = self.plusBnt.frame;
    frame.size = CGSizeMake(self.plusBnt.currentBackgroundImage.size.width, self.plusBnt.currentBackgroundImage.size.height);
    self.plusBnt.frame =frame;
}

- (void)setTabBarButtonFrame
{
    
    int index = 0;  //这边tabbar里面有四个tabbarItem，需要索引区别
//    NSLog(@"----------");
    for (UIView *tabBarButton in self.subviews) {  //虽然UITabBarButton在tabbar里面是私有的，但是可以通过查看tabbar的子控件的方式，使得有强指针指向这个控件，从而达到修改其属性的目的
//        NSLog(@"-----%@",[tabBarButton class]);
        if (![tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
        //在这里设置tabtarbutton的frame
        CGFloat frameW = self.frame.size.width / (self.items.count + 1.0);
        CGFloat frameH = self.frame.size.height;

        CGFloat frameX = frameW * index;
        CGFloat frameY = 0;
        if (index >= 2)
        {
            frameX = frameW * (index + 1);
        }
        tabBarButton.frame = CGRectMake(frameX, frameY, frameW, frameH);
        
        int selected = [self.items indexOfObject:self.selectedItem];//取出被选中得那个item
        
        //修改选中按钮文字颜色，由于这个属性也是只读，也可以采用这种方法将它改掉
        //这里，这种方法，还可以使用在其他控件上，比如图片太多，也可以如此修改图片frame
        for (UILabel *label in tabBarButton.subviews) {
            if (![label isKindOfClass:[UILabel class]]) continue;
            
            
            if (selected == index) {
                [label setTextColor:[UIColor orangeColor]];
                label.font = [UIFont systemFontOfSize:10];
            }
            else
            {
                [label setTextColor:[UIColor blackColor]];
                label.font = [UIFont systemFontOfSize:10];
            }
        }
        index++;
    }
}



@end
