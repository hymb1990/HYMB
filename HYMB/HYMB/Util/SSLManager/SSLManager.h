//
//  SSLManager.h
//  HYMB
//
//  Created by sgft on 2018/9/11.
//  Copyright © 2018年 hymb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSLManager : NSObject

+ (void)openSSLCertificatesWith:(AFHTTPSessionManager *)manager requesType:(NSString *)requesType;

@end
