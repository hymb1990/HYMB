//
//  UserManager.h
//  HYMB
//
//  Created by 863 on 2019/1/22.
//  Copyright © 2019年 hymb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserManager : NSObject<NSCoding>

@property (nonatomic, assign) int ID;
@property(nonatomic,copy)NSString *account;
@property(nonatomic,copy)NSString *pwd;
@property(nonatomic,assign)int age;

//自定义的归档保存数据的方法
+(void)saveUser:(UserManager *)user;

//自定义的读取沙盒中解档出的数据
+(UserManager *)getUser;

@end

NS_ASSUME_NONNULL_END
