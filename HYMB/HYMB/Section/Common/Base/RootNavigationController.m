//
//  RootNavigationController.m
//  TracePlatform
//
//  Created by lym on 2017/5/3.
//  Copyright © 2017年 ehsureTec. All rights reserved.
//

#import "RootNavigationController.h"

@interface RootNavigationController ()

@end

@implementation RootNavigationController

/**
 * 当第一次使用这个类的时候会调用一次
 */
+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    //修改状态栏字体颜色
    bar.barStyle = UIStatusBarStyleDefault;
    
    NSMutableDictionary *atrr = [NSMutableDictionary dictionary];
    atrr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    atrr[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    //顶部字体颜色和大小
    [bar setTitleTextAttributes:atrr];
    
    //    //添加导航条背景图
    //    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav"]  forBarMetrics:UIBarMetricsDefault];
    
    //导航条颜色
    [bar setBarTintColor:NaviColor];
    [bar setShadowImage:[UIImage new]];
    
    //这行代码可以关闭半透明效果，但是会导致坐标0点移动。
    bar.translucent = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 * 可以在这个方法中拦截所有push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    self.fd_fullscreenPopGestureRecognizer.enabled = YES;
    
    // 如果push进来的不是第一个控制器
    if (self.childViewControllers.count > 0) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateHighlighted];
        button.frame = CGRectMake(15, 0, 40, 40);
        // 让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //[button sizeToFit];
        // 让按钮的内容往左边偏移10
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        // 修改导航栏左边的item
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
    
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

@end

