//
//  AES.h
//  AES
//
//  Created by lym on 2017/4/28.
//  Copyright © 2017年 ehsureTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AES : NSObject

+ (NSString *) encryptWithPlainText:(NSString *)plainText key:(NSString *)key;
+ (NSString *) decryptWithCipherText:(NSString *)cipherText key:(NSString*)key;

@end
