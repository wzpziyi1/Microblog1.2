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
#import "MBProgressHUD+MJ.h"
#import "MJExtension.h"
#import "MyAccount.h"
#import "MyControllerTool.h"
#import "MyAccountTool.h"

#import "MyStatus.h"
#import "MyUser.h"
#import "MyHTTPTool.h"
#import "UIImageView+WebCache.h"

#import "MyAccountTool.h"
#import "MyAccount.h"

#import "MyFootView.h"
#import "MyUserInfoParam.h"
#import "MyUserTool.h"
#import "MyUserInfoResult.h"
#import "MyHomeStatusesParam.h"
#import "MyStatusTool.h"

#import "MyStatusCell.h"
#import "MyStatusFrame.h"
@interface MyHomeViewController ()<MyPopMenuDelegate, UIScrollViewDelegate>


@property (nonatomic, weak) MyFootView *footView;

@property (nonatomic, weak) MyTitleButton *titleButton;

@property (nonatomic, weak) UIRefreshControl *refreshControl;

/**
 *  微博数组(存放着所有的微博frame数据)
 */
@property (nonatomic, strong) NSMutableArray *statusFrames;
@end

@implementation MyHomeViewController

- (NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

/**
 *  根据微博模型数组 转成 微博frame模型数据
 *
 *  @param statuses 微博模型数组
 *
 */
- (NSArray *)statusFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (MyStatus *status in statuses) {
        MyStatusFrame *frame = [[MyStatusFrame alloc] init];
        // 传递微博模型数据，计算所有子控件的frame
        frame.status = status;
        [frames addObject:frame];
    }
    return frames;
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    //设置导航栏
    [self setNavigationBar];
    
//    
    //设置用户昵称
    [self setupUserInfo];
    
    //刷新数据
    [self setupRefresh];
    
    //添加footView,控制上拉刷新,设置代理，监听scrollView的滚动，当footView滚动到一定位置时，开始刷新
    MyFootView *footView = [MyFootView footView];
    self.tableView.tableFooterView = footView;
    self.footView = footView;
    
}
/**
 *  监听scrollView的滚动，当footView滚动到一定位置时，开始上拉刷新
 *
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.statusFrames.count <= 0 || self.footView.isRefreshing) {
        return;
    }
    //差距
    CGFloat distance = self.tableView.contentSize.height - self.tableView.contentOffset.y;
    // 刚好能完整看到footer的高度
    CGFloat seeFootH = self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height;
    //如果能看见整个footer
    if (distance + 20 < seeFootH) {
        [self.footView beginLoad];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //向下加载更多数据
            [self loadMoreStatus];
        });
    }
}

/**
 *  向下加载更多数据
 */
- (void)loadMoreStatus
{
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"access_token"] = [[MyAccountTool account] access_token];
//    MyStatus *lastStatus = [self.statuses lastObject];
//    
//    if (lastStatus) {
//        // max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
//        params[@"max_id"] = @([lastStatus.idstr longLongValue] - 1);
//    }
//    [MyHTTPTool get:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params success:^(id json) {
//        NSArray *StatusArray = json[@"statuses"];
//        NSArray *oldStatuses = [MyStatus objectArrayWithKeyValuesArray:StatusArray];
//
//        // 将新数据插入到旧数据的最后面
//        [self.statuses addObjectsFromArray:oldStatuses];
//
//        [self.tableView reloadData];
//                
//        [self.footView endLoad];
//    } failure:^(NSError *error) {
//        [self.footView endLoad];
//    }];
    MyHomeStatusesParam *param = [MyHomeStatusesParam param];
    MyStatusFrame *lastStatusFrame =  [self.statusFrames lastObject];
    MyStatus *lastStatus = lastStatusFrame.status;
    if (lastStatus) {
        param.max_id = @([lastStatus.idstr longLongValue] - 1);
    }
    
    [MyStatusTool homeStatusesWithParam:param success:^(MyHomeStatusesResult *result) {
        
        // 获得最新的微博frame数组
        NSArray *newFrames = [self statusFramesWithStatuses:result.statuses];
        
        // 将新数据插入到旧数据的最后面
        [self.statusFrames addObjectsFromArray:newFrames];
        
        [self.tableView reloadData];
        
        [self.footView endLoad];
    } failure:^(NSError *error) {
        NSLog(@"请求失败--%@", error);
        [self.footView endLoad];
    }];
}

- (void)setupRefresh
{
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init]; //上拉刷新控件
    [self.tableView addSubview:refresh];
    self.refreshControl = refresh;
    
    [refresh addTarget:self action:@selector(refreshControlStateChange:) forControlEvents:UIControlEventValueChanged]; //在UIRefreshControl里面是没有方法可以监听值改变的，但是UIRefreshControl继承自UIControll，从而可以监听值得改变，做到上拉刷新操作
    
    [refresh beginRefreshing];
    
    [self refreshControlStateChange:refresh];
    
}
/**
 *  下拉刷新时，调用
 *
 */
- (void)refreshControlStateChange:(UIRefreshControl *)refresh
{
//        //封装请求参数
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    params[@"access_token"] = [[MyAccountTool account] access_token];
//    MyStatus *firstStatus = [self.statuses firstObject];
//
//    if (firstStatus) {
//        // since_id 	false 	int64 	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
//        params[@"since_id"] = firstStatus.idstr;
//    }
//    [MyHTTPTool get:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params success:^(id json) {
//        NSArray *statusArray = json[@"statuses"];
//
//        NSArray *newStatuses = [MyStatus objectArrayWithKeyValuesArray:statusArray];  //数组转模型
//        //NSLog(@"%@",newStatuses);
//        
//        /****************************将一个数组中得所有对象插入另一个数组的索引位置******************************************/
//        
//        //        [self.statuses insertObject:statusArray atIndex:0];   //这个函数，是将一个数组当成一个对象插入到另一个数组的索引位置
//        
//        NSRange range = NSMakeRange(0, newStatuses.count);
//        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
//        [self.statuses insertObjects:newStatuses atIndexes:indexSet];
////      NSLog(@"----------%@",self.statuses.count);
//        //刷新tableView
//        [self.tableView reloadData];
//        [refresh endRefreshing];
//        //显示新的微博数量
//        [self showNewStatusCount:(int)newStatuses.count];
//    } failure:^(NSError *error) {
//        NSLog(@"刷新失败");
//        [refresh endRefreshing];
//    }];
    // 封装请求参数
    MyHomeStatusesParam *param = [MyHomeStatusesParam param];
    MyStatusFrame *firstStatusFrame =  [self.statusFrames firstObject];
    MyStatus *firstStatus = firstStatusFrame.status;
    if (firstStatus) {
        param.since_id = @([firstStatus.idstr longLongValue]);
    }
    
    // 加载微博数据
    [MyStatusTool homeStatusesWithParam:param success:^(MyHomeStatusesResult *result) {
        // 获得最新的微博frame数组
        NSArray *newFrames = [self statusFramesWithStatuses:result.statuses];
        
        // 将新数据插入到旧数据的最前面
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:newFrames atIndexes:indexSet];
        
        [self.tableView reloadData];
        
        [refresh endRefreshing];
        
        [self showNewStatusCount:(int)newFrames.count];
    } failure:^(NSError *error) {
        NSLog(@"请求失败--%@", error);
        [refresh endRefreshing];
    }];
}

/**
 *  显示微博数目
 *
 */
- (void)showNewStatusCount:(int)count
{
    UILabel *showStatus = [[UILabel alloc] init];
    
    if (count) {
        showStatus.text = [NSString stringWithFormat:@"共有%d条新的微博数据",count];
    }
    else
    {
        showStatus.text = @"没有新的微博数据";
    }
//    [UIImage imageNamed:@"timeline_new_status_background"]
    showStatus.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"timeline_new_status_background"]];
    showStatus.textAlignment = NSTextAlignmentCenter;
    showStatus.frame = CGRectMake(0, 29, self.view.frame.size.width, 35);
    
    [self.navigationController.view insertSubview:showStatus belowSubview:self.navigationController.navigationBar];  //最好是添加到这里
    
    /*******************将一个控件插入另一控件*************************/
    
//    self.view insertSubview:<#(UIView *)#> belowSubview:<#(UIView *)#>  将一个控件插入另一控件下面
//    self.view insertSubview:<#(UIView *)#> atIndex:<#(NSInteger)#>  按索引插入
//    self.view insertSubview:<#(UIView *)#> aboveSubview:<#(UIView *)#>  插入上面
    
    
//    [self.view addSubview:showStatus];
    
    [UIView animateWithDuration:0.75 animations:^{
        showStatus.transform = CGAffineTransformMakeTranslation(0, 35);
    } completion:^(BOOL finished) {
//        [NSThread sleepForTimeInterval:1];  //阻塞主线程1s，再执行下面操作
        
        
        /**
         UIViewAnimationOptionCurveEaseInOut            = 0 << 16, // 开始：由慢到快，结束：由快到慢
         UIViewAnimationOptionCurveEaseIn               = 1 << 16, // 由慢到块
         UIViewAnimationOptionCurveEaseOut              = 2 << 16, // 由快到慢
         UIViewAnimationOptionCurveLinear               = 3 << 16, // 线性，匀速
         */

        [UIView animateWithDuration:0.75 delay:1 options:UIViewAnimationOptionCurveLinear animations:^{  //延时1s
            
            showStatus.transform = CGAffineTransformIdentity;   //回到原来的状态
        } completion:^(BOOL finished) {
            [showStatus removeFromSuperview];
        }];
        
    }];
}

/**
 *  设置用户昵称
 */
- (void)setupUserInfo
{
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    params[@"access_token"] = [[MyAccountTool account] access_token];
//    //NSLog(@"-----------%@",[[MyAccountTool account] access_token]);
//    
//    [MyHTTPTool get:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params success:^(id json) {
////        NSLog(@"请求成功------%@",responseObject[@"statuses"]);
////        NSLog(@"----%@",[responseObject class]);
//        NSArray *statusArray = json[@"statuses"];
//        self.statuses = [MyStatus objectArrayWithKeyValuesArray:statusArray];
//        
////        for (id object in self.statuses) {
////            NSLog(@"----%@-----%@",[object class],object);
////        }
//        [self.tableView reloadData];
//    } failure:^(NSError *error) {
//        
//    }];
    // 1.封装请求参数
    MyUserInfoParam *param = [[MyUserInfoParam alloc] init];
    param.access_token = [[MyAccountTool account] access_token];
    param.uid = [[MyAccountTool account] uid];
    
    // 2.加载用户信息
    [MyUserTool userInfoWithParam:param success:^(MyUserInfoResult *user) {
        // 设置用户的昵称为标题
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
        
        // 存储帐号信息
        MyAccount *account = [MyAccountTool account];
        account.name = user.name;
        [MyAccountTool save:account];
    } failure:^(NSError *error) {
        NSLog(@"请求失败-------%@", error);
    }];
}

- (void)setNavigationBar
{
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
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    self.navigationItem.leftBarButtonItem = [UINavigationItem itemWithImageName:@"navigationbar_friendsearch" highImageName:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendsearch:)];
    
    self.navigationItem.rightBarButtonItem = [UINavigationItem itemWithImageName:@"navigationbar_pop" highImageName:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    //设置导航栏标题
    MyTitleButton *titleBnt = [[MyTitleButton alloc] init];
    titleBnt.frame = CGRectMake(0, 0, 100, 35);
    self.titleButton = titleBnt;
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
/**
 *  弹出弹框
 *
 */
- (void)titleClick:(UIButton *)bnt
{
    
    
    [bnt setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [button setBackgroundColor:[UIColor redColor]];
    MyPopMenu *popMenu = [MyPopMenu popMenuWithContentView:button];
    popMenu.delegate = self;
    [popMenu showInRect:CGRectMake(120, 64, 200, 300)];
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
    
    self.footView.hidden = !self.statusFrames.count; //要写在这个地方
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyStatusCell *cell = [MyStatusCell cellWithTableView:tableView];
    
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyStatusFrame *frame = self.statusFrames[indexPath.row];
    return frame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *newVc = [[UIViewController alloc] init];
    [newVc.view setBackgroundColor:[UIColor redColor]];
    [newVc.navigationController setTitle:@"新控制器"];
    [self.navigationController pushViewController:newVc animated:YES];
}

- (void)refresh:(BOOL)flg
{
    if (self.tabBarItem.badgeValue) {
        self.tabBarItem.badgeValue = nil;
        [self.refreshControl beginRefreshing];
        [self refreshControlStateChange:self.refreshControl];
    }else if (flg)
    {
        // 让表格回到最顶部
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
}
@end
