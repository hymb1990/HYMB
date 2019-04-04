//
//  NetworkService.m
//  BillCenter
//
//  Created by wujing on 2018/5/31.
//  Copyright © 2018年 Lindon. All rights reserved.
//

#import "NetworkService.h"

@implementation NetworkService

+ (NetworkService *)sharedNetworkService {
    static dispatch_once_t pred = 0;
    __strong static id _sharedNetworkService = nil;
    dispatch_once(&pred, ^{
        _sharedNetworkService = [[self alloc] init];
    });
    return _sharedNetworkService;
}

#pragma mark 普通请求
- (void)postRequestWithTarget:(UIViewController *)target
                          url:(NSString *)url
                   parameters:(id)parameters
                      showHud:(BOOL)showHud
                        block:(void (^)(id, NSError *))block {
    
    [[NetworkManager shareManager] postRequestWithTarget:(UIViewController *)target
                                                     url:url
                                              parameters:parameters
                                                 showHud:showHud
                                                   block:block];
}

- (void)getRequestWithTarget:(UIViewController *)target
                         url:(NSString *)url
                  parameters:(id)parameters
                     showHud:(BOOL)showHud
                       block:(void (^)(id, NSError *))block {
    
    [[NetworkManager shareManager] getRequestWithTarget:(UIViewController *)target
                                                    url:url
                                             parameters:parameters
                                                showHud:showHud
                                                  block:block];
}

- (void)putRequestWithTarget:(UIViewController *)target
                         url:(NSString *)url
                  parameters:(id)parameters
                     showHud:(BOOL)showHud
                       block:(void (^)(id, NSError *))block {
    
    [[NetworkManager shareManager] putRequestWithTarget:(UIViewController *)target
                                                    url:url
                                             parameters:parameters
                                                showHud:showHud
                                                  block:block];
}

#pragma mark 上传文件请求
- (void)uploadRequestWithTarget:(UIViewController *)target
                            url:(NSString *)url
                     parameters:(id)parameters
                        showHud:(BOOL)showHud
                       fileData:(NSData *)fileData
                           name:(NSString *)name
                       fileName:(NSString *)fileName
                       mimeType:(NSString *)mimeType
                          block:(void (^)(id responseObject, NSError *error))block {
    
    [[NetworkManager shareManager] uploadRequestWithTarget:(UIViewController *)target
                                                       url:url
                                                parameters:parameters
                                                   showHud:showHud
                                                  fileData:fileData
                                                      name:name
                                                  fileName:fileName
                                                  mimeType:mimeType
                                                     block:block];
}



#pragma mark 普通请求（新 添加参数hudTips、showErrMes）
- (void)postRequestWithTarget:(UIViewController *)target
                          url:(NSString *)url
                   parameters:(id)parameters
                      showHud:(BOOL)showHud
                      hudTips:(NSString *)hudTips
                   showErrMes:(BOOL)showErrMes
                        block:(void (^)(id, NSError *))block {
    
    [[NetworkManager shareManager] postRequestWithTarget:(UIViewController *)target
                                                     url:url parameters:parameters
                                                 showHud:showHud
                                                 hudTips:hudTips
                                              showErrMes:showErrMes
                                                   block:block];
}

- (void)getRequestWithTarget:(UIViewController *)target
                         url:(NSString *)url
                  parameters:(id)parameters
                     showHud:(BOOL)showHud
                     hudTips:(NSString *)hudTips
                  showErrMes:(BOOL)showErrMes
                       block:(void (^)(id, NSError *))block {
    
    [[NetworkManager shareManager] getRequestWithTarget:(UIViewController *)target
                                                    url:url
                                             parameters:parameters
                                                showHud:showHud
                                                hudTips:hudTips
                                             showErrMes:showErrMes
                                                  block:block];
}

- (void)putRequestWithTarget:(UIViewController *)target
                         url:(NSString *)url
                  parameters:(id)parameters
                     showHud:(BOOL)showHud
                     hudTips:(NSString *)hudTips
                  showErrMes:(BOOL)showErrMes
                       block:(void (^)(id, NSError *))block {
    
    [[NetworkManager shareManager] putRequestWithTarget:(UIViewController *)target
                                                    url:url
                                             parameters:parameters
                                                showHud:showHud
                                                hudTips:hudTips
                                             showErrMes:showErrMes
                                                  block:block];
}

#pragma mark 上传文件请求（新 添加参数hudTips、showErrMes）
- (void)uploadRequestWithTarget:(UIViewController *)target
                            url:(NSString *)url
                     parameters:(id)parameters
                        showHud:(BOOL)showHud
                        hudTips:(NSString *)hudTips
                     showErrMes:(BOOL)showErrMes
                       fileData:(NSData *)fileData
                           name:(NSString *)name
                       fileName:(NSString *)fileName
                       mimeType:(NSString *)mimeType
                          block:(void (^)(id responseObject, NSError *error))block {
    
    [[NetworkManager shareManager] uploadRequestWithTarget:(UIViewController *)target
                                                       url:url
                                                parameters:parameters
                                                   showHud:showHud
                                                   hudTips:hudTips
                                                showErrMes:showErrMes
                                                  fileData:fileData
                                                      name:name
                                                  fileName:fileName
                                                  mimeType:mimeType
                                                     block:block];
    
}



#pragma mark 普通请求（新 添加参数Model）
- (void)postRequestWithTarget:(UIViewController *)target
                          url:(NSString *)url
                   parameters:(id)parameters
              networkParModel:(NetworkParModel *)networkParModel
                        block:(void (^)(id responseObject, NSError *error))block {
    
    [[NetworkManager shareManager] postRequestWithTarget:target
                                                     url:url
                                              parameters:parameters
                                         networkParModel:networkParModel
                                                   block:block];
}


- (void)getRequestWithTarget:(UIViewController *)target
                         url:(NSString *)url
                  parameters:(id)parameters
             networkParModel:(NetworkParModel *)networkParModel
                       block:(void (^)(id responseObject, NSError *error))block {
    
    [[NetworkManager shareManager] getRequestWithTarget:target
                                                    url:url
                                             parameters:parameters
                                        networkParModel:networkParModel
                                                  block:block];
}


- (void)putRequestWithTarget:(UIViewController *)target
                         url:(NSString *)url
                  parameters:(id)parameters
             networkParModel:(NetworkParModel *)networkParModel
                       block:(void (^)(id responseObject, NSError *error))block {
    [[NetworkManager shareManager] putRequestWithTarget:target
                                                    url:url
                                             parameters:parameters
                                        networkParModel:networkParModel
                                                  block:block];
}

#pragma mark 上传文件请求（新 添加参数Model）
- (void)uploadRequestWithTarget:(UIViewController *)target
                            url:(NSString *)url
                     parameters:(id)parameters
                networkParModel:(NetworkParModel *)networkParModel
                          block:(void (^)(id responseObject, NSError *error))block {
    
    [[NetworkManager shareManager] uploadRequestWithTarget:target
                                                       url:url
                                                parameters:parameters
                                           networkParModel:networkParModel
                                                     block:block];
}





@end
