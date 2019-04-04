//
//  RootTabBarViewController.m
//  gwwz19
//
//  Created by 华通众和 on 16/11/18.
//  Copyright © 2016年 华鑫志和科技. All rights reserved.
//

#import "RootTabBarController.h"
#import "HYMBNavigationController.h"
#import "FirstPageVC.h"
#import "MineVC.h"

@interface RootTabBarController ()

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加子导航控制器
    [self addChildViewController:[FirstPageVC new] WithBottomTitle:@"首页" AndTopTitle:@"首页" AndImageName:@"首页"];
    [self addChildViewController:[MineVC new] WithBottomTitle:@"我的" AndTopTitle:@"我的" AndImageName:@"我的"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 * 添加子导航控制器
 */
- (void)addChildViewController:(UIViewController *)childController WithBottomTitle:(NSString *)bottomTitle AndTopTitle:(NSString *)topTitle AndImageName:(NSString *)imageName {
    //新建导航条
    HYMBNavigationController *nav = [HYMBNavigationController new];
    [nav addChildViewController:childController];
    
    //修改导航条属性
    //图片
    nav.tabBarItem.image = [UIImage imageNamed:imageName];
    //选中图片
    nav.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@sel", imageName]];
    //底部标题
    nav.tabBarItem.title = bottomTitle;
    //顶部标题
    childController.navigationItem.title = topTitle;
    
    NSMutableDictionary *atrr = [NSMutableDictionary dictionary];
    atrr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    atrr[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    //顶部字体颜色和大小
    [nav.navigationBar setTitleTextAttributes:atrr];

//    //添加导航条背景图
//    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav"]  forBarMetrics:UIBarMetricsDefault];
    //导航条颜色
    [nav.navigationBar setBarTintColor:NaviColor];
    [nav.navigationBar setShadowImage:[UIImage new]];
    
    //这行代码可以关闭半透明效果，但是会导致坐标0点移动。
    nav.navigationBar.translucent = NO;
    
    //添加为子导航控制器
    [self addChildViewController:nav];
    
    //修改tabbar上字体颜色
    self.tabBar.tintColor = NaviColor;

}


@end
