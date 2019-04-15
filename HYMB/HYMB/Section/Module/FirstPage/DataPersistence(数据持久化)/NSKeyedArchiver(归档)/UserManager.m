//
//  UserManager.m
//  HYMB
//
//  Created by 863 on 2019/1/22.
//  Copyright © 2019年 hymb. All rights reserved.
//

#import "UserManager.h"
@implementation UserManager
/** 什么时候调用：自定义对象归档的时候
 作用：用来描述当前对象里面的哪些属性要归档
 aCoder：用来归档
 */
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_account forKey:@"account"];
    [aCoder encodeInteger:_age forKey:@"age"];
}

/** 什么时候调用：解档对象的时候调用
 作用：用来描述当前对象里面的哪些属性要解档*/
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self  = [super init]) {
        //注意一定要给成员变量赋值保存起来
        _account = [aDecoder decodeObjectForKey:@"account"];
        _age =   [aDecoder decodeIntForKey:@"age"];
    }
    return self;
}

//自定义的归档保存数据的方法
+(void)saveUser:(UserManager *)user{
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *path=[docPath stringByAppendingPathComponent:@"UserInfo.plist"];
    [NSKeyedArchiver archiveRootObject:user toFile:path];
}

//自定义的读取沙盒中解档出的数据
+(UserManager *)getUser{
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *path=[docPath stringByAppendingPathComponent:@"UserInfo.plist"];
    UserManager *user = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return user;
}

@end
