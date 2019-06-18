//
//  InteractiveViewController.m
//  HYMB
//
//  Created by 863Soft on 2019/6/4.
//  Copyright © 2019 hymb. All rights reserved.
//

#import "InteractiveViewController.h"
#import "QwerViewController.h"

@interface InteractiveViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArr;

@end

@implementation InteractiveViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    
    self.dataArr = @[
                     @{@"title":@"0",
                       @"content":@[
                               @"qwer",
                               @"qwert",
                               ]},
                     ];
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
    
    self.title = @"我的";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-NaviH) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    self.tableView.backgroundColor = DefaultColor;
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
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
    
    return [self.dataArr[section][@"content"] count];
    
}

/**
 * tableViewCell的相关属性
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    //修改cell属性，使其在选中时无色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataArr[indexPath.section][@"content"][indexPath.row];
    
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
    return 30;
}

/**
 * 分区脚的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

/**
 * 分区头
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = DefaultColor;
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 30)];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.text = self.dataArr[section][@"title"];
    [view addSubview:titleL];
    
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

    if ([cell.textLabel.text isEqualToString:@"qwer"]) {
        QwerViewController *VC = [QwerViewController new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if ([cell.textLabel.text isEqualToString:@"qwert"]) {
        QwerViewController *VC = [QwerViewController new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    
}



@end










