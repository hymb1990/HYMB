//
//  OC_JSVC.h
//  HYMB
//
//  Created by sgft on 2018/11/8.
//  Copyright © 2018年 hymb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JavaScriptObjectiveCDelegate <JSExport>
// JS调用此方法来调用OC的系统相册方法
- (void)callSystemCamera;
// 在JS中调用时，函数名应该为showAlertMsg(arg1, arg2)
// 这里是只两个参数的。
- (void)showAlert:(NSString *)title msg:(NSString *)msg;
// 通过JSON传过来
- (void)callWithDict:(NSDictionary *)params;
// JS调用Oc，然后在OC中通过调用JS方法来传值给JS。
- (void)jsCallObjcAndObjcCallJsWithDict:(NSDictionary *)params;
@end


@interface OC_JSVC : UIViewController
@end


// 此模型用于注入JS的模型，这样就可以通过模型来调用方法。
@interface HYBJsObjCModel : NSObject <JavaScriptObjectiveCDelegate>
@property (nonatomic, weak) JSContext *jsContext;
@property (nonatomic, weak) UIWebView *webView;
@end






