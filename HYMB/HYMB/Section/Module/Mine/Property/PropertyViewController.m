//
//  PropertyViewController.m
//  HYMB
//
//  Created by 863Soft on 2019/3/25.
//  Copyright © 2019 hymb. All rights reserved.
//

#import "PropertyViewController.h"

@interface PropertyViewController ()

@property (nonatomic, strong) NSString *str1;
@property (nonatomic, copy) NSString *str2;
@property (nonatomic, strong) NSMutableString *str3;
@property (nonatomic, copy) NSMutableString *str4;

@end

@implementation PropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"属性修饰符";
    
    NSMutableString *str = [NSMutableString stringWithString:@"hello"];
    self.str1 = str;
    self.str2 = str;
    self.str3 = str;
    self.str4 = str;
    [str appendString:@" world"];
    NSLog(@"********************************************************************");
    NSLog(@"str    = %@   内存地址 = %p    指针地址 = %p",str,str,&str);
    NSLog(@"str1   = %@   内存地址 = %p    指针地址 = %p",self.str1,self.str1,&_str1);
    NSLog(@"str2   = %@   内存地址 = %p    指针地址 = %p",self.str2,self.str2,&_str2);
    NSLog(@"str3   = %@   内存地址 = %p    指针地址 = %p",self.str3,self.str3,&_str3);
    NSLog(@"str4   = %@   内存地址 = %p    指针地址 = %p",self.str4,self.str4,&_str4);
    NSLog(@"********************************************************************");

    [self.str3 appendString:@"3"];
    NSLog(@"********************************************************************");
    NSLog(@"str    = %@   内存地址 = %p    指针地址 = %p",str,str,&str);
    NSLog(@"str1   = %@   内存地址 = %p    指针地址 = %p",self.str1,self.str1,&_str1);
    NSLog(@"str2   = %@   内存地址 = %p    指针地址 = %p",self.str2,self.str2,&_str2);
    NSLog(@"str3   = %@   内存地址 = %p    指针地址 = %p",self.str3,self.str3,&_str3);
    NSLog(@"str4   = %@   内存地址 = %p    指针地址 = %p",self.str4,self.str4,&_str4);
    NSLog(@"********************************************************************");
    
//    [self.str4 appendString:@"4"];
    [str appendString:@"4"];
    NSLog(@"********************************************************************");
    NSLog(@"str    = %@   内存地址 = %p    指针地址 = %p",str,str,&str);
    NSLog(@"str1   = %@   内存地址 = %p    指针地址 = %p",self.str1,self.str1,&_str1);
    NSLog(@"str2   = %@   内存地址 = %p    指针地址 = %p",self.str2,self.str2,&_str2);
    NSLog(@"str3   = %@   内存地址 = %p    指针地址 = %p",self.str3,self.str3,&_str3);
    NSLog(@"str4   = %@   内存地址 = %p    指针地址 = %p",self.str4,self.str4,&_str4);
    NSLog(@"********************************************************************");
    

}



@end
