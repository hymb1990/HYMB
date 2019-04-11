//
//  SpecialEffectsVC.m
//  HYMB
//
//  Created by 863Soft on 2019/4/10.
//  Copyright © 2019 hymb. All rights reserved.
//

#import "SpecialEffectsVC.h"
#import "HeadEnlargeVC.h"
#import "NavGradualChangeVC.h"
#import "HoverViewController.h"

@interface SpecialEffectsVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArr;

@end

@implementation SpecialEffectsVC

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = @[@"下拉头部放大", @"导航条渐变", @"上滑控件悬停"];
    
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
}

#pragma mark - 构建视图
- (void)setUI {
    
    self.title = @"特效";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    self.tableView.backgroundColor = DefaultColor;
    [self.view addSubview:self.tableView];
    
}

#pragma mark - tableView代理方法
/**
 * tableView的分区数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}


/**
 * tableView分区里的行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
     return 1;
}

/**
 * tableViewCell的相关属性
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    //修改cell属性，使其在选中时无色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = self.dataArr[indexPath.section];
    
    return cell;
}

/**
 * tableViewCell的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

/**
 * 分区头的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

/**
 * 分区脚的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

/**
 * 分区头
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = DefaultColor;
    return view;
}

/**
 * 分区脚
 */
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = DefaultColor;
    return view;
}


/**
 * tableViewCell的点击事件
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MYLog(@"%@", indexPath);
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell.textLabel.text isEqualToString:@"下拉头部放大"]) {
        HeadEnlargeVC *VC = [HeadEnlargeVC new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if ([cell.textLabel.text isEqualToString:@"导航条渐变"]) {
        NavGradualChangeVC *VC = [NavGradualChangeVC new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if ([cell.textLabel.text isEqualToString:@"上滑控件悬停"]) {
//        HoverViewController *VC = [HoverViewController new];
        UIViewController *VC = [HoverViewController suspendTopPausePageVC];
        [self.navigationController pushViewController:VC animated:YES];
    }
}

@end



