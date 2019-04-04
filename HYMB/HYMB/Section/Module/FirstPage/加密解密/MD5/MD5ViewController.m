//
//  MD5ViewController.m
//  HYMB
//
//  Created by 863 on 2019/1/23.
//  Copyright © 2019年 hymb. All rights reserved.
//

#import "MD5ViewController.h"
#import "MD5.h"
@interface MD5ViewController ()

@end

@implementation MD5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *secretPSWU32 = [MD5 MD5ForUpper32Bate:@"123456"];
    NSLog(@"MD5ForUpper32Bate:%@",secretPSWU32);
    
    NSString *secretPSWL32 = [MD5 MD5ForLower32Bate:@"123456"];
    NSLog(@"MD5ForLower32Bate:%@",secretPSWL32);
    
    NSString *secretPSWU16 = [MD5 MD5ForUpper16Bate:@"123456"];
    NSLog(@"MD5ForUpper16Bate:%@",secretPSWU16);
    
    NSString *secretPSWL16 = [MD5 MD5ForLower16Bate:@"123456"];
    NSLog(@"MD5ForLower16Bate:%@",secretPSWL16);
}


@end
