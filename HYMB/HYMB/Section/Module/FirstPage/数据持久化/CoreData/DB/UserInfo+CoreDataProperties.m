//
//  UserInfo+CoreDataProperties.m
//  
//
//  Created by 863 on 2019/1/22.
//
//

#import "UserInfo+CoreDataProperties.h"

@implementation UserInfo (CoreDataProperties)

+ (NSFetchRequest<UserInfo *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"UserInfo"];
}

@dynamic age;
@dynamic sex;
@dynamic name;

@end
