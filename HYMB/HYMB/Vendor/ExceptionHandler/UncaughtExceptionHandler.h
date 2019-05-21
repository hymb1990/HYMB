//
//  UncaughtExceptionHandler.m
//  DemoExceptionHandler
//
//  Created by chenzm on 2018/9/7.
//  Copyright © 2018年 chenzm. All rights reserved.
//

/**
 
 #import "AppDelegate.h"
 
 #import "UncaughtExceptionHandler.h"
 
 @interface AppDelegate ()
 @end
 @implementation AppDelegate
 
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
    //方法调用
    [UncaughtExceptionHandler installUncaughtExceptionHandler:YES showAlert:YES];
 
 return YES;
 }

 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UncaughtExceptionHandler : NSObject

/*!
 *  异常的处理方法
 *
 *  @param install   是否开启捕获异常
 *  @param showAlert 是否在发生异常时弹出alertView
 */
+ (void)installUncaughtExceptionHandler:(BOOL)install showAlert:(BOOL)showAlert;
@end

