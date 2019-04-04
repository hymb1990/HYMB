//
//  propertyListVC.m
//  HYMB
//
//  Created by 863 on 2019/1/22.
//  Copyright © 2019年 hymb. All rights reserved.
//
#define kUserPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"latestQuery.plist"]

#import "propertyListVC.h"

@interface propertyListVC ()
@property (nonatomic, strong) UILabel *cunL;
@property (nonatomic, strong) UILabel *quL;
@end

@implementation propertyListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"propertyList(属性列表)";
    self.view.backgroundColor = DefaultColor;
    
    
    UIButton *cunB = [UIButton new];
    [self.view addSubview:cunB];
    [cunB setTitle:@"存" forState:(UIControlStateNormal)];
    [cunB setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
    [cunB setBackgroundColor:[UIColor yellowColor]];
    [cunB addTarget:self action:@selector(cun) forControlEvents:(UIControlEventTouchUpInside)];
    [cunB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kScreen_Width/2);
        make.height.mas_equalTo(50);
    }];
    
    
    UIButton *quB = [UIButton new];
    [self.view addSubview:quB];
    [quB setTitle:@"取" forState:(UIControlStateNormal)];
    [quB setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
    [quB setBackgroundColor:[UIColor greenColor]];
    [quB addTarget:self action:@selector(qu) forControlEvents:(UIControlEventTouchUpInside)];
    [quB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(kScreen_Width/2);
        make.height.mas_equalTo(50);
    }];
    
    
    UIButton *shanchuB = [UIButton new];
    [self.view addSubview:shanchuB];
    [shanchuB setTitle:@"删除" forState:(UIControlStateNormal)];
    [shanchuB setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
    [shanchuB setBackgroundColor:[UIColor greenColor]];
    [shanchuB addTarget:self action:@selector(shanchu) forControlEvents:(UIControlEventTouchUpInside)];
    [shanchuB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-50);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kScreen_Width);
        make.height.mas_equalTo(50);
    }];
    
    
    _cunL = [UILabel new];
    [self.view addSubview:_cunL];
    _cunL.text = @"存储";
    _cunL.backgroundColor = [UIColor redColor];
    [_cunL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-310);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kScreen_Width);
        make.height.mas_equalTo(60);
    }];
    
    
    _quL = [UILabel new];
    [self.view addSubview:_quL];
    _quL.text = @"读取";
    _quL.backgroundColor = [UIColor brownColor];
    [_quL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-250);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kScreen_Width);
        make.height.mas_equalTo(60);
    }];
    

    
}

- (void)cun {
    
    //    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //    [dic setObject:@"小明" forKey:@"name"];
    //    //将字典持久化到Documents/
    //    [dic writeToFile:path atomically:YES];
    NSArray *arr = @[@"123",@"咋啦"];
    /**
     1、获取应用的文件夹（应用沙盒）
     NSSearchPathDirectory 搜索的目录
     NSSearchPathDomainMask 搜索范围 NSUserDomainMask：表示在用户的手机上查找
     expandTilde 是否展开全路径~ 如果没有展开,应用的沙盒路径就是~
     存储一定要展开路径 如果要存东西 必须要是YES
     */
    //YES:///Users/huahua/Library/Developer/CoreSimulator/Devices/0FB528AF-C34D-4F64-A723-6129E3FF3964/data/Containers/Data/Application/6FEDA2B8-40C2-40EA-9685-FE6DC828D7D2/Library/Caches
    //NO: ~/Library/Caches
    self.cunL.text = [NSString stringWithFormat:@"%@",arr];
    [arr writeToFile:kUserPath atomically:YES];
    
}

- (void)qu {
    NSArray *arr =  [NSArray arrayWithContentsOfFile:kUserPath];
    self.quL.text = [NSString stringWithFormat:@"%@ ",arr];
    NSLog(@"%@",arr);
}

- (void)shanchu {
    [[NSFileManager defaultManager] removeItemAtPath:kUserPath error:nil];
}

@end
