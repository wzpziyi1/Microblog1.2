//
//  MyOAuthViewController.m
//  Microblog1.1
//
//  Created by 王志盼 on 15/3/29.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyOAuthViewController.h"
#import "MBProgressHUD+MJ.h"
#import "MyHTTPTool.h"
#import "MJExtension.h"
#import "MyAccount.h"
#import "MyControllerTool.h"
#import "MyAccountTool.h"
#import "MyAccessTokenParam.h"


#define MyAppKey @"3722612068"
#define MyRedirectURI @"http://www.cnblogs.com/"
#define MyAppSecret @"dd877b1d3dadeb885597937e5e70a492"
@interface MyOAuthViewController () <UIWebViewDelegate>

@end

@implementation MyOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIWebView *web = [[UIWebView alloc] init];
    [self.view addSubview:web];
    web.frame = self.view.bounds;
    NSString *str = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",MyAppKey,MyRedirectURI];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //NSLog(@"%@",str);
    [web loadRequest:request];
    web.delegate = self;
}

/**
 *  UIWebView开始加载资源的时候调用(开始发送请求)
 *
 */
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载..."];
}
/**
 *  UIWebView加载完毕的时候调用(请求完毕)
 *
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}
/**
 *  UIWebView加载失败的时候调用(请求失败)
 *
 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}
/**
 *  UIWebView每当发送一个请求之前，都会先调用这个代理方法（询问代理允不允许加载这个请求）
 *
 *  @param request        即将发送的请求
 
 *  @return YES : 允许加载， NO : 禁止加载
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = request.URL.absoluteString;
    NSLog(@"url-------%@",url);
    NSString *str = [NSString stringWithFormat:@"%@?code=",MyRedirectURI];
   // NSLog(@"str-------%@",str);
    NSRange range = [url rangeOfString:str];
    //NSLog(@"range-----%@",NSStringFromRange(range));
    if (range.length != 0) {
        int index = range.location + range.length;
        NSString *code = [url substringFromIndex:index];
        //NSLog(@"code-----%@",code);
        [self accessTokenWithCode:code];
        
        return NO;
    }
    return YES;
}

- (void)accessTokenWithCode:(NSString *)code
{
//    //请求管理者
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    //mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];  //需要设置这个变量接受text/plain的文件格式，但又不能直接覆盖它，所以去它所在的文件加上就好   加上的话，在acceptableContentTupes 、AFURLResponseSerialization里面
//    //请求参数
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    
//    params[@"client_id"] = MyAppKey;
//    params[@"client_secret"] = MyAppSecret;
//    params[@"redirect_uri"] = MyRedirectURI;
//    params[@"grant_type"] = @"authorization_code";
//    params[@"code"] = code;
//    
//    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [MBProgressHUD hideHUD];
////        NSLog(@"请求成功------%@",responseObject);
//        MyAccount *account = [MyAccount accountWithDict:responseObject];
//        [MyAccountTool save:account];
//        account = [MyAccountTool account];
//        [MyControllerTool chooseRootViewController];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD hideHUD];
//        NSLog(@"请求失败------%@",error);
//    }];
    
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    
//    params[@"client_id"] = MyAppKey;
//    params[@"client_secret"] = MyAppSecret;
//    params[@"redirect_uri"] = MyRedirectURI;
//    params[@"grant_type"] = @"authorization_code";
//    params[@"code"] = code;
//    
//    [MyHTTPTool post:@"https://api.weibo.com/oauth2/access_token" params:params success:^(id json) {
//            [MBProgressHUD hideHUD];
//        //    NSLog(@"请求成功------%@",responseObject);
//            MyAccount *account = [MyAccount accountWithDict:json];
//            [MyAccountTool save:account];
//            account = [MyAccountTool account];
//            [MyControllerTool chooseRootViewController];
//    } failure:^(NSError *error) {
//            [MBProgressHUD hideHUD];
//            NSLog(@"请求失败------%@",error);
//    }];
    
    MyAccessTokenParam *param = [[MyAccessTokenParam alloc] init];
    param.client_id = MyAppKey;
    param.client_secret = MyAppSecret;
    param.redirect_uri = MyRedirectURI;
    param.grant_type = @"authorization_code";
    param.code = code;

    [MyAccountTool accessTokenWithParam:param success:^(MyAccount *account) {
        [MBProgressHUD hideHUD];
        
        [MyAccountTool save:account];
        
        [MyControllerTool chooseRootViewController];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        
        NSLog(@"请求失败--%@", error);
    }];
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
