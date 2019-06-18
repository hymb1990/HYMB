//
//  QwerViewController.m
//  HYMB
//
//  Created by 863Soft on 2019/6/4.
//  Copyright © 2019 hymb. All rights reserved.
//

#import "QwerViewController.h"

@interface QwerViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation QwerViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    self.title = @"qwer";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-NaviH) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    self.tableView.backgroundColor = DefaultColor;
    [self.view addSubview:self.tableView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 200)];
    headerView.backgroundColor = [UIColor orangeColor];
    self.tableView.tableHeaderView = headerView;
    
    
    
    UIScrollView *scrollV = [UIScrollView new];
    scrollV.backgroundColor = [UIColor redColor];
    scrollV.frame = CGRectMake(0, 0, kScreen_Width, 100);
    scrollV.contentSize = CGSizeMake(kScreen_Width+200, 100);
    self.scrollView = scrollV;
    
    UIButton *btn1 = [UIButton new];
    btn1.frame = CGRectMake(0, 0, 50, 50);
    [btn1 setBackgroundColor:[UIColor blueColor]];
    [self.scrollView addSubview:btn1];
    
    UIButton *btn2 = [UIButton new];
    btn2.frame = CGRectMake(100, 0, 50, 50);
    [btn2 setBackgroundColor:[UIColor blueColor]];
    [self.scrollView addSubview:btn2];
    
    UIButton *btn3 = [UIButton new];
    btn3.frame = CGRectMake(200, 0, 50, 50);
    [btn3 setBackgroundColor:[UIColor blueColor]];
    [self.scrollView addSubview:btn3];
    
    
}

#pragma mark - tableView代理方法
/**
 * tableView的分区数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}


/**
 * tableView分区里的行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
            
        default:
            return 1;
            break;
    }
}

/**
 * tableViewCell的相关属性
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    //修改cell属性，使其在选中时无色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        [cell.contentView addSubview:self.scrollView];
    }
    
    return cell;
}

/**
 * tableViewCell的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
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
}

@end



