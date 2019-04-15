//
//  AESViewController.m
//  HYMB
//
//  Created by 863 on 2019/1/23.
//  Copyright © 2019年 hymb. All rights reserved.
//

#import "AESViewController.h"
#import "AES.h"
@interface AESViewController ()

@end

@implementation AESViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"AES";
    
    NSString *key = @"password";
    NSString *password = @"123456";

    //加密
    NSString *cipherPSW = [AES encryptWithPlainText:password key:key];
    NSLog(@"加密后:%@", cipherPSW);

    //解密
    NSString *plainPSW = [AES decryptWithCipherText:cipherPSW key:key];
    NSLog(@"解密后:%@", plainPSW);

    
}





@end
