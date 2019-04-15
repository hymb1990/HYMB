//
//  MineVC.m
//  HYMB
//
//  Created by sgft on 2018/9/7.
//  Copyright © 2018年 hymb. All rights reserved.
//

#import "MineVC.h"
#import "MyAlertView.h"
#import "PropertyViewController.h"

@interface MineVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArr;

@end

@implementation MineVC

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    
    self.dataArr = @[
                     @{@"title":@"Alert",
                       @"content":@[
                               @"系统Alert",
                               @"MyAlert",
                               ]},
                     @{@"title":@"属性修饰符",
                       @"content":@[
                               @"Property",
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
    
    NSString *title = @"简书著作权归作者所有，任何形式的转载都请联系作者获得授权";
    
    NSString *message = @"接私活对程序员这个圈子来说是一个既公开又隐秘的事情，接私活对程序员这个圈子来说是一个既公开又隐秘的事情，接私活对程序员这个圈子来说是一个既公开又隐秘的事情，接私活对程序员这个圈子来说是一个既公开又隐秘的事情，接私活对程序员这个圈子来说是一个既公开又隐秘的事情，接私活对程序员这个圈子来说是一个既公开又隐秘的事情，接私活对程序员这个圈子来说是一个既公开又隐秘的事情，接私活对程序员这个圈子来说是一个既公开又隐秘的事情，接私活对程序员这个圈子来说是一个既公开又隐秘的事情，";
    
    
    if ([cell.textLabel.text isEqualToString:@"系统Alert"]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertController addAction:cancel];
        [alertController addAction:confirm];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    
    if ([cell.textLabel.text isEqualToString:@"MyAlert"]) {
       
//        NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"MyAlertView"owner:self options:nil];
//        MyAlertView *alertView = [nibView objectAtIndex:0];
        
        MyAlertView *alertView = [[MyAlertView alloc] initWithTitle:title message:message];

        alertView.cancelBlock = ^{
            MYLog(@"取消");
        };
        
        alertView.confirmBlock = ^{
            MYLog(@"确定");
        };
        
        [alertView show];
    }
    
    
    if ([cell.textLabel.text isEqualToString:@"Property"]) {
    
        PropertyViewController *VC = [PropertyViewController new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    
}



@end









