//
//  FMDBViewController.m
//  HYMB
//
//  Created by 863 on 2019/1/22.
//  Copyright © 2019年 hymb. All rights reserved.
//

#import "FMDBViewController.h"
#import "UserModel.h"
@interface FMDBViewController ()
@property(nonatomic,strong) UserModel *userModel;
@property(nonatomic,strong) FMDatabase *db;
@property(nonatomic,assign) NSInteger  count;
@end

@implementation FMDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"FMDB";
    self.view.backgroundColor = DefaultColor;
    
    _userModel = [UserModel new];
    _count = 1;
    //设置数据库名称
    NSString *fileName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"User.sqlite"];
    NSLog(@"%@",fileName);
    //2.获取数据库
    _db = [FMDatabase databaseWithPath:fileName];
    if ([_db open]) {
        NSLog(@"打开数据库成功");
    }else{
        NSLog(@"打开数据库s失败");
    }
    
}

- (IBAction)createTable:(id)sender {
    
    // CREATE TABLE IF NOT EXIST：表不存在 再创建    AUTOINCREMENT 自动增长   NOT NULL 不能为空
    //CREATE TABLE User (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL, sex text NOT NULL)
    //id integer PRIMARY KEY AUTOINCREMENT 将id作为主键 自动增长
    BOOL result = [self.db executeUpdate:@"CREATE TABLE IF NOT EXISTS User (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL, sex text NOT NULL);"];
    if (result) {
        NSLog(@"创建表成功");
    }else{
        NSLog(@"创建表失败");
    }
    
    
}

- (IBAction)dorpTable:(id)sender {
    BOOL result = [_db executeUpdate:@"drop table if exists User"];
    if (result) {
        
        NSLog(@"清除表中的所有数据成功");
    }else{
        NSLog(@"清除表中的所有数据失败");
    }
}


- (IBAction)add:(id)sender {
    NSString *name  = [NSString stringWithFormat:@"%@号大美钕",@(_count)];
    NSInteger age = _count;
    NSString *sex = _count%2 == 0 ? @"女":@"男";
    BOOL result = [self.db executeUpdate:@"INSERT INTO User (name,age,sex) VALUES (?,?,?)",name,@(age),sex];
    _count ++;
    result == YES ? NSLog(@"插入成功"):NSLog(@"插入失败");
}

- (IBAction)delete:(id)sender {
    BOOL result = [_db executeUpdate:@"delete from User where id = ?",@(5)];
    
    if (result) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
    }
}

- (IBAction)update:(id)sender {
    NSString *newName = @"花花";
    NSString *oldName = @"3号大美钕";
    
    BOOL result = [_db executeUpdate:@"update User set name = ? where name = ?",newName,oldName];
    
    if (result) {
        NSLog(@"修改成功");
    }else{
        NSLog(@"修改失败");
    }
}

- (IBAction)query:(id)sender {
    FMResultSet *resultSet  = [_db executeQuery:@"select * from User"];
    //遍历查询
    while ([resultSet next]) {
        //拿到每条数的id
        int idNum = [resultSet intForColumn:@"id"];
        NSString *name = [resultSet objectForColumn:@"name"];
        int age = [resultSet intForColumn:@"age"];
        NSString *sex = [resultSet objectForColumn:@"sex"];
        NSLog(@"学号：%@ 姓名：%@ 年龄：%@ 性别：%@",@(idNum),name,@(age),sex);
    }
}


@end
