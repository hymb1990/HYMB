//
//  RSAViewController.m
//  HYMB
//
//  Created by 863 on 2019/1/23.
//  Copyright © 2019年 hymb. All rights reserved.
//

#import "RSAViewController.h"
#import "RSA.h"
@interface RSAViewController ()

@end

@implementation RSAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)useDer:(id)sender {
    
    //原始数据
    NSString *originalString = @"这是一段将要使用'.der'文件加密的字符串!";
    
    //使用.der和.p12中的公钥私钥加密解密
    NSString *public_key_path = [[NSBundle mainBundle] pathForResource:@"public_key.der" ofType:nil];
    NSString *private_key_path = [[NSBundle mainBundle] pathForResource:@"private_key.p12" ofType:nil];
    
    NSString *encryptStr = [RSA encryptString:originalString publicKeyWithContentsOfFile:public_key_path];
    NSLog(@"加密前:%@", originalString);
    NSLog(@"加密后:%@", encryptStr);
    NSLog(@"解密后:%@", [RSA decryptString:encryptStr privateKeyWithContentsOfFile:private_key_path password:@"900519"]);
    
}


- (IBAction)useStr:(id)sender {
    
    //原始数据
    NSString *originalString = @"这是一段将要使用'秘钥字符串'进行加密的字符串!";
    
    //使用字符串格式的公钥私钥加密解密
    NSString *encryptStr = [RSA encryptString:originalString publicKey:@"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC73sRJEIp8o6J70XFBxg+21rBrQvm4CRWA2U2OLtKV3UCpgepxlapgDz/jlYWyW+B+5PgzoCWolkqOkqBcZS0OBSWb8vS3jDBbZnZ24t6QnkqrCrWWxFhLZqPAk+IEoCDNhCvjh8EefX1rOUMWqExuZkp02CFgWWHI4komBT53EQIDAQAB"];
    
    NSLog(@"加密前:%@", originalString);
    NSLog(@"加密后:%@", encryptStr);
    NSLog(@"解密后:%@", [RSA decryptString:encryptStr privateKey:@"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBALvexEkQinyjonvRcUHGD7bWsGtC+bgJFYDZTY4u0pXdQKmB6nGVqmAPP+OVhbJb4H7k+DOgJaiWSo6SoFxlLQ4FJZvy9LeMMFtmdnbi3pCeSqsKtZbEWEtmo8CT4gSgIM2EK+OHwR59fWs5QxaoTG5mSnTYIWBZYcjiSiYFPncRAgMBAAECgYA6sD+PN5ybjR7AIVCJJI9aJb0c9OI/zI6sHrYsmZHtgR2nFk+fxgpgUcM6nEYUzsDVwz+KGRhKjxChc0qnMnAdLEgkQ9mj8oHZIRSlDGNFbM1cE0l9+gdl6E3Du9WccZZsatpNKlmjKTKq3ZesqAqYkajSe+pHhvvNfxKLnE8ucQJBAPR9QrEeRF7IKAfvU214npcfxP3c7/cYUWy+SjA6Loj9VZWhKvsStK+31dzsyNDe4Y43E4d0DDQy2yeExQR2UnUCQQDEtxjMOULfG5qhZBzH6PFKEXEDvHBKA0tFKeXbfgS9yN/9KbMzunYFxKHfzOEFNyYheIzoiCxHQNqP5LGOsgatAkEAg4sFoABV7t0oVKSasZKtWUg5mBEQd1T5MlXr2qjjMseDDb+qPW4iE00I3xXzMhZJK1hMxJtWmZsnOMsBqdXzpQJACSt71XFJ47qWr7VJ/iumq8w6V3E+TsTuik/UrjGmqO4nOtbpypyDietLnHIhfyu99Et5ThGi9sNYLOL9P+ielQJBAPKG8WpBCWwvCWyB1tZ9AwmZikGpjyDr8NTAgyDfUo16A3O2NQMoyKeBFTL2K0MMpyNxpbFMSrPBLl+b+Ac6bLk="]);
}




@end
