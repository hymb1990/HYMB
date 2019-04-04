//
//  NetworkManager.h
//  BillCenter
//
//  Created by wujing on 2018/5/31.
//  Copyright © 2018年 Lindon. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface NetworkManager : AFHTTPSessionManager

+ (instancetype)shareManager;

#pragma mark 普通请求
/**
 POST请求
 
 @param target 当前控制器
 @param url 请求地址
 @param parameters 请求参数字典
 @param showHud 是否显示菊花转圈
 @param block 返回信息
 */
- (void)postRequestWithTarget:(UIViewController *)target
                          url:(NSString *)url
                   parameters:(id)parameters
                      showHud:(BOOL)showHud
                        block:(void (^)(id responseObject,NSError *error))block;

/**
 GET请求
 
 @param target 当前控制器
 @param url 请求地址
 @param parameters 请求参数字典
 @param showHud 是否显示菊花转圈
 @param block 返回信息
 */
- (void)getRequestWithTarget:(UIViewController *)target
                         url:(NSString *)url
                  parameters:(id)parameters
                     showHud:(BOOL)showHud
                       block:(void (^)(id responseObject,NSError *error))block;


/**
 PUT请求
 
 @param target 当前控制器
 @param url 请求地址
 @param parameters 请求参数字典
 @param showHud 是否显示菊花转圈
 @param block 返回信息
 */
- (void)putRequestWithTarget:(UIViewController *)target
                         url:(NSString *)url
                  parameters:(id)parameters
                     showHud:(BOOL)showHud
                       block:(void (^)(id responseObject,NSError *error))block;


#pragma mark 上传文件请求
/**
 上传文件请求
 
 @param target 当前控制器
 @param url 请求地址
 @param parameters 请求参数字典
 @param showHud 是否显示菊花转圈
 @param fileData 文件数据
 @param name 文件夹名称
 @param mimeType 文件类型
 @param block 返回信息
 */
- (void)uploadRequestWithTarget:(UIViewController *)target
                            url:(NSString *)url
                     parameters:(id)parameters
                        showHud:(BOOL)showHud
                       fileData:(NSData *)fileData
                           name:(NSString *)name
                       fileName:(NSString *)fileName
                       mimeType:(NSString *)mimeType
                          block:(void (^)(id responseObject, NSError *error))block;



#pragma mark 普通请求（新 添加参数hudTips、showErrMes）
/**
 POST请求
 
 @param target 当前控制器
 @param url 请求地址
 @param parameters 请求参数字典
 @param showHud 是否显示菊花转圈
 @param hudTips 菊花框提示语
 @param showErrMes 是否展示（请求中Code=Err时）返回的ErrMessage
 @param block 返回信息
 */
- (void)postRequestWithTarget:(UIViewController *)target
                          url:(NSString *)url
                   parameters:(id)parameters
                      showHud:(BOOL)showHud
                      hudTips:(NSString *)hudTips
                   showErrMes:(BOOL)showErrMes
                        block:(void (^)(id responseObject,NSError *error))block;

/**
 GET请求
 
 @param target 当前控制器
 @param url 请求地址
 @param parameters 请求参数字典
 @param showHud 是否显示菊花转圈
 @param hudTips 菊花框提示语
 @param showErrMes 是否展示（请求中Code=Err时）返回的ErrMessage
 @param block 返回信息
 */
- (void)getRequestWithTarget:(UIViewController *)target
                         url:(NSString *)url
                  parameters:(id)parameters
                     showHud:(BOOL)showHud
                     hudTips:(NSString *)hudTips
                  showErrMes:(BOOL)showErrMes
                       block:(void (^)(id responseObject,NSError *error))block;

/**
 PUT请求
 
 @param target 当前控制器
 @param url 请求地址
 @param parameters 请求参数字典
 @param showHud 是否显示菊花转圈
 @param hudTips 菊花框提示语
 @param showErrMes 是否展示（请求中Code=Err时）返回的ErrMessage
 @param block 返回信息
 */
- (void)putRequestWithTarget:(UIViewController *)target
                         url:(NSString *)url
                  parameters:(id)parameters
                     showHud:(BOOL)showHud
                     hudTips:(NSString *)hudTips
                  showErrMes:(BOOL)showErrMes
                       block:(void (^)(id responseObject,NSError *error))block;


#pragma mark 上传文件请求（新 添加参数hudTips、showErrMes）
/**
 上传文件请求
 
 @param target 当前控制器
 @param url 请求地址
 @param parameters 请求参数字典
 @param showHud 是否显示菊花转圈
 @param hudTips 菊花框提示语
 @param showErrMes 是否展示（请求中Code=Err时）返回的ErrMessage
 @param fileData 文件数据
 @param name 文件夹名称
 @param mimeType 文件类型
 @param block 返回信息
 */
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
                          block:(void (^)(id responseObject, NSError *error))block;




#pragma mark 普通请求（新 添加参数Model）
/**
 POST请求
 
 @param target 当前控制器
 @param url 请求地址
 @param parameters 请求参数字典
 @param networkParModel 参数Model(可将传入参数扩展)
 @param block 返回信息
 */
- (void)postRequestWithTarget:(UIViewController *)target
                          url:(NSString *)url
                   parameters:(id)parameters
              networkParModel:(NetworkParModel *)networkParModel
                        block:(void (^)(id responseObject, NSError *error))block;

/**
 GET请求
 
 @param target 当前控制器
 @param url 请求地址
 @param parameters 请求参数字典
 @param networkParModel 参数Model(可将传入参数扩展)
 @param block 返回信息
 */
- (void)getRequestWithTarget:(UIViewController *)target
                         url:(NSString *)url
                  parameters:(id)parameters
             networkParModel:(NetworkParModel *)networkParModel
                       block:(void (^)(id responseObject, NSError *error))block;

/**
 PUT请求
 
 @param target 当前控制器
 @param url 请求地址
 @param parameters 请求参数字典
 @param networkParModel 参数Model(可将传入参数扩展)
 @param block 返回信息
 */
- (void)putRequestWithTarget:(UIViewController *)target
                         url:(NSString *)url
                  parameters:(id)parameters
             networkParModel:(NetworkParModel *)networkParModel
                       block:(void (^)(id responseObject, NSError *error))block;


#pragma mark 上传文件请求（新 添加参数Model）
/**
 上传文件请求
 
 @param target 当前控制器
 @param url 请求地址
 @param parameters 请求参数字典
 @param networkParModel 参数Model(可将传入参数扩展)
 @param block 返回信息
 */
- (void)uploadRequestWithTarget:(UIViewController *)target
                            url:(NSString *)url
                     parameters:(id)parameters
                networkParModel:(NetworkParModel *)networkParModel
                          block:(void (^)(id responseObject, NSError *error))block;



@end
