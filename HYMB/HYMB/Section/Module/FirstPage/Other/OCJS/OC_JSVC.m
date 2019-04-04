//
//  OC_JSVC.m
//  HYMB
//
//  Created by sgft on 2018/11/8.
//  Copyright © 2018年 hymb. All rights reserved.
//

#import "OC_JSVC.h"
#import "OC_JSSecondVC.h"
@interface OC_JSVC () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) JSContext *jsContext;

@end

@implementation OC_JSVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"控制器一";
    
    [self.view addSubview:self.webView];
    
    // 一个JSContext对象，就类似于Js中的window，只需要创建一次即可。
    self.jsContext = [[JSContext alloc] init];
    
    // jscontext可以直接执行JS代码。
    [self.jsContext evaluateScript:@"var num = 10"];
    [self.jsContext evaluateScript:@"var squareFunc = function(value) { return value * 2 }"];
    // 计算正方形的面积
    JSValue *square = [self.jsContext evaluateScript:@"squareFunc(num)"];
    // 也可以通过下标的方式获取到方法
    JSValue *squareFunc = self.jsContext[@"squareFunc"];
    JSValue *value = [squareFunc callWithArguments:@[@"20"]];
    NSLog(@"%@", square.toNumber);
    NSLog(@"%@", value.toNumber);
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
}

- (UIWebView *)webView {
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.scalesPageToFit = YES;
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"first" withExtension:@"html"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
        _webView.delegate = self;
    }
    return _webView;
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    // 通过模型调用方法，这种方式更好些。
    HYBJsObjCModel *model  = [[HYBJsObjCModel alloc] init];
    self.jsContext[@"OCModel"] = model;
    model.jsContext = self.jsContext;
    model.webView = self.webView;
    
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
}

@end





@implementation HYBJsObjCModel

- (void)callWithDict:(NSDictionary *)params {
    NSLog(@"Js调用了OC的方法，参数为：%@", params);
    
    OC_JSSecondVC *VC = [OC_JSSecondVC new];
    [[Util getCurrentVC].navigationController pushViewController:VC animated:YES];
}


// Js调用了callSystemCamera
- (void)callSystemCamera {
    NSLog(@"JS调用了OC的方法，调起系统相册");
}



- (void)showAlert:(NSString *)title msg:(NSString *)msg {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *a = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [a show];
    });
}


- (void)jsCallObjcAndObjcCallJsWithDict:(NSDictionary *)params {
    
    NSLog(@"jsCallObjcAndObjcCallJsWithDict was called, params is %@", params);
    
    // 调用JS的方法
    JSValue *jsParamFunc = self.jsContext[@"jsParamFunc"];
    [jsParamFunc callWithArguments:@[@{@"age":params[@"age"], @"name":params[@"name"], @"height":params[@"height"]}]];
    
}

@end

