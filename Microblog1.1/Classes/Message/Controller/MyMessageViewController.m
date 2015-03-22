//
//  MyMessageViewController.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/3/20.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyMessageViewController.h"
#import "UIImage+Extension.h"
#import "UINavigationItem+Extension.h"

@interface MyMessageViewController ()

@end

@implementation MyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    /*自定义navigation按钮的文字
    UIButton *bnt = [[UIButton alloc] init];
    
    [bnt setTitle:@"写私信" forState:UIControlStateNormal];
    [bnt setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [bnt setTitle:@"写私信" forState:UIControlStateHighlighted];
    [bnt setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [bnt setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    bnt.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [bnt sizeToFit];
    [bnt addTarget:self action:@selector(composeMsg) forControlEvents:UIControlEventTouchUpInside];
     */
//    self.navigationItem.rightBarButtonItem = [UINavigationItem itemWithTitle:@"写私信" font:15.0 target:self action:@selector(composeMsg)];  //这是用UIButton设置

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"写私信" style:UIBarButtonItemStyleDone target:self action:@selector(composeMsg)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
}


- (void)composeMsg
{
    
    NSLog(@"MyMessageViewController---composeMsg");
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
