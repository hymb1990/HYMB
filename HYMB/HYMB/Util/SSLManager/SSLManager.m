//
//  SSLManager.m
//  HYMB
//
//  Created by sgft on 2018/9/11.
//  Copyright © 2018年 hymb. All rights reserved.
//

#import "SSLManager.h"

@implementation SSLManager

+ (void)openSSLCertificatesWith:(AFHTTPSessionManager *)manager requesType:(NSString *)requesType{
    
    //单向认证
    // 加上这行代码，https ssl 验证。
    [manager setSecurityPolicy:[self customSecurityPolicyWithRequestType:requesType]];
    
    //双向认证
    if (!isTest) {
        //客服端请求验证 重写 setSessionDidReceiveAuthenticationChallengeBlock 方法
        __weak typeof(manager.securityPolicy)weakPolicy = manager.securityPolicy;
        [manager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession *session, NSURLAuthenticationChallenge *challenge, NSURLCredential *__autoreleasing *_credential) {
            
            NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
            __autoreleasing NSURLCredential *credential = nil;
            if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
                //                if([weakPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host]) {
                //                    credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
                //                    if(credential) {
                //                        disposition =NSURLSessionAuthChallengeUseCredential;
                //                    } else {
                //                        disposition =NSURLSessionAuthChallengePerformDefaultHandling;
                //                    }
                //                } else {
                //                    disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
                //                }
            } else {
                // client authentication
                SecIdentityRef identity = NULL;
                SecTrustRef trust = NULL;
                NSString *p12 = [[NSBundle mainBundle] pathForResource:isTest?@"GZYPT_Test":@"GZYPT"ofType:@"p12"];
                NSFileManager *fileManager =[NSFileManager defaultManager];
                
                if(![fileManager fileExistsAtPath:p12]) {
                    MYLog(@"client.p12:not exist");
                } else {
                    NSData *PKCS12Data = [NSData dataWithContentsOfFile:p12];
                    if ([[self class] extractIdentity:&identity andTrust:&trust fromPKCS12Data:PKCS12Data]) {
                        SecCertificateRef certificate = NULL;
                        SecIdentityCopyCertificate(identity, &certificate);
                        const void*certs[] = {certificate};
                        CFArrayRef certArray =CFArrayCreate(kCFAllocatorDefault, certs,1,NULL);
                        credential =[NSURLCredential credentialWithIdentity:identity certificates:(__bridge  NSArray*)certArray persistence:NSURLCredentialPersistencePermanent];
                        disposition =NSURLSessionAuthChallengeUseCredential;
                    }
                }
            }
            *_credential = credential;
            return disposition;
        }];
        
    }
}

+ (AFSecurityPolicy*)customSecurityPolicyWithRequestType:(NSString *)requestType {
    
    NSString *cerPath = nil;
    if ([requestType isEqualToString:@"51"]) {
        cerPath = [[NSBundle mainBundle] pathForResource:isTest?@"GZYPT_51Test":@"GZYPT_51" ofType:@"cer"];//证书的路径
    }else {
        cerPath = [[NSBundle mainBundle] pathForResource:isTest?@"GZYPT_96Test":@"GZYPT_96" ofType:@"cer"];//证书的路径
    }
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    NSSet *set = [NSSet setWithArray:@[certData]];
    securityPolicy.pinnedCertificates = set;
    
    return securityPolicy;
}

+ (BOOL)extractIdentity:(SecIdentityRef*)outIdentity andTrust:(SecTrustRef *)outTrust fromPKCS12Data:(NSData *)inPKCS12Data {
    
    OSStatus securityError = errSecSuccess;
    //client certificate password
    NSDictionary*optionsDictionary = [NSDictionary dictionaryWithObject:isTest?@"123456789":caPassword
                                                                 forKey:(__bridge id)kSecImportExportPassphrase];
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import((__bridge CFDataRef)inPKCS12Data,(__bridge CFDictionaryRef)optionsDictionary,&items);
    
    if(securityError == 0) {
        CFDictionaryRef myIdentityAndTrust =CFArrayGetValueAtIndex(items,0);
        const void*tempIdentity =NULL;
        tempIdentity= CFDictionaryGetValue (myIdentityAndTrust,kSecImportItemIdentity);
        *outIdentity = (SecIdentityRef)tempIdentity;
        const void*tempTrust =NULL;
        tempTrust = CFDictionaryGetValue(myIdentityAndTrust,kSecImportItemTrust);
        *outTrust = (SecTrustRef)tempTrust;
    } else {
        return NO;
    }
    return YES;
}

@end
