//
//  MyStatusCell.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/4/27.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyStatusCell.h"
#import "MyStatusDetailView.h"
#import "MyStatusToolbar.h"
#import "MyStatusFrame.h"

@interface MyStatusCell()
@property (nonatomic, weak) MyStatusDetailView *detailView;
@property (nonatomic, weak) MyStatusToolbar *toolbar;
@end

@implementation MyStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    MyStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[MyStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) { // 初始化子控件
        // 1.添加微博具体内容
        MyStatusDetailView *detailView = [[MyStatusDetailView alloc] init];
        [self.contentView addSubview:detailView];
        self.detailView = detailView;
        
        // 2.添加工具条
        MyStatusToolbar *toolbar = [[MyStatusToolbar alloc] init];
        [self.contentView addSubview:toolbar];
        self.toolbar = toolbar;
        
        // 3.cell的设置
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setStatusFrame:(MyStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 微博具体内容的frame数据
    self.detailView.detailFrame = statusFrame.detailFrame;
    
    // 底部工具条的frame数据
    self.toolbar.frame = statusFrame.toolbarFrame;
    self.toolbar.status = statusFrame.status;
}
@end
