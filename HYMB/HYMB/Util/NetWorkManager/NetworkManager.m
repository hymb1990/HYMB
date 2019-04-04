//
//  NetworkManager.m
//  BillCenter
//
//  Created by wujing on 2018/5/31.
//  Copyright © 2018年 Lindon. All rights reserved.
//

#import "NetworkManager.h"
#import "AFNetworkActivityIndicatorManager.h"

@interface NetworkManager ()
@property (nonatomic, strong) MBProgressHUD *HUD;
@property (nonatomic, strong) NSString *hudTips;
@end

@implementation NetworkManager

+ (instancetype)shareManager {
    static dispatch_once_t pred = 0;
    __strong static id _shareManager = nil;
    dispatch_once(&pred, ^{
        NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:[NetworkManager URLCachePath]];
        [NSURLCache setSharedURLCache:URLCache];
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        _shareManager = [NetworkManager manager];
        [NetworkManager initNetworkManager:_shareManager];
        
    });
    return _shareManager;
}


+ (NSString *)URLCachePath {
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    NSArray *cacheDirectorys = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *URLCachePath = [cacheDirectorys[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/NSURLCache", bundleIdentifier]];
    return URLCachePath;
}

+ (void)initNetworkManager:(NetworkManager *)manager {
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 500;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
}


#pragma mark 普通请求
- (void)postRequestWithTarget:(UIViewController *)target
                          url:(NSString *)url
                   parameters:(id)parameters
                      showHud:(BOOL)showHud
                        block:(void (^)(id, NSError *))block {
    
    [self connectNetWorkWithTarget:target requestType:@"POST" url:url parameters:parameters showHud:showHud block:block];
}

- (void)getRequestWithTarget:(UIViewController *)target
                         url:(NSString *)url
                  parameters:(id)parameters
                     showHud:(BOOL)showHud
                       block:(void (^)(id, NSError *))block {
    
    [self connectNetWorkWithTarget:target requestType:@"GET" url:url parameters:parameters showHud:showHud block:block];
}

- (void)putRequestWithTarget:(UIViewController *)target
                         url:(NSString *)url
                  parameters:(id)parameters
                     showHud:(BOOL)showHud
                       block:(void (^)(id, NSError *))block {
    
    [self connectNetWorkWithTarget:target requestType:@"PUT" url:url parameters:parameters showHud:showHud block:block];
}

- (void)connectNetWorkWithTarget:(UIViewController *)target
                     requestType:(id)requestType
                             url:(NSString *)url
                      parameters:(id)parameters
                         showHud:(BOOL)showHud
                           block:(void (^)(id responseObject,NSError *error))block {
    
    /************************************************************************/
    //配置https证书
    if (openHttpsSSL) {
        [SSLManager openSSLCertificatesWith:[NetworkManager shareManager] requesType:@"96"];
    }
    [self.requestSerializer setValue:OpenId forHTTPHeaderField:@"openId"];
    [self.requestSerializer setValue:Secret forHTTPHeaderField:@"secret"];
    //请求头里添加token、userId
    [self.requestSerializer setValue:[Util getInfoObjectForKey:@"token"] forHTTPHeaderField:@"token"];
    [self.requestSerializer setValue:[Util getInfoObjectForKey:@"userId"] forHTTPHeaderField:@"userId"];
    
    //对于url中包含非标准url的字符时，就需要对其进行编码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    self.hudTips = @"加载中";
    /************************************************************************/
    
    
    
#pragma mark +++POST
    if([requestType isEqualToString:@"POST"]){
        
        if (showHud) {[self showHUD];}
        [self POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            /****************************控制台输出信息********************************/
            MYLog(@"token: %@", [Util getInfoObjectForKey:@"token"]);
            MYLog(@"userId: %@", [Util getInfoObjectForKey:@"userId"]);
            MYLog(@"url: %@", url);
            MYLog(@"parameters: %@", parameters);
            MYLog(@"responseObject: %@", responseObject);
            /****************************控制台输出信息********************************/
            
            /************************************************************************/
            if (showHud) {[self hideHUD];}
            if (block) {
                block(responseObject,nil);
            }
            if (![responseObject[@"code"] isEqualToString:@"OK"]) {
                if (![Util isNullWithString:responseObject[@"msg"]]) {
                    NSString *msg = responseObject[@"msg"];
                    if ([msg containsString:@"subMsg："]) {
                        NSRange range;
                        range = [msg rangeOfString:@"subMsg："];
                        range = NSMakeRange(range.location + range.length, msg.length - range.location - range.length );
                        NSString *subString = [msg substringWithRange:range];
                        [Util showMessageWithView:target.view Title:subString Image:nil HideAfter:2];
                    } else {
                        [Util showMessageWithView:target.view Title:msg Image:nil HideAfter:2];
                    }
                }
            }
            /************************************************************************/
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull  error) {
            
            
            /****************************控制台输出信息********************************/
            MYLog(@"token: %@", [Util getInfoObjectForKey:@"token"]);
            MYLog(@"userId: %@", [Util getInfoObjectForKey:@"userId"]);
            MYLog(@"url: %@", url);
            MYLog(@"parameters: %@", parameters);
            MYLog(@"Error: %@", error);
            /****************************控制台输出信息********************************/
            
            /************************************************************************/
            if (showHud) {[self hideHUD];}
            //错误请求返回的Json信息
            NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            if (data.length > 0) {
                id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if ([[NSString stringWithFormat:@"%@",body[@"code"]] isEqualToString:@"401"]) {//=401，token过期
                    [Util reLogin:target];//重新登录
                }
            }else {
                [self showErrorMessage:error];
            }
            if (block) {
                block(nil,error);
            }
            /************************************************************************/
            
        }];
    }
    
    
#pragma mark +++GET
    if ([requestType isEqualToString:@"GET"]) {
        
        if (showHud) {[self showHUD];}
        [self GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            /****************************控制台输出信息********************************/
            MYLog(@"token: %@", [Util getInfoObjectForKey:@"token"]);
            MYLog(@"userId: %@", [Util getInfoObjectForKey:@"userId"]);
            MYLog(@"url: %@", url);
            MYLog(@"parameters: %@", parameters);
            MYLog(@"responseObject: %@", responseObject);
            /****************************控制台输出信息********************************/
            
            /************************************************************************/
            if (showHud) {[self hideHUD];}
            if (block) {
                block(responseObject,nil);
            }
#pragma mark ***
            NSString *code = [NSString stringWithFormat:@"%@", responseObject[@"code"]];
            if (![code isEqualToString:@"OK"]) {
                if (![Util isNullWithString:responseObject[@"msg"]]) {
                    NSString *msg = responseObject[@"msg"];
                    if ([msg containsString:@"subMsg："]) {
                        NSRange range;
                        range = [msg rangeOfString:@"subMsg："];
                        range = NSMakeRange(range.location + range.length, msg.length - range.location - range.length );
                        NSString *subString = [msg substringWithRange:range];
                        [Util showMessageWithView:target.view Title:subString Image:nil HideAfter:2];
                    } else {
                        [Util showMessageWithView:target.view Title:msg Image:nil HideAfter:2];
                    }
                }
            }
            /************************************************************************/
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            /****************************控制台输出信息********************************/
            MYLog(@"token: %@", [Util getInfoObjectForKey:@"token"]);
            MYLog(@"userId: %@", [Util getInfoObjectForKey:@"userId"]);
            MYLog(@"url: %@", url);
            MYLog(@"parameters: %@", parameters);
            MYLog(@"Error: %@", error);
            /****************************控制台输出信息********************************/
            
            /************************************************************************/
            if (showHud) {[self hideHUD];}
            //错误请求返回的Json信息
            NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            if (data.length > 0) {
                id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if ([[NSString stringWithFormat:@"%@",body[@"code"]] isEqualToString:@"401"]) {//=401，token过期
                    [Util reLogin:target];//重新登录
                }
            }else {
                [self showErrorMessage:error];
            }
            if (block) {
                block(nil,error);
            }
            /************************************************************************/
            
        }];
    }
    
    
#pragma mark +++PUT
    if ([requestType isEqualToString:@"PUT"]) {
        
        if (showHud) {[self showHUD];}
        [self PUT:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            /****************************控制台输出信息********************************/
            MYLog(@"token: %@", [Util getInfoObjectForKey:@"token"]);
            MYLog(@"userId: %@", [Util getInfoObjectForKey:@"userId"]);
            MYLog(@"url: %@", url);
            MYLog(@"parameters: %@", parameters);
            MYLog(@"responseObject: %@", responseObject);
            /****************************控制台输出信息********************************/
            
            /************************************************************************/
            if (showHud) {[self hideHUD];}
            if (block) {
                block(responseObject,nil);
            }
            if (![responseObject[@"code"] isEqualToString:@"OK"]) {
                if (![Util isNullWithString:responseObject[@"msg"]]) {
                    NSString *msg = responseObject[@"msg"];
                    if ([msg containsString:@"subMsg："]) {
                        NSRange range;
                        range = [msg rangeOfString:@"subMsg："];
                        range = NSMakeRange(range.location + range.length, msg.length - range.location - range.length );
                        NSString *subString = [msg substringWithRange:range];
                        [Util showMessageWithView:target.view Title:subString Image:nil HideAfter:2];
                    } else {
                        [Util showMessageWithView:target.view Title:msg Image:nil HideAfter:2];
                    }
                }
            }
            /************************************************************************/
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            /****************************控制台输出信息********************************/
            MYLog(@"token: %@", [Util getInfoObjectForKey:@"token"]);
            MYLog(@"userId: %@", [Util getInfoObjectForKey:@"userId"]);
            MYLog(@"url: %@", url);
            MYLog(@"parameters: %@", parameters);
            MYLog(@"Error: %@", error);
            /****************************控制台输出信息********************************/
            
            /************************************************************************/
            if (showHud) {[self hideHUD];}
            //错误请求返回的Json信息
            NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            if (data.length > 0) {
                id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if ([[NSString stringWithFormat:@"%@",body[@"code"]] isEqualToString:@"401"]) {//=401，token过期
                    [Util reLogin:target];//重新登录
                }
            }else {
                [self showErrorMessage:error];
            }
            if (block) {
                block(nil,error);
            }
            /************************************************************************/
        }];
    }
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
    
    [self uploadConnectNetWorkWithTarget:target url:url parameters:parameters showHud:showHud fileData:fileData name:name fileName:fileName mimeType:mimeType block:block];
    
}


- (void)uploadConnectNetWorkWithTarget:(UIViewController *)target
                                   url:(NSString *)url
                            parameters:(id)parameters
                               showHud:(BOOL)showHud
                              fileData:(NSData *)fileData
                                  name:(NSString *)name
                              fileName:(NSString *)fileName
                              mimeType:(NSString *)mimeType
                                 block:(void (^)(id responseObject, NSError *error))block {
    
    /************************************************************************/
    //配置https证书
    if (openHttpsSSL) {
        [SSLManager openSSLCertificatesWith:[NetworkManager shareManager] requesType:@"51"];
    }
    [self.requestSerializer setValue:OpenId_Img forHTTPHeaderField:@"openId"];
    [self.requestSerializer setValue:Secret_Img forHTTPHeaderField:@"secret"];
    //请求头里添加token、userId
    [self.requestSerializer setValue:[Util getInfoObjectForKey:@"token"] forHTTPHeaderField:@"token"];
    [self.requestSerializer setValue:[Util getInfoObjectForKey:@"userId"] forHTTPHeaderField:@"userId"];
    
    //对于url中包含非标准url的字符时，就需要对其进行编码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    if (showHud) {[self showHUD];}
    /************************************************************************/
    
    
    
    [self POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:mimeType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        /****************************控制台输出信息********************************/
        MYLog(@"token: %@", [Util getInfoObjectForKey:@"token"]);
        MYLog(@"userId: %@", [Util getInfoObjectForKey:@"userId"]);
        MYLog(@"url: %@", url);
        MYLog(@"parameters: %@", parameters);
        MYLog(@"responseObject: %@", responseObject);
        /****************************控制台输出信息********************************/
        
        
        /************************************************************************/
        if (showHud) {[self hideHUD];}
        if (block) {
            block(responseObject,nil);
        }
        if (![responseObject[@"code"] isEqualToString:@"OK"]) {
            if (![Util isNullWithString:responseObject[@"msg"]]) {
                    NSString *msg = responseObject[@"msg"];
                    if ([msg containsString:@"subMsg："]) {
                        NSRange range;
                        range = [msg rangeOfString:@"subMsg："];
                        range = NSMakeRange(range.location + range.length, msg.length - range.location - range.length );
                        
                        NSString *subString = [msg substringWithRange:range];
                        [Util showMessageWithView:target.view Title:subString Image:nil HideAfter:2];
                    } else {
                        [Util showMessageWithView:target.view Title:msg Image:nil HideAfter:2];
                    }
            }
        }
        /************************************************************************/
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        /****************************控制台输出信息********************************/
        MYLog(@"token: %@", [Util getInfoObjectForKey:@"token"]);
        MYLog(@"userId: %@", [Util getInfoObjectForKey:@"userId"]);
        MYLog(@"url: %@", url);
        MYLog(@"parameters: %@", parameters);
        MYLog(@"error: %@", error);
        /****************************控制台输出信息********************************/
        
        
        /************************************************************************/
        if (showHud) {[self hideHUD];}
        //错误请求返回的Json信息
        NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        if (data.length > 0) {
            id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([[NSString stringWithFormat:@"%@",body[@"code"]] isEqualToString:@"401"]) {//=401，token过期
                [Util reLogin:target];//重新登录
            }
        }else {
            [self showErrorMessage:error];
        }
        if (block) {
            block(nil,error);
        }
        /************************************************************************/
        
    }];
}



#pragma mark 普通请求（新 添加参数hudTips、showErrMes）

- (void)postRequestWithTarget:(UIViewController *)target
                          url:(NSString *)url
                   parameters:(id)parameters
                      showHud:(BOOL)showHud
                      hudTips:(NSString *)hudTips
                   showErrMes:(BOOL)showErrMes
                        block:(void (^)(id responseObject, NSError *error))block {
    
    [self connectNetWorkWithTarget:target requestType:@"POST" url:url parameters:parameters showHud:showHud hudTips:hudTips showErrMes:showErrMes block:block];
}

- (void)getRequestWithTarget:(UIViewController *)target
                         url:(NSString *)url
                  parameters:(id)parameters
                     showHud:(BOOL)showHud
                     hudTips:(NSString *)hudTips
                  showErrMes:(BOOL)showErrMes
                       block:(void (^)(id responseObject, NSError *error))block {
    
 [self connectNetWorkWithTarget:target requestType:@"GET" url:url parameters:parameters showHud:showHud hudTips:hudTips showErrMes:showErrMes block:block];
}

- (void)putRequestWithTarget:(UIViewController *)target
                         url:(NSString *)url
                  parameters:(id)parameters
                     showHud:(BOOL)showHud
                     hudTips:(NSString *)hudTips
                  showErrMes:(BOOL)showErrMes
                       block:(void (^)(id responseObject, NSError *error))block {

    [self connectNetWorkWithTarget:target requestType:@"PUT" url:url parameters:parameters showHud:showHud hudTips:hudTips showErrMes:showErrMes block:block];
}

- (void)connectNetWorkWithTarget:(UIViewController *)target
                     requestType:(id)requestType
                             url:(NSString *)url
                      parameters:(id)parameters
                         showHud:(BOOL)showHud
                         hudTips:(NSString *)hudTips
                      showErrMes:(BOOL)showErrMes
                           block:(void (^)(id responseObject, NSError *error))block {
    
    /************************************************************************/
    //配置https证书
    if (openHttpsSSL) {
        [SSLManager openSSLCertificatesWith:[NetworkManager shareManager] requesType:@"96"];
    }
    [self.requestSerializer setValue:OpenId forHTTPHeaderField:@"openId"];
    [self.requestSerializer setValue:Secret forHTTPHeaderField:@"secret"];
    //请求头里添加token、userId
    [self.requestSerializer setValue:[Util getInfoObjectForKey:@"token"] forHTTPHeaderField:@"token"];
    [self.requestSerializer setValue:[Util getInfoObjectForKey:@"userId"] forHTTPHeaderField:@"userId"];
    
    //对于url中包含非标准url的字符时，就需要对其进行编码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    //菊花提示语
    self.hudTips = hudTips;
    /************************************************************************/
    
    
#pragma mark +++POST
    if([requestType isEqualToString:@"POST"]){
        
        if (showHud) {[self showHUD];}
        [self POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            /****************************控制台输出信息********************************/
            MYLog(@"token: %@", [Util getInfoObjectForKey:@"token"]);
            MYLog(@"userId: %@", [Util getInfoObjectForKey:@"userId"]);
            MYLog(@"url: %@", url);
            MYLog(@"parameters: %@", parameters);
            MYLog(@"responseObject: %@", responseObject);
            /****************************控制台输出信息********************************/
            
            
            /************************************************************************/
            if (showHud) {[self hideHUD];}
            if (block) {
                block(responseObject,nil);
            }
            if (![responseObject[@"code"] isEqualToString:@"OK"]) {
                if (![Util isNullWithString:responseObject[@"msg"]]) {
                    if (showErrMes) {
                        NSString *msg = responseObject[@"msg"];
                        if ([msg containsString:@"subMsg："]) {
                            NSRange range;
                            range = [msg rangeOfString:@"subMsg："];
                            range = NSMakeRange(range.location + range.length, msg.length - range.location - range.length );
                            NSString *subString = [msg substringWithRange:range];
                            [Util showMessageWithView:target.view Title:subString Image:nil HideAfter:2];
                        } else {
                            [Util showMessageWithView:target.view Title:msg Image:nil HideAfter:2];
                        }
                    }
                }
            }
            /************************************************************************/
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull  error) {
            
            /****************************控制台输出信息********************************/
            MYLog(@"token: %@", [Util getInfoObjectForKey:@"token"]);
            MYLog(@"userId: %@", [Util getInfoObjectForKey:@"userId"]);
            MYLog(@"url: %@", url);
            MYLog(@"parameters: %@", parameters);
            MYLog(@"error: %@", error);
            /****************************控制台输出信息********************************/
            
            
            /************************************************************************/
            if (showHud) {[self hideHUD];}
            //错误请求返回的Json信息
            NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            if (data.length > 0) {
                id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if ([[NSString stringWithFormat:@"%@",body[@"code"]] isEqualToString:@"401"]) {//=401，token过期
                    [Util reLogin:target];//重新登录
                }
            }else {
                [self showErrorMessage:error];
            }
            if (block) {
                block(nil,error);
            }
            /************************************************************************/
            
        }];
    }
    
    
#pragma mark +++GET
    if ([requestType isEqualToString:@"GET"]) {
        
        if (showHud) {[self showHUD];}
        [self GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            /****************************控制台输出信息********************************/
            MYLog(@"token: %@", [Util getInfoObjectForKey:@"token"]);
            MYLog(@"userId: %@", [Util getInfoObjectForKey:@"userId"]);
            MYLog(@"url: %@", url);
            MYLog(@"parameters: %@", parameters);
            MYLog(@"responseObject: %@", responseObject);
            /****************************控制台输出信息********************************/
            
            
            /************************************************************************/
            if (showHud) {[self hideHUD];}
            if (block) {
                block(responseObject,nil);
            }
            if (![responseObject[@"code"] isEqualToString:@"OK"]) {
                if (![Util isNullWithString:responseObject[@"msg"]]) {
                    if (showErrMes) {
                        NSString *msg = responseObject[@"msg"];
                        if ([msg containsString:@"subMsg："]) {
                            NSRange range;
                            range = [msg rangeOfString:@"subMsg："];
                            range = NSMakeRange(range.location + range.length, msg.length - range.location - range.length );
                            NSString *subString = [msg substringWithRange:range];
                            [Util showMessageWithView:target.view Title:subString Image:nil HideAfter:2];
                        } else {
                            [Util showMessageWithView:target.view Title:msg Image:nil HideAfter:2];
                        }
                    }
                }
            }
            /************************************************************************/
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            /****************************控制台输出信息********************************/
            MYLog(@"token: %@", [Util getInfoObjectForKey:@"token"]);
            MYLog(@"userId: %@", [Util getInfoObjectForKey:@"userId"]);
            MYLog(@"url: %@", url);
            MYLog(@"parameters: %@", parameters);
            MYLog(@"error: %@", error);
            /****************************控制台输出信息********************************/
            
            
            /************************************************************************/
            if (showHud) {[self hideHUD];}
            //错误请求返回的Json信息
            NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            if (data.length > 0) {
                id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if ([[NSString stringWithFormat:@"%@",body[@"code"]] isEqualToString:@"401"]) {//=401，token过期
                    [Util reLogin:target];//重新登录
                }
            }else {
                [self showErrorMessage:error];
            }
            if (block) {
                block(nil,error);
            }
            /************************************************************************/
            
        }];
    }
    
    
#pragma mark +++PUT
    if ([requestType isEqualToString:@"PUT"]) {
        
        if (showHud) {[self showHUD];}
        [self PUT:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            /****************************控制台输出信息********************************/
            MYLog(@"token: %@", [Util getInfoObjectForKey:@"token"]);
            MYLog(@"userId: %@", [Util getInfoObjectForKey:@"userId"]);
            MYLog(@"url: %@", url);
            MYLog(@"parameters: %@", parameters);
            MYLog(@"responseObject: %@", responseObject);
            /****************************控制台输出信息********************************/
            
            
            /************************************************************************/
            if (showHud) {[self hideHUD];}
            if (block) {
                block(responseObject,nil);
            }
            if (![responseObject[@"code"] isEqualToString:@"OK"]) {
                if (![Util isNullWithString:responseObject[@"msg"]]) {
                    if (showErrMes) {
                        NSString *msg = responseObject[@"msg"];
                        if ([msg containsString:@"subMsg："]) {
                            NSRange range;
                            range = [msg rangeOfString:@"subMsg："];
                            range = NSMakeRange(range.location + range.length, msg.length - range.location - range.length );
                            NSString *subString = [msg substringWithRange:range];
                            [Util showMessageWithView:target.view Title:subString Image:nil HideAfter:2];
                        } else {
                            [Util showMessageWithView:target.view Title:msg Image:nil HideAfter:2];
                        }
                    }
                }
            }
            /************************************************************************/
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            /****************************控制台输出信息********************************/
            MYLog(@"token: %@", [Util getInfoObjectForKey:@"token"]);
            MYLog(@"userId: %@", [Util getInfoObjectForKey:@"userId"]);
            MYLog(@"url: %@", url);
            MYLog(@"parameters: %@", parameters);
            MYLog(@"error: %@", error);
            /****************************控制台输出信息********************************/
            
            
            /************************************************************************/
            if (showHud) {[self hideHUD];}
            //错误请求返回的Json信息
            NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            if (data.length > 0) {
                id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if ([[NSString stringWithFormat:@"%@",body[@"code"]] isEqualToString:@"401"]) {//=401，token过期
                    [Util reLogin:target];//重新登录
                }
            }else {
                [self showErrorMessage:error];
            }
            if (block) {
                block(nil,error);
            }
            /************************************************************************/
            
        }];
    }
    
    
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
    
[self uploadConnectNetWorkWithTarget:target url:url parameters:parameters showHud:showHud hudTips:hudTips showErrMes:showErrMes fileData:fileData name:name fileName:fileName mimeType:mimeType block:block];
    
}


- (void)uploadConnectNetWorkWithTarget:(UIViewController *)target
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
    
    /************************************************************************/
    //配置https证书
    if (openHttpsSSL) {
        [SSLManager openSSLCertificatesWith:[NetworkManager shareManager] requesType:@"51"];
    }
    [self.requestSerializer setValue:OpenId_Img forHTTPHeaderField:@"openId"];
    [self.requestSerializer setValue:Secret_Img forHTTPHeaderField:@"secret"];
    //请求头里添加token、userId
    [self.requestSerializer setValue:[Util getInfoObjectForKey:@"token"] forHTTPHeaderField:@"token"];
    [self.requestSerializer setValue:[Util getInfoObjectForKey:@"userId"] forHTTPHeaderField:@"userId"];
    
    //对于url中包含非标准url的字符时，就需要对其进行编码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    //菊花提示语
    self.hudTips = hudTips;
    if (showHud) {[self showHUD];}
    /************************************************************************/
    
    
    
    [self POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:mimeType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        /****************************控制台输出信息********************************/
        MYLog(@"token: %@", [Util getInfoObjectForKey:@"token"]);
        MYLog(@"userId: %@", [Util getInfoObjectForKey:@"userId"]);
        MYLog(@"url: %@", url);
        MYLog(@"parameters: %@", parameters);
        MYLog(@"responseObject: %@", responseObject);
        /****************************控制台输出信息********************************/
        
        
        /************************************************************************/
        if (showHud) {[self hideHUD];}
        if (block) {
            block(responseObject,nil);
        }
        if (![responseObject[@"code"] isEqualToString:@"OK"]) {
            if (![Util isNullWithString:responseObject[@"msg"]]) {
                if (showErrMes) {
                    NSString *msg = responseObject[@"msg"];
                    if ([msg containsString:@"subMsg："]) {
                        NSRange range;
                        range = [msg rangeOfString:@"subMsg："];
                        range = NSMakeRange(range.location + range.length, msg.length - range.location - range.length );
                        
                        NSString *subString = [msg substringWithRange:range];
                        [Util showMessageWithView:target.view Title:subString Image:nil HideAfter:2];
                    } else {
                        [Util showMessageWithView:target.view Title:msg Image:nil HideAfter:2];
                    }
                }
            }
        }
        /************************************************************************/
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        /****************************控制台输出信息********************************/
        MYLog(@"token: %@", [Util getInfoObjectForKey:@"token"]);
        MYLog(@"userId: %@", [Util getInfoObjectForKey:@"userId"]);
        MYLog(@"url: %@", url);
        MYLog(@"parameters: %@", parameters);
        MYLog(@"error: %@", error);
        /****************************控制台输出信息********************************/
        
        
        /************************************************************************/
        if (showHud) {[self hideHUD];}
        //错误请求返回的Json信息
        NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        if (data.length > 0) {
            id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([[NSString stringWithFormat:@"%@",body[@"code"]] isEqualToString:@"401"]) {//=401，token过期
                [Util reLogin:target];//重新登录
            }
        }else {
            [self showErrorMessage:error];
        }
        if (block) {
            block(nil,error);
        }
        /************************************************************************/
        
    }];
}















#pragma mark 普通请求（新 添加参数Model）

- (void)postRequestWithTarget:(UIViewController *)target
                          url:(NSString *)url
                   parameters:(id)parameters
              networkParModel:(NetworkParModel *)networkParModel
                        block:(void (^)(id responseObject, NSError *error))block {
    
    [self connectNetWorkWithTarget:target requestType:@"POST" url:url parameters:parameters networkParModel:networkParModel  block:block];
}

- (void)getRequestWithTarget:(UIViewController *)target
                         url:(NSString *)url
                  parameters:(id)parameters
             networkParModel:(NetworkParModel *)networkParModel
                       block:(void (^)(id responseObject, NSError *error))block {
    
    [self connectNetWorkWithTarget:target requestType:@"GET" url:url parameters:parameters networkParModel:networkParModel  block:block];
}

- (void)putRequestWithTarget:(UIViewController *)target
                         url:(NSString *)url
                  parameters:(id)parameters
             networkParModel:(NetworkParModel *)networkParModel
                       block:(void (^)(id responseObject, NSError *error))block {
    
    [self connectNetWorkWithTarget:target requestType:@"PUT" url:url parameters:parameters networkParModel:networkParModel  block:block];
}

- (void)connectNetWorkWithTarget:(UIViewController *)target
                     requestType:(id)requestType
                             url:(NSString *)url
                      parameters:(id)parameters
                 networkParModel:(NetworkParModel *)networkParModel
                           block:(void (^)(id responseObject, NSError *error))block {
    
    /************************************************************************/
    //配置https证书
    if (openHttpsSSL) {
        [SSLManager openSSLCertificatesWith:[NetworkManager shareManager] requesType:@"96"];
    }
    [self.requestSerializer setValue:OpenId forHTTPHeaderField:@"openId"];
    [self.requestSerializer setValue:Secret forHTTPHeaderField:@"secret"];
    //请求头里添加token、userId
    [self.requestSerializer setValue:[Util getInfoObjectForKey:@"token"] forHTTPHeaderField:@"token"];
    [self.requestSerializer setValue:[Util getInfoObjectForKey:@"userId"] forHTTPHeaderField:@"userId"];
    
    //对于url中包含非标准url的字符时，就需要对其进行编码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    //菊花提示语
    self.hudTips = networkParModel.hudTips;
    /************************************************************************/
    
    
#pragma mark +++POST
    if([requestType isEqualToString:@"POST"]){
        
        if (networkParModel.showHud) {[self showHUD];}
        [self POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            /****************************控制台输出信息********************************/
            MYLog(@"token: %@", [Util getInfoObjectForKey:@"token"]);
            MYLog(@"userId: %@", [Util getInfoObjectForKey:@"userId"]);
            MYLog(@"url: %@", url);
            MYLog(@"parameters: %@", parameters);
            MYLog(@"responseObject: %@", responseObject);
            /****************************控制台输出信息********************************/
            
            
            /************************************************************************/
            if (networkParModel.showHud) {[self hideHUD];}
            if (block) {
                block(responseObject,nil);
            }
            if (![responseObject[@"code"] isEqualToString:@"OK"]) {
                if (![Util isNullWithString:responseObject[@"msg"]]) {
                    if (networkParModel.showErrMes) {
                        NSString *msg = responseObject[@"msg"];
                        if ([msg containsString:@"subMsg："]) {
                            NSRange range;
                            range = [msg rangeOfString:@"subMsg："];
                            range = NSMakeRange(range.location + range.length, msg.length - range.location - range.length );
                            NSString *subString = [msg substringWithRange:range];
                            [Util showMessageWithView:target.view Title:subString Image:nil HideAfter:2];
                        } else {
                            [Util showMessageWithView:target.view Title:msg Image:nil HideAfter:2];
                        }
                    }
                }
            }
            /************************************************************************/
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull  error) {
            
            /****************************控制台输出信息********************************/
            MYLog(@"token: %@", [Util getInfoObjectForKey:@"token"]);
            MYLog(@"userId: %@", [Util getInfoObjectForKey:@"userId"]);
            MYLog(@"url: %@", url);
            MYLog(@"parameters: %@", parameters);
            MYLog(@"error: %@", error);
            /****************************控制台输出信息********************************/
            
            
            /************************************************************************/
            if (networkParModel.showHud) {[self hideHUD];}
            //错误请求返回的Json信息
            NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            if (data.length > 0) {
                id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if ([[NSString stringWithFormat:@"%@",body[@"code"]] isEqualToString:@"401"]) {//=401，token过期
                    [Util reLogin:target];//重新登录
                }
            }else {
                [self showErrorMessage:error];
            }
            if (block) {
                block(nil,error);
            }
            /************************************************************************/
            
        }];
    }
    
    
#pragma mark +++GET
    if ([requestType isEqualToString:@"GET"]) {
        
        if (networkParModel.showHud) {[self showHUD];}
        [self GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            /****************************控制台输出信息********************************/
            MYLog(@"token: %@", [Util getInfoObjectForKey:@"token"]);
            MYLog(@"userId: %@", [Util getInfoObjectForKey:@"userId"]);
            MYLog(@"url: %@", url);
            MYLog(@"parameters: %@", parameters);
            MYLog(@"responseObject: %@", responseObject);
            /****************************控制台输出信息********************************/
            
            
            /************************************************************************/
            if (networkParModel.showHud) {[self hideHUD];}
            if (block) {
                block(responseObject,nil);
            }
            if (![responseObject[@"code"] isEqualToString:@"OK"]) {
                if (![Util isNullWithString:responseObject[@"msg"]]) {
                    if (networkParModel.showErrMes) {
                        NSString *msg = responseObject[@"msg"];
                        if ([msg containsString:@"subMsg："]) {
                            NSRange range;
                            range = [msg rangeOfString:@"subMsg："];
                            range = NSMakeRange(range.location + range.length, msg.length - range.location - range.length );
                            NSString *subString = [msg substringWithRange:range];
                            [Util showMessageWithView:target.view Title:subString Image:nil HideAfter:2];
                        } else {
                            [Util showMessageWithView:target.view Title:msg Image:nil HideAfter:2];
                        }
                    }
                }
            }
            /************************************************************************/
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            /****************************控制台输出信息********************************/
            MYLog(@"token: %@", [Util getInfoObjectForKey:@"token"]);
            MYLog(@"userId: %@", [Util getInfoObjectForKey:@"userId"]);
            MYLog(@"url: %@", url);
            MYLog(@"parameters: %@", parameters);
            MYLog(@"error: %@", error);
            /****************************控制台输出信息********************************/
            
            
            /************************************************************************/
            if (networkParModel.showHud) {[self hideHUD];}
            //错误请求返回的Json信息
            NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            if (data.length > 0) {
                id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if ([[NSString stringWithFormat:@"%@",body[@"code"]] isEqualToString:@"401"]) {//=401，token过期
                    [Util reLogin:target];//重新登录
                }
            }else {
                [self showErrorMessage:error];
            }
            if (block) {
                block(nil,error);
            }
            /************************************************************************/
            
        }];
    }
    
    
#pragma mark +++PUT
    if ([requestType isEqualToString:@"PUT"]) {
        
        if (networkParModel.showHud) {[self showHUD];}
        [self PUT:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            /****************************控制台输出信息********************************/
            MYLog(@"token: %@", [Util getInfoObjectForKey:@"token"]);
            MYLog(@"userId: %@", [Util getInfoObjectForKey:@"userId"]);
            MYLog(@"url: %@", url);
            MYLog(@"parameters: %@", parameters);
            MYLog(@"responseObject: %@", responseObject);
            /****************************控制台输出信息********************************/
            
            
            /************************************************************************/
            if (networkParModel.showHud) {[self hideHUD];}
            if (block) {
                block(responseObject,nil);
            }
            if (![responseObject[@"code"] isEqualToString:@"OK"]) {
                if (![Util isNullWithString:responseObject[@"msg"]]) {
                    if (networkParModel.showErrMes) {
                        NSString *msg = responseObject[@"msg"];
                        if ([msg containsString:@"subMsg："]) {
                            NSRange range;
                            range = [msg rangeOfString:@"subMsg："];
                            range = NSMakeRange(range.location + range.length, msg.length - range.location - range.length );
                            NSString *subString = [msg substringWithRange:range];
                            [Util showMessageWithView:target.view Title:subString Image:nil HideAfter:2];
                        } else {
                            [Util showMessageWithView:target.view Title:msg Image:nil HideAfter:2];
                        }
                    }
                }
            }
            /************************************************************************/
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            /****************************控制台输出信息********************************/
            MYLog(@"token: %@", [Util getInfoObjectForKey:@"token"]);
            MYLog(@"userId: %@", [Util getInfoObjectForKey:@"userId"]);
            MYLog(@"url: %@", url);
            MYLog(@"parameters: %@", parameters);
            MYLog(@"error: %@", error);
            /****************************控制台输出信息********************************/
            
            
            /************************************************************************/
            if (networkParModel.showHud) {[self hideHUD];}
            //错误请求返回的Json信息
            NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            if (data.length > 0) {
                id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if ([[NSString stringWithFormat:@"%@",body[@"code"]] isEqualToString:@"401"]) {//=401，token过期
                    [Util reLogin:target];//重新登录
                }
            }else {
                [self showErrorMessage:error];
            }
            if (block) {
                block(nil,error);
            }
            /************************************************************************/
            
        }];
    }
    
    
}




#pragma mark 上传文件请求 （新 添加参数Model）
- (void)uploadRequestWithTarget:(UIViewController *)target
                            url:(NSString *)url
                     parameters:(id)parameters
                networkParModel:(NetworkParModel *)networkParModel
                          block:(void (^)(id responseObject, NSError *error))block {
    
    [self uploadConnectNetWorkWithTarget:target url:url parameters:parameters networkParModel:networkParModel block:block];
    
}


- (void)uploadConnectNetWorkWithTarget:(UIViewController *)target
                                   url:(NSString *)url
                            parameters:(id)parameters
                       networkParModel:(NetworkParModel *)networkParModel
                                 block:(void (^)(id responseObject, NSError *error))block {
    
    /************************************************************************/
    //配置https证书
    if (openHttpsSSL) {
        [SSLManager openSSLCertificatesWith:[NetworkManager shareManager] requesType:@"51"];
    }
    [self.requestSerializer setValue:OpenId_Img forHTTPHeaderField:@"openId"];
    [self.requestSerializer setValue:Secret_Img forHTTPHeaderField:@"secret"];
    //请求头里添加token、userId
    [self.requestSerializer setValue:[Util getInfoObjectForKey:@"token"] forHTTPHeaderField:@"token"];
    [self.requestSerializer setValue:[Util getInfoObjectForKey:@"userId"] forHTTPHeaderField:@"userId"];
    
    //对于url中包含非标准url的字符时，就需要对其进行编码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    //菊花提示语
    self.hudTips = networkParModel.hudTips;
    if (networkParModel.showHud) {[self showHUD];}
    /************************************************************************/
    
    
    
    [self POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:networkParModel.fileData name:networkParModel.name fileName:networkParModel.fileName mimeType:networkParModel.mimeType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        /****************************控制台输出信息********************************/
        MYLog(@"token: %@", [Util getInfoObjectForKey:@"token"]);
        MYLog(@"userId: %@", [Util getInfoObjectForKey:@"userId"]);
        MYLog(@"url: %@", url);
        MYLog(@"parameters: %@", parameters);
        MYLog(@"responseObject: %@", responseObject);
        /****************************控制台输出信息********************************/
        
        
        /************************************************************************/
        if (networkParModel.showHud) {[self hideHUD];}
        if (block) {
            block(responseObject,nil);
        }
        if (![responseObject[@"code"] isEqualToString:@"OK"]) {
            if (![Util isNullWithString:responseObject[@"msg"]]) {
                if (networkParModel.showErrMes) {
                    NSString *msg = responseObject[@"msg"];
                    if ([msg containsString:@"subMsg："]) {
                        NSRange range;
                        range = [msg rangeOfString:@"subMsg："];
                        range = NSMakeRange(range.location + range.length, msg.length - range.location - range.length );
                        
                        NSString *subString = [msg substringWithRange:range];
                        [Util showMessageWithView:target.view Title:subString Image:nil HideAfter:2];
                    } else {
                        [Util showMessageWithView:target.view Title:msg Image:nil HideAfter:2];
                    }
                }
            }
        }
        /************************************************************************/
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        /****************************控制台输出信息********************************/
        MYLog(@"token: %@", [Util getInfoObjectForKey:@"token"]);
        MYLog(@"userId: %@", [Util getInfoObjectForKey:@"userId"]);
        MYLog(@"url: %@", url);
        MYLog(@"parameters: %@", parameters);
        MYLog(@"error: %@", error);
        /****************************控制台输出信息********************************/
        
        
        /************************************************************************/
        if (networkParModel.showHud) {[self hideHUD];}
        //错误请求返回的Json信息
        NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        if (data.length > 0) {
            id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([[NSString stringWithFormat:@"%@",body[@"code"]] isEqualToString:@"401"]) {//=401，token过期
                [Util reLogin:target];//重新登录
            }
        }else {
            [self showErrorMessage:error];
        }
        if (block) {
            block(nil,error);
        }
        /************************************************************************/
        
    }];
}










- (void)showErrorMessage:(NSError *)error {
    
    if (error.code == -1001) {  //timeout错误
        [Util showMessageWithView:[Util getCurrentVC].view Title:@"网络不佳，请稍后重试" Image:nil HideAfter:2];
    }
    
    if (error.code == -1009) {  //Error Domain=NSURLErrorDomain Code=-1009 "似乎已断开与互联网的连接。"
        [Util showMessageWithView:[Util getCurrentVC].view Title:@"网络已断开" Image:nil HideAfter:2];
    }
    
    if (error.code == -1011) {  //
        [Util showMessageWithView:[Util getCurrentVC].view Title:@"网络请求错误" Image:nil HideAfter:2];
    }
}

- (MBProgressHUD *)HUD {
    if (_HUD == nil) {
        UIWindow *window =  [[[UIApplication sharedApplication] delegate] window];
        _HUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
        _HUD.mode = MBProgressHUDModeIndeterminate;
        _HUD.contentColor  = [UIColor whiteColor];
        _HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        _HUD.bezelView.backgroundColor = [UIColor blackColor];
        _HUD.detailsLabel.text = self.hudTips;
        _HUD.detailsLabel.textColor = [UIColor whiteColor];
        _HUD.detailsLabel.font = [UIFont systemFontOfSize:18];
    }
    return _HUD;
}

- (void)showHUD {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.HUD.bezelView.alpha = 0.7;
    });
}

- (void)hideHUD {
    if (_HUD) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_HUD hideAnimated:YES];
            [_HUD removeFromSuperview];
            _HUD = nil;
        });
    }
}



@end
