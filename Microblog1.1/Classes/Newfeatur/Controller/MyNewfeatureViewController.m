//
//  MyNewfeatureViewController.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/3/25.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyNewfeatureViewController.h"
#import "UIImage+Extension.h"
#import "MyTabBarController.h"

#define imageCount 4
@interface MyNewfeatureViewController () <UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation MyNewfeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setScrollView];
}

- (void)setScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:scrollView];
    //[scrollView setBackgroundColor:[UIColor redColor]];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    scrollView.delegate = self;
    
    int distanceX = 0;
    
    for (int i = 0; i < imageCount; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *str = [NSString stringWithFormat:@"new_feature_%d",i + 1];
        //new_feature_1-568h@2x
//        if ([UIScreen mainScreen].bounds.size.height == 568.0) {
//            str = [NSString stringWithFormat:@"%@-568h",str];
//            NSLog(@"%@",str);
//        }
        
        imageView.image = [UIImage imageWithName:str];
        imageView.frame = CGRectMake(distanceX, 0, self.view.frame.size.width, self.view.frame.size.height);
        //NSLog(@"%@",NSStringFromCGRect(imageView.frame));
        [scrollView addSubview:imageView];
        if (i == imageCount  - 1) {
            [self addShareButton:imageView];
            [self addBeginButton:imageView];
        }
        distanceX += [UIScreen mainScreen].bounds.size.width;
    }
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width * imageCount, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    UIPageControl *pageController = [[UIPageControl alloc] init];
    pageController.numberOfPages = imageCount;
    
    pageController.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height *0.9);
    pageController.pageIndicatorTintColor = [UIColor colorWithRed:189/255.0 green:189/255.0 blue:189/255.0 alpha:1.0];
    pageController.currentPageIndicatorTintColor = [UIColor colorWithRed:253/255.0 green:98/255.0 blue:42/255.0 alpha:1.0];
    [self.view addSubview:pageController];
    
    self.pageControl = pageController;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int number = scrollView.contentOffset.x / self.view.frame.size.width + 0.5;
    self.pageControl.currentPage = number;
}

- (void)addShareButton:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    UIButton *shareBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [shareBnt setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [shareBnt setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button_highlighted"] forState:UIControlStateSelected];
    [shareBnt setImage:[UIImage imageWithName:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBnt setImage:[UIImage imageWithName:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBnt addTarget:self action:@selector(shareBntClick:) forControlEvents:UIControlEventTouchUpInside];
    [shareBnt setTitle:@"分享给大家" forState:UIControlStateNormal];
    CGRect frame = shareBnt.frame;
    frame.size = CGSizeMake(135, 35);
    shareBnt.frame = frame;
    shareBnt.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.7);
    shareBnt.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [imageView addSubview:shareBnt];
}

- (void)shareBntClick:(UIButton *)bnt
{
    bnt.selected = !bnt.selected;
}

- (void)addBeginButton:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    UIButton *beginBnt = [[UIButton alloc] init];
    [beginBnt setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [beginBnt setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [beginBnt addTarget:self action:@selector(beginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [beginBnt setTitle:@"开始" forState:UIControlStateNormal];
    CGRect frame = beginBnt.frame;
    frame.size = CGSizeMake(135, 35);
    beginBnt.frame = frame;
    beginBnt.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.8);
    [imageView addSubview:beginBnt];
    
}

- (void)beginButtonClick
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MyTabBarController *Vc = [[MyTabBarController alloc] init];
    window.rootViewController = Vc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
