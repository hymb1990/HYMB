//
//  PreferenceVC.m
//  HYMB
//
//  Created by 863 on 2019/1/22.
//  Copyright © 2019年 hymb. All rights reserved.
//

#import "PreferenceVC.h"

@interface PreferenceVC ()
@property (nonatomic, strong) UILabel *cunL;
@property (nonatomic, strong) UILabel *quL;
@end

@implementation PreferenceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Preference(偏好设置)";
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


/**
 偏好设置好处:
 1.不需要关心文件名（不需要设置路径）
 2.键值对存储（账号相关信息） 对象存储
 底层实现原理就是封装了一个字典
 */
- (void)cun {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //放到缓存里，并不会马上放到文件里面
    [userDefaults setObject:@"123" forKey:@"account"]; //对象
    [userDefaults setObject:@"123456" forKey:@"pwd"];
    //BOOL类型
    [userDefaults setBool:YES forKey:@"status"];
    //在ios7 默认不会马上跟硬盘同步  同步操作 起到立即存储的作用
    [userDefaults synchronize];
    self.cunL.text = [NSString stringWithFormat:@"account:%@ pwd:%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"account"],[[NSUserDefaults standardUserDefaults]objectForKey:@"pwd"]];

    
}

- (void)qu {
    
    NSString *account = [[NSUserDefaults standardUserDefaults]objectForKey:@"account"];
    NSString *pwd = [[NSUserDefaults standardUserDefaults]objectForKey:@"pwd"];
    NSLog(@"偏好设置---账号：%@ 密码：%@",account,pwd);
    self.quL.text = [NSString stringWithFormat:@"account:%@ pwd:%@",account,pwd];
    
}

- (void)shanchu {
    
    NSUserDefaults *userDefalits = [NSUserDefaults standardUserDefaults];
    [userDefalits removeObjectForKey:@"account"];
    [userDefalits removeObjectForKey:@"pwd"];
    [userDefalits synchronize];
    
}

@end

