//
//  CoreDataViewController.m
//  HYMB
//
//  Created by 863 on 2019/1/22.
//  Copyright © 2019年 hymb. All rights reserved.
//

#import "CoreDataViewController.h"
#import "UserInfo+CoreDataClass.h"
#import <CoreData/CoreData.h>
@interface CoreDataViewController ()
@property(nonatomic,strong)NSManagedObjectContext *context;
@property(nonatomic,assign) NSInteger  count;
@end

@implementation CoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CoreData";
}

- (IBAction)createTable:(id)sender {
    
    //注意创建时候的后缀用momd
    NSURL *pathurl = [[NSBundle mainBundle]URLForResource:@"HuaHua" withExtension:@"momd"];
    
    NSManagedObjectModel *model  = [[NSManagedObjectModel alloc]initWithContentsOfURL:pathurl];
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
    
    NSString *dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"UserInfo.sqlite"];
    
    NSLog(@"____%@",dbPath);
    NSError *error = nil;
    
    NSURL *url = [NSURL fileURLWithPath:dbPath];
    [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil
                              error:&error];
    if (error == nil) {
        NSLog(@"数据库添加成功");
    }else{
        NSLog(@"数据库添加失败");
    }
    
    self.context  = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    self.context.persistentStoreCoordinator = psc;
    
}



- (IBAction)dropTable:(id)sender {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserInfo"];
    
    NSError *error = nil;
    NSArray *arrResult  = [self.context executeFetchRequest:fetchRequest error:&error];
    for (UserInfo *user in arrResult) {
        [self.context deleteObject:user];
    }
    BOOL  result =  [self.context save:&error];
    result == YES? NSLog(@"清空所有数据成功"):NSLog(@"清空所有数据失败");
    
    
//    //1.创建查询请求 EntityName：想要清楚的实体的名字
//    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"UserInfo"];
//    //2.创建删除请求  参数是：查询请求 //NSBatchDeleteRequest是iOS9之后新增的API，不兼容iOS8及以前的系统
//    NSBatchDeleteRequest *deletRequest = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
//    //3.使用存储调度器(NSPersistentStoreCoordinator)执行删除请求
//    /**
//     Request：存储器请求（NSPersistentStoreRequest）删除NSBatchDeleteRequest继承于NSPersistentStoreRequest
//     context：管理对象
//     */
//    [self.context.persistentStoreCoordinator executeRequest:deletRequest withContext:self.context error:nil];
   
}


#pragma mark 增
- (IBAction)add:(id)sender {
    //运用NSEntityDescription创建NSManagedObject对象
    UserInfo *user = [NSEntityDescription insertNewObjectForEntityForName:@"UserInfo" inManagedObjectContext:self.context];
    
    user.name = [NSString stringWithFormat:@"%@号大美钕",@(_count)];
    user.age = _count;
    user.sex = _count%2 ==0 ? @"女":@"男";
    
    NSError *savaError = nil;
    BOOL result = [self.context save:&savaError];
    _count ++;
    result == YES ? NSLog(@"插入成功"):NSLog(@"插入失败");
}

- (IBAction)delete:(id)sender {
    //NSFetchRequest：一条查询请求，相当于 SQL 中的select语句
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserInfo"];
    //NSPredicate：谓词，指定一些查询条件，相当于 SQL 中的where
    NSPredicate *predicate  = [NSPredicate predicateWithFormat:@"age>=%d",5];
    fetchRequest.predicate = predicate;
    NSError *error = nil;
    NSArray *arrResult  = [self.context executeFetchRequest:fetchRequest error:&error];
    
    if (arrResult.count >0) {
        for (UserInfo *user in arrResult) {
            NSLog(@"%ld",user.age);
            [self.context deleteObject:user];
        }
        BOOL result =   [self.context save:nil];
        result == YES? NSLog(@"删除成功"):NSLog(@"删除失败");
    }
}

- (IBAction)update:(id)sender {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserInfo"];
    NSPredicate *predicate  = [NSPredicate predicateWithFormat:@"age=%d",2];
    fetchRequest.predicate = predicate;
    NSError *error = nil;
    NSArray *arrResult  = [self.context executeFetchRequest:fetchRequest error:&error];
    for (UserInfo *user in arrResult) {
        NSLog(@"%ld",user.age);
        user.age = 1000;
    }
    BOOL result  =   [self.context save:&error];
    result == YES? NSLog(@"修改成功"):NSLog(@"修改失败");
}

- (IBAction)query:(id)sender {
    //获取这个类
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserInfo" inManagedObjectContext:self.context];
    //创建查询请求
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    //设置查询请求的实体
    [fetchRequest setEntity:entity];
    NSArray *arrResult = [self.context executeFetchRequest:fetchRequest error:nil];
    for (UserInfo *user in arrResult) {
        NSLog(@"名字是:%@ 性别是:%@ 年龄是:%ld",user.name,user.sex,user.age);
    }
}



@end
