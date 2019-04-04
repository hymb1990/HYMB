//
//  WebVC.m
//  HYMB
//
//  Created by sgft on 2018/10/12.
//  Copyright © 2018年 hymb. All rights reserved.
//

#import "WebVC.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
@interface WebVC ()<UIWebViewDelegate, NJKWebViewProgressDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation WebVC
{
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}

- (void)viewDidLoad {
    [super viewDidLoad];
      [self setUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Remove progress view
    // because UINavigationBar is shared with other ViewControllers
    [_progressView removeFromSuperview];
}

- (void)setUI {
    
    self.title = @"网页加载进度条";
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-NaviH)];
    [self.webView setScalesPageToFit:YES];
    [self.view addSubview: self.webView];
    
    _progressProxy = [[NJKWebViewProgress alloc] init]; // instance variable
    self.webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.progressBarView.backgroundColor = [UIColor redColor];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    [self.webView loadRequest:request];
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
//    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

@end
