//
//  YBPopVC.m
//  HYMB
//
//  Created by sgft on 2018/9/10.
//  Copyright © 2018年 hymb. All rights reserved.
//

#import "YBPopVC.h"
#import "YBPopupMenu.h"

#define TITLES @[@"扫一扫", @"分享我们"]
#define ICONS  @[@"扫一扫", @"分享"]
@interface YBPopVC ()<YBPopupMenuDelegate>

@property (nonatomic, strong) YBPopupMenu *popupMenu;

@end

@implementation YBPopVC

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
}

#pragma mark - 构建视图
- (void)setUI {
    
    self.title = @"YBPopVC";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 60, 30)];
    [btn1 addTarget:self action:@selector(btn1ClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [btn1 setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [btn1 setTitle:@"btn1" forState:(UIControlStateNormal)];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(310, 20, 60, 30)];
    [btn2 addTarget:self action:@selector(btn2ClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [btn2 setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [btn2 setTitle:@"btn2" forState:(UIControlStateNormal)];
    
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
}

- (void)btn1ClickAction:(UIButton *)sender {
    CGRect absoluteRect = [sender convertRect:sender.bounds toView:kMainWindow];
    CGPoint relyPoint = CGPointMake(absoluteRect.origin.x + absoluteRect.size.width/2, absoluteRect.origin.y + absoluteRect.size.height/2);
    
    self.popupMenu = [[YBPopupMenu alloc] initWithTitles:TITLES icons:ICONS menuWidth:130 delegate:nil];
    self.popupMenu.dismissOnSelected = YES;
    self.popupMenu.isShowShadow = YES;
    self.popupMenu.delegate = self;
    self.popupMenu.offset = 20;
    self.popupMenu.type = YBPopupMenuTypeDefault;
    [self.popupMenu showAtPoint:relyPoint];
}

- (void)btn2ClickAction:(UIButton *)sender {
    CGRect absoluteRect = [sender convertRect:sender.bounds toView:kMainWindow];
    CGPoint relyPoint = CGPointMake(absoluteRect.origin.x + absoluteRect.size.width/2, absoluteRect.origin.y + absoluteRect.size.height/2);
    
    self.popupMenu = [[YBPopupMenu alloc] initWithTitles:TITLES icons:ICONS menuWidth:130 delegate:nil];
    self.popupMenu.dismissOnSelected = YES;
    self.popupMenu.isShowShadow = YES;
    self.popupMenu.delegate = self;
    self.popupMenu.offset = 20;
    self.popupMenu.type = YBPopupMenuTypeDark;
    self.popupMenu.cornerRadius = 2;
    [self.popupMenu showAtPoint:relyPoint];
}

#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu {
    
    //扫码
    if (index == 0) {
        MYLog(@"点击了 %@ 选项", TITLES[index]);
    }
    
    //分享
    if (index == 1) {
        MYLog(@"点击了 %@ 选项", TITLES[index]);
    }
    
}

@end






