//
//  UserInfo+CoreDataProperties.h
//  
//
//  Created by 863 on 2019/1/22.
//
//

#import "UserInfo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface UserInfo (CoreDataProperties)

+ (NSFetchRequest<UserInfo *> *)fetchRequest;

@property (nonatomic) int64_t age;
@property (nullable, nonatomic, copy) NSString *sex;
@property (nullable, nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
