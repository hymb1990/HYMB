//
//  PickerVC.m
//  HYMB
//
//  Created by sgft on 2018/9/10.
//  Copyright © 2018年 hymb. All rights reserved.
//

#import "PickerVC.h"
#import "CommonPickerVC.h"
#import "CityPickerVC.h"
#import "DatePickerVC.h"
#import <BRPickerView.h>
@interface PickerVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PickerVC

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
    
    self.title = @"Picker";
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
    return 10;
}


/**
 * tableView分区里的行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
            //        case 0:
            //            return 1;
            //            break;
            //        case 1:
            //            return 2;
            //            break;
            
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
    

    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"CommonPicker";
    }
    
    if (indexPath.section == 1) {
        cell.textLabel.text = @"DatePicker";
    }
    
    if (indexPath.section == 2) {
        cell.textLabel.text = @"CityPicker";
    }
    
    if (indexPath.section == 3) {
        cell.textLabel.text = @"BRPickerView";
    }
    
    return cell;
}

/**
 * tableViewCell的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
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
    if (indexPath.section == 0) {
        CommonPickerVC *VC = [CommonPickerVC new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if (indexPath.section == 1) {
        DatePickerVC *VC = [DatePickerVC new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if (indexPath.section == 2) {
        CityPickerVC *VC = [CityPickerVC new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if (indexPath.section == 3) {
        
//        NSString *title = [self getCurrentTimes];
        
//        [BRDatePickerView showDatePickerWithTitle:title dateType:BRDatePickerModeYM defaultSelValue:nil resultBlock:^(NSString *selectValue) {
//            
//            NSLog(@"%@", selectValue);
//            
//        }];
        
//        [BRDatePickerView showDatePickerWithTitle:title dateType:BRDatePickerModeYM defaultSelValue:nil minDate:nil maxDate:nil isAutoSelect:YES themeColor:nil resultBlock:^(NSString *selectValue) {
//
//            NSLog(@"%@", selectValue);
//
//        }];
        
        
//        [BRAddressPickerView showAddressPickerWithDefaultSelected:@[@"江西省", @"赣州市", @"章贡区"] resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
//
//              NSLog(@"%@-%@-%@", province.name, city.name, area.name);
//
//        }];
        
        [BRAddressPickerView showAddressPickerWithDefaultSelected:@[@"江西省", @"赣州市", @"章贡区"] isAutoSelect:YES themeColor:[UIColor redColor] resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
            
             NSLog(@"%@-%@-%@", province.name, city.name, area.name);
            
        }];
        
        
        
        
        
        
        
        
    }
}

- (NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //[formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    [formatter setDateFormat:@"YYYY-MM"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}

@end







