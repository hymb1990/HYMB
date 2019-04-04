//
//  NSData+AES256.h
//  AES
//
//  Created by lym on 2017/4/27.
//  Copyright © 2017年 ehsureTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES256)

- (NSData *)aes256_decrypt:(NSString *)key;
- (NSData *)aes256_encrypt:(NSString *)key;

@end
