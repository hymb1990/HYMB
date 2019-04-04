//
//  NetworkParModel.h
//  XQBAPP
//
//  Created by sgft on 2018/12/13.
//  Copyright © 2018年 Lindon. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkParModel : NSObject


//普通请求 使用到***************************************
//上传文件请求 使用到************************************
@property (nonatomic, copy) NSString *hudTips;  //菊花框提示语（默认“加载中”）
@property (nonatomic, assign) BOOL showHud;     //是否展示菊花框（默认“YES”）
@property (nonatomic, assign) BOOL showErrMes;  //是否展示（请求中Code=Err时）返回的ErrMessage（默认“YES”）


//上传文件请求 使用到************************************
@property (nonatomic, copy) NSData *fileData;   //文件数据
@property (nonatomic, copy) NSString *name;     //文件夹名称
@property (nonatomic, copy) NSString *fileName; //文件名
@property (nonatomic, copy) NSString *mimeType; //文件类型

@end

NS_ASSUME_NONNULL_END


