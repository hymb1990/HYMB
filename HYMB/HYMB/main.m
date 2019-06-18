//
//  main.m
//  HYMB
//
//  Created by sgft on 2018/9/7.
//  Copyright © 2018年 hymb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        NSLog(@"开始");
        int re = UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        NSLog(@"结束");
        return re;
        
//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        
    }
}
