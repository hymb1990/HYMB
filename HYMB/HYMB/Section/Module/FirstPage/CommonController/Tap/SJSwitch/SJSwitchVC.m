//
//  SJSwitchVC.m
//  HYMB
//
//  Created by sgft on 2018/9/10.
//  Copyright © 2018年 hymb. All rights reserved.
//

#import "SJSwitchVC.h"
#import "FirstChildVC.h"
#import "SecondChildVC.h"

@interface SJSwitchVC ()
/** 标签栏底部的指示器 */
@property (nonatomic, weak) UIView *indicatorView;
/** 当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;
/** 顶部的所有标签 */
@property (nonatomic, weak) UIView *titlesView;

@end

@implementation SJSwitchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //建立视图
    [self setView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  建立视图
 */
- (void)setView {
    
    self.title = @"SJSwitchVC";
    self.view.backgroundColor = DefaultColor;
    
    //添加子控制器
    [self setChildViewController];
    
    //设置顶部的标签栏
    [self setTitlesView];
}



/**
 *  添加子控制器
 */
- (void)setChildViewController {
    
    
    FirstChildVC *contractDetailVC = [FirstChildVC new];
    //    contractDetailVC.contractId = _contractId;
    [self.viewControllers addObject:contractDetailVC];
    
    SecondChildVC *contractSupplyPlanQueryVC = [SecondChildVC new];
    //    contractSupplyPlanQueryVC.contractId = _contractId;
    [self.viewControllers addObject:contractSupplyPlanQueryVC];
    
  
}

/**
 *  设置顶部的标签栏
 */
- (void)setTitlesView
{
    
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    //titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.backgroundColor = [UIColor whiteColor];
    titlesView.width = self.view.width;
    titlesView.height = 40;
    titlesView.Y = 1;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = NaviColor;
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.Y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    // 内部的子标签
    CGFloat width = titlesView.width / self.viewControllers.count;
    CGFloat height = titlesView.height;
    NSArray *array = @[@"第一个", @"第二个"];
    for (NSInteger i = 0; i<self.viewControllers.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.X = i * width;
        NSString *title = array[i];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:NaviColor forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        //        if (i > 0) {
        //            UIView *midline = [[UIView alloc]initWithFrame:CGRectMake(0, 10, 1, height - 20)];
        //            midline.backgroundColor = [UIColor lightGrayColor];
        //            [button addSubview:midline];
        //        }
        
        
        // 默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    
    [titlesView addSubview:indicatorView];
    
}


#pragma mark - 自定义方法
- (void)titleClick:(UIButton *)button
{
    [self buttonStateChange:button];
    // 滚动
    [self setShowingIndex:button.tag animate:YES];
}

- (void)buttonStateChange:(UIButton *)button
{
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
}

/**
 *  SJSwitchViewControllerDelegate
 */
- (NSInteger)numberOfSwitchViewController
{
    return self.viewControllers.count;
}

- (UIViewController *)switchViewControllerDidGetViewControllerAtIndex:(NSUInteger)index
{
    return [self.viewControllers objectAtIndex:index];
}

- (void)switchViewControllerDidStopAtIndex:(NSInteger)index
{
    UIButton *button = self.titlesView.subviews[index];
    [self buttonStateChange:button];
}



@end

