//
//  MyHomeViewController.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/3/20.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyHomeViewController.h"
#import "UIImage+Extension.h"
#import "UINavigationItem+Extension.h"
#import "MyTitleButton.h"
#import "MyPopMenu.h"

#define ID @"homeCell"
@interface MyHomeViewController ()<MyPopMenuDelegate>

@end

@implementation MyHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     naviagtion的naviagtionbar按钮设置，但必须将这些方法封装成一个类，调用即可
     
    UIButton *bnt = [[UIButton alloc] init];

    [bnt setBackgroundImage:[UIImage imageWithName:@"navigationbar_friendsearch"] forState:UIControlStateNormal];
    [bnt setBackgroundImage:[UIImage imageWithName:@"navigationbar_friendsearch_highlighted"] forState:UIControlStateHighlighted];
    [bnt addTarget:self action:@selector(friendsearch:) forControlEvents:UIControlEventTouchUpInside];
    
    bnt.frame = CGRectMake(0, 0, bnt.currentBackgroundImage.size.width, bnt.currentBackgroundImage.size.height);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:bnt];
    
    self.navigationItem.leftBarButtonItem = item;
    
    UIButton *rightBnt = [[UIButton alloc] init];
    [rightBnt setBackgroundImage:[UIImage imageWithName:@"navigationbar_pop"] forState:UIControlStateNormal];
    [rightBnt setBackgroundImage:[UIImage imageWithName:@"navigationbar_pop_highlighted"] forState:UIControlStateHighlighted];
    [rightBnt addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    
    rightBnt.frame = CGRectMake(0, 0, rightBnt.currentBackgroundImage.size.width, rightBnt.currentBackgroundImage.size.height);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBnt];
    
    self.navigationItem.rightBarButtonItem = rightItem;
     */
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    self.navigationItem.leftBarButtonItem = [UINavigationItem itemWithImageName:@"navigationbar_friendsearch" highImageName:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendsearch:)];
    
    self.navigationItem.rightBarButtonItem = [UINavigationItem itemWithImageName:@"navigationbar_pop" highImageName:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    //设置导航栏标题
    MyTitleButton *titleBnt = [[MyTitleButton alloc] init];
    titleBnt.frame = CGRectMake(0, 0, 100, 35);
    [titleBnt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleBnt setTitle:@"首页" forState:UIControlStateNormal];
    [titleBnt setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleBnt setBackgroundImage:[UIImage resizedImage:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    [titleBnt addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleBnt;
    
    
}
/**
 *  这是在实现MyPopMenuDelegate方法
 *  在这个方法中恢复navigationItem 的 titleView 正常
 */
- (void)popMenuDidDismissed:(MyPopMenu *)popMenu
{
    MyTitleButton *titleBnt = (MyTitleButton *)self.navigationItem.titleView;
    [titleBnt setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
}

- (void)titleClick:(UIButton *)bnt
{
    
    
    [bnt setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [button setBackgroundColor:[UIColor redColor]];
    MyPopMenu *popMenu = [MyPopMenu popMenuWithContentView:button];
    popMenu.delegate = self;
    [popMenu showInRect:CGRectMake(120, 64, 100, 100)];
}

- (void)friendsearch:(id)bnt
{
    
    //NSLog(@"MyHomeViewController---friendsearch");
}

- (void)pop
{
    //NSLog(@"MyHomeViewController---pop");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.textLabel.text = @"xnibcsbcn";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *newVc = [[UIViewController alloc] init];
    [newVc.view setBackgroundColor:[UIColor redColor]];
    [newVc.navigationController setTitle:@"新控制器"];
    [self.navigationController pushViewController:newVc animated:YES];
}
@end
