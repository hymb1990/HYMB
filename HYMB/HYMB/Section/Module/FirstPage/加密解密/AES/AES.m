//
//  AES.m
//  AES
//
//  Created by lym on 2017/4/28.
//  Copyright © 2017年 ehsureTec. All rights reserved.
//

#import "AES.h"
#import "NSString+AES256.h"

@implementation AES
+ (NSString *)encryptWithPlainText:(NSString *)plainText key:(NSString *)key
{
    //加密
    NSString *secretPSW = [plainText aes256_encrypt:key];
    
    return secretPSW;
}

+ (NSString *)decryptWithCipherText:(NSString *)cipherText key:(NSString*)key
{
    //解密
    NSString *openPSW = [cipherText aes256_decrypt:key];
    
    return openPSW;
}

@end
