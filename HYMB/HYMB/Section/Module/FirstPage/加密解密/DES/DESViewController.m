//
//  DESViewController.m
//  HYMB
//
//  Created by 863 on 2019/1/23.
//  Copyright © 2019年 hymb. All rights reserved.
//

#import "DESViewController.h"
#import "DES.h"
@interface DESViewController ()

@end

@implementation DESViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *key = @"password";
    NSString *password = @"123456";
    
    //加密
    NSString *cipherPSW = [DES encryptWithPlainText:password key:key];
    NSLog(@"加密后:%@", cipherPSW);
    
    //解密
    NSString *plainPSW = [DES decryptWithCipherText:cipherPSW key:key];
    NSLog(@"解密后:%@", plainPSW);
}


@end
