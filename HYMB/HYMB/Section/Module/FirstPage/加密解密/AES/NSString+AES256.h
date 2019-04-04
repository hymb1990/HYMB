//
//  NSString+AES256.h
//  AES
//
//  Created by lym on 2017/4/27.
//  Copyright © 2017年 ehsureTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AES256)

- (NSString *) aes256_encrypt:(NSString *)key;
- (NSString *) aes256_decrypt:(NSString *)key;

@end
