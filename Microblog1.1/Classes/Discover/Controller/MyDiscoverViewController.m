//
//  MyDiscoverViewController.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/3/20.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyDiscoverViewController.h"
#import "UIImage+Extension.h"
#import "UINavigationItem+Extension.h"
#import "MySearchBar.h"

@interface MyDiscoverViewController ()

@end

@implementation MyDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"系统设置" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    /*  一般是自定义一个UITextField，将这些封装起来
    UITextField *searchBar = [[UITextField alloc] init];
    searchBar.frame = CGRectMake(0, 0, 355, 35);
    [searchBar setBackground:[UIImage resizedImage:@"searchbar_textfield_background"]];
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, 35, 35);
    imageView.image = [UIImage imageWithName:@"searchbar_textfield_search_icon"];
    imageView.contentMode = UIViewContentModeCenter;
    searchBar.leftView = imageView;      //UITextField 中不仅有leftView，还有rightView，但是默认情况下，他们都是从不显示的，所以需要修改其中属性，使得他们总是显示
    searchBar.leftViewMode = UITextFieldViewModeAlways;   //设置leftView总是显示
    searchBar.clearButtonMode = UITextFieldViewModeAlways; //设置清楚按钮显示
    
    searchBar.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//设置内容垂直居中，以免造成内容垂直方向偏上
    self.navigationItem.titleView = searchBar;
     */
    MySearchBar *searchBar = [MySearchBar searchBarWithRect:CGRectMake(0, 0, 355, 35)];
    self.navigationItem.titleView = searchBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    NSString *ID = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    
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
