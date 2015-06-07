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

#import "MyEmotionTextView.h"
#import "MyComposeToolBar.h"
#import "MyShowPhotoView.h"

#import "MyHTTPTool.h"
#import "MyAccountTool.h"
#import "MyAccount.h"
#import "MJExtension.h"
#import "MBProgressHUD+MJ.h"

#import "MySendStatusParam.h"
#import "MyStatusTool.h"

#import "MyEmotionKeyboard.h"
#import "MyEmotionNotification.h"

#import "MyEmotion.h"

@interface MyComposeViewController () <UITextViewDelegate, MyComposeToolBarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, weak) MyEmotionTextView *textView;
@property (nonatomic, weak) MyComposeToolBar *toolBar;
@property (nonatomic, weak) MyShowPhotoView *photoView;

/** 记录键盘是否正在改变 */
@property (nonatomic, assign) BOOL changeKeyboard;


/**  这里使用懒加载，因为这个view并不需要频繁创建，多次重复加载，只需要创建一次即可，为了性能，使用懒加载最好  */
@property (nonatomic, strong) MyEmotionKeyboard *keyboard;
@end

@implementation MyComposeViewController

- (MyEmotionKeyboard *)keyboard
{
    if (_keyboard == nil) {
        _keyboard = [[MyEmotionKeyboard alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 253, [UIScreen mainScreen].bounds.size.width, 253)];
    }
    return _keyboard;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.changeKeyboard = NO;
    
    [self setupNavigationbar];
    
    [self setupTextView];
    
    //添加ToolBar
    [self addToolBar];
    
    //添加相册
    [self addPhotoView];
    
    // 监听表情选中的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidClick:) name:MyEmotionDidSelectedNotification object:nil];
    // 监听删除按钮点击的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidDeleted:) name:MyEmotionDidDeletedNotification object:nil];
}

/**
 *  添加工具栏
 */
- (void)addToolBar
{
    MyComposeToolBar *toolBar = [[MyComposeToolBar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44)];
    self.toolBar = toolBar;
    
    toolBar.delegate = self; //设置代理
    
    [self.view addSubview:toolBar];
}
/**
 *  添加相册显示
 */
- (void)addPhotoView
{
    MyShowPhotoView *photoView = [[MyShowPhotoView alloc] initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height)];
    self.photoView = photoView;
    //[photoView setBackgroundColor:[UIColor redColor]];
    [self.textView addSubview:photoView];            //这里必须放在textView上，放在self.view 上是不正确的
}

#pragma mark - 键盘处理
/**
 *  自定义一个方法，在里面获取到键盘的信息，然后开始做动画
          当键盘将要弹出时，我们可以在这个方法里面得到键盘的高度、弹出的整个时间等信息
 */
- (void)keyboardWillShow:(NSNotification *)notification
{
    /*
    NSLog(@"------------%@",notification);
     通过Log会得到这样的信息
     {name = UIKeyboardWillShowNotification; userInfo = {
     UIKeyboardAnimationCurveUserInfoKey = 7;
     UIKeyboardAnimationDurationUserInfoKey = "0.25";
     UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {320, 253}}";
     UIKeyboardCenterBeginUserInfoKey = "NSPoint: {160, 694.5}";
     UIKeyboardCenterEndUserInfoKey = "NSPoint: {160, 441.5}";
     UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 568}, {320, 253}}";
     UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 315}, {320, 253}}";
     }}
     
     由此信息可以知道，键盘的高度以及其弹出的时间
     */
    CGFloat duration = [notification.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    CGRect frame = [notification.userInfo[@"UIKeyboardBoundsUserInfoKey"] CGRectValue];
    
    CGFloat keyboardH = frame.size.height;
    
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, - keyboardH);
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)keyboardWillHidden:(NSNotification *)notification
{
    if (self.changeKeyboard) {
        self.changeKeyboard = NO;
        return;
    }
    
    CGFloat duration = [notification.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
//    CGRect frame = [notification.userInfo[@"UIKeyboardBoundsUserInfoKey"] CGRectValue];
//    
//    CGFloat keyboardH = frame.size.height;
    
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.transform = CGAffineTransformIdentity;
    }];
    
}
/**
 *  加载textView
 */
- (void)setupTextView
{
    MyEmotionTextView *textView = [[MyEmotionTextView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:textView];
    self.textView = textView;
    self.textView.delegate = self;
    
    //设置占位文字
    self.textView.placeText = @"分享新鲜事...";
    
    //设置占位文字的颜色
    self.textView.placeTextColor = [UIColor lightGrayColor];
    
    //设置scrollView垂直方向上允许滚动
    self.textView.alwaysBounceVertical = YES;
    
    /****************在这里监听键盘的改变（弹出或者隐藏）*******************/
    // 键盘的frame(位置)即将改变, 就会发出UIKeyboardWillChangeFrameNotification
    // 键盘即将弹出, 就会发出UIKeyboardWillShowNotification
    // 键盘即将隐藏, 就会发出UIKeyboardWillHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

/**
 *  最好是将一些调出来比较耗时的控件放在这个方法中调出，因为这个时候view已经完全显示，不会阻碍view的显示
 *
 */
- (void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.textView endEditing:YES];
}


/**
 *  开始拖拽scrollView时调用
 *
 *
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.attributedText.length;
}

/**
 *  设置导航栏,247,184,185
 */
- (void)setupNavigationbar
{
    self.navigationItem.title = @"发微博";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    
    UIButton *bnt = [[UIButton alloc] init];
    [bnt setTitle:@"发送" forState:UIControlStateNormal];
    
    
    [bnt sizeToFit];  //自适应尺寸
//    self.tabBarItem
    
    [bnt setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [bnt setTitleColor:[UIColor colorWithRed:247/255.0 green:184/255.0 blue:185/255.0 alpha:1] forState:UIControlStateHighlighted];
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
/**
 *  发送微博
 */
- (void)send
{
    if (self.photoView.subviews.count) {
        [self sendStatusWithImage];
    }
    else
    {
        [self sendStatusWithoutImage];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  发表有图片微博
 */
- (void)sendStatusWithImage
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [[MyAccountTool account] access_token];
    params[@"status"] = self.textView.text;
    
    UIImage *image = [self.photoView.imageArray firstObject];
    
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    
    [MyHTTPTool post:@"https://upload.api.weibo.com/2/statuses/upload.json" params:params data:data name:@"pic" fileName:@"status.jpg" mimeType:@"image/jpeg" success:^(id json) {
        [MBProgressHUD showSuccess:@"发送成功..."];
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"发送失败..."];
    }];
    
}
/**
 *  发表无图片微博
 */
- (void)sendStatusWithoutImage
{
    // 1.封装请求参数
    MySendStatusParam *param = [[MySendStatusParam alloc] init];
    param.access_token = [[MyAccountTool account] access_token];
    param.status = self.textView.text;
    
    // 2.发微博
    [MyStatusTool sendStatusWithParam:param success:^(MySendStatusResult *result) {
        [MBProgressHUD showSuccess:@"发表成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发表失败"];
    }];
}

#pragma mark -- 相机、相册问题
/*************打开手机相机、相册等问题************************/
/*
 1、首先也遵守UINavigationControllerDelegate, UIImagePickerControllerDelegate 这两个协议
 
 2、监听toolBar内部按钮的点击，实现相应的方法
 */

- (void)didClickButton:(UIButton *)button
{
    
    /*
     MyComposeToolBarButtonCamera, // 照相机
     MyComposeToolBarButtonPicture, // 相册
     MyComposeToolBarButtonMention, // 提到@
     MyComposeToolBarButtonTrend, // 话题
     MyComposeToolBarButtonEmotion // 表情
     */
    switch (button.tag) {
        case MyComposeToolBarButtonCamera:
            [self openCamera];
            break;
        case MyComposeToolBarButtonPicture:
            [self openPicture];
            break;
        case MyComposeToolBarButtonEmotion:
            [self openEmotion];
            break;
    }
}
/**
 *  打开相机
 */
- (void)openCamera
{
    
    /*
     UIImagePickerControllerSourceTypePhotoLibrary,         相册
     UIImagePickerControllerSourceTypeCamera,               相机
     UIImagePickerControllerSourceTypeSavedPhotosAlbum
     */
    //先判断设备是否有相机
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}
/**
 *  打开相册
 */
- (void)openPicture
{
     //判断是否有相册
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        return;
    }
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}
/**
 *  打开表情
 */
- (void)openEmotion
{
    self.changeKeyboard = YES;
    if (self.textView.inputView == nil) {
        self.textView.inputView = self.keyboard;
        self.toolBar.showEmotionButton = NO;
    }else
    {
        self.textView.inputView = nil;
        self.toolBar.showEmotionButton = YES;
    }
    
    
    [self.textView resignFirstResponder];
    self.changeKeyboard = NO;  //由于_changeKeyboard是用来记录，键盘是否在进行表情键盘和默认键盘之间切换，如果是的话，那么工具条不应该跟随键盘退下去，当键盘退下（隐藏的时候）会调用（通知监听，方法）keyboardWillHidden，那么，当知道这个值为YES的时候，应当不进行工具条退下操作，同时，当（表情或者默认）键盘退下完成时，应当立刻把keyboardWillHidden设置为NO,一边进行拖拽scrollView的时候，可以同时将键盘与工具条一起退下隐藏
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView  becomeFirstResponder];
    });
    
}

#pragma mark -- UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
//    NSLog(@"---------%@",info);
    
    // 1.取出选中的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // 2.添加到photoView上
    [self.photoView addImage:image];
    
}


#pragma mark -- MyEmotionNotifacation
/**
 *  当表情选中的时候调用
 *
 *  @param note 里面包含了选中的表情
 */
- (void)emotionDidClick:(NSNotification *)note
{
    MyEmotion *emotion = note.userInfo[MySelectedEmotion];
    [self.textView appendEmotion:emotion];
    
    [self textViewDidChange:self.textView];
}

/**
 *  当点击表情键盘上的删除按钮时调用
 */
- (void)emotionDidDeleted:(NSNotification *)note
{
    [self.textView deleteBackward];
}
@end
