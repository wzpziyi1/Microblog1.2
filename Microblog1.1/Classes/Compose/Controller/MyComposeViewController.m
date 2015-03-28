//
//  MyComposeViewController.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/3/25.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyComposeViewController.h"
#import "UINavigationItem+Extension.h"
#import "MyNavigationController.h"
@interface MyComposeViewController ()

@end

@implementation MyComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"发微博";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    
    UIButton *bnt = [[UIButton alloc] init];
    [bnt setTitle:@"发送" forState:UIControlStateNormal];
    [bnt sizeToFit];
    [bnt setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [bnt setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    bnt.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [bnt addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:bnt];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send
{
    
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
