//
//  LLSegmentBarViewController.m
//  HYMB
//
//  Created by 863 on 2019/3/5.
//  Copyright © 2019年 hymb. All rights reserved.
//

#import "LLSegmentBarViewController.h"
#import "LLSegmentBarVC.h"
#import "FirstChildVC.h"
#import "SecondChildVC.h"

@interface LLSegmentBarViewController ()

@property (nonatomic,weak) LLSegmentBarVC * segmentVC;

@end

@implementation LLSegmentBarViewController

// lazy init
- (LLSegmentBarVC *)segmentVC{
    if (!_segmentVC) {
        LLSegmentBarVC *vc = [[LLSegmentBarVC alloc]init];
        // 添加到到控制器
        [self addChildViewController:vc];
        _segmentVC = vc;
    }
    return _segmentVC;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *locationItem = [[UIBarButtonItem alloc] initWithTitle:@"ggg" style:UIBarButtonItemStylePlain target:self action:@selector(nothing)];
    locationItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = locationItem;
    
    // 1 设置segmentBar的frame
    self.segmentVC.segmentBar.frame = CGRectMake(0, 0, kScreen_Width, 35);
    self.navigationItem.titleView = self.segmentVC.segmentBar;
//    self.segmentVC.segmentBar.frame = CGRectMake(0, 0, kScreen_Width, 35);
//    [self.view addSubview:self.segmentVC.segmentBar];
    
    // 2 添加控制器的View
    self.segmentVC.view.frame = CGRectMake(0, 0, kScreen_Width*3, kScreen_Height-NaviH);
//    self.segmentVC.view.frame = CGRectMake(0, 35, kScreen_Width*3, kScreen_Height-NaviH-35);
    [self.view addSubview:self.segmentVC.view];
    
    
    NSArray *items = @[@"item-one", @"item-two", @"item-three"];
    FirstChildVC *vc1 = [FirstChildVC new];
    vc1.view.backgroundColor = [UIColor redColor];
    SecondChildVC *vc2 = [SecondChildVC new];
    vc2.view.backgroundColor = [UIColor orangeColor];
    UIViewController *vc3 = [UIViewController new];
    vc3.view.backgroundColor = [UIColor yellowColor];
    
    // 3 添加标题数组和控住器数组
    [self.segmentVC setUpWithItems:items childVCs:@[vc1,vc2,vc3]];
    
    
    // 4  配置基本设置  可采用链式编程模式进行设置
    [self.segmentVC.segmentBar updateWithConfig:^(LLSegmentBarConfig *config) {
        config.itemNormalColor([UIColor blackColor]).itemSelectColor([UIColor redColor]).indicatorColor([UIColor greenColor]);
//        config.itemNormalColor([UIColor blackColor]).itemSelectColor([UIColor redColor]).indicatorColor([UIColor greenColor]).segmentBarBackColor([UIColor orangeColor]);
    }];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_bg_64"] forBarMetrics:UIBarMetricsDefault];
    
    
}

- (void)nothing {
    
}

@end
