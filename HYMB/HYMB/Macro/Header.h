//
//  Header.h
//  HYMB
//
//  Created by sgft on 2018/9/7.
//  Copyright © 2018年 hymb. All rights reserved.
//

#ifndef Header_h
#define Header_h

/* 其它-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */

//#define weakify(...) \
//rac_keywordify \
//metamacro_foreach_cxt(rac_weakify_,, __weak, __VA_ARGS__)
//
//#define strongify(...) \
//rac_keywordify \
//_Pragma("clang diagnostic push") \
//_Pragma("clang diagnostic ignored \"-Wshadow\"") \
//metamacro_foreach(rac_strongify_,, __VA_ARGS__) \
//_Pragma("clang diagnostic pop")

/* 定义颜色-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
//导航条颜色
#define NaviColor       ColorWithRGB(27, 114, 229)
//tableView默认背景色
#define DefaultColor    ColorWithRGB(240, 240, 240)

//常用按钮蓝色 （可点击）
#define BtnBlueColor        ColorWithRGB(0, 124, 198)
//常用按钮蓝灰色（不可点击）
#define BtnGrayColor        ColorWithRGB(178, 215, 238)

/* 定义数值-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
//全屏高度
#define kSCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
//全屏宽度
#define kSCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width

#define kSPACE 10

//滚动视图的宽
#define KSCOLLVIEW_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
//滚动视图的高
#define KSCOLLVIEW_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)

//屏幕宽高
#define kScreen_Width   [UIScreen mainScreen].bounds.size.width
#define kScreen_Height  [UIScreen mainScreen].bounds.size.height
#define kMainWindow     [UIApplication sharedApplication].keyWindow
//缩放比例--基于6s宽度
#define kWidth_Scale    [UIScreen mainScreen].bounds.size.width/376
//812是iPhoneX的高度
#define NaviH           ([[UIScreen mainScreen] bounds].size.height == 812 ? 88 : 64)


/* 定义方法-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
//自定义打印log方法
#define MYLog(xx, ...)  NSLog(@"\n %s (%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

//自定义颜色的方法
#define ColorWithRGBP(r, g, b, p)   [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:(p)/1.f]
#define ColorWithRGB(r, g, b)       [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]





/* 引入文件-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */

#import "UINavigationController+FDFullscreenPopGesture.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "Masonry.h"
#import "SDAutoLayout.h"
#import "UIImageView+WebCache.h"
#import "Util.h"
#import "NetworkParModel.h"
#import "NetworkManager.h"
#import "NetworkService.h"
#import "NoDataBackgroundView.h"
#import "SJSwitchViewController.h"
#import "YBPopupMenu.h"
#import "UIView+Extension.h"
#import "SSLManager.h"

#import <Lottie/Lottie.h>
//#import <ZFPlayer/ZFPlayer.h>

#import "ZFPlayer.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "FMDB.h"
#import "ToastManager.h"

/* 其它-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */

#if DEBUG
#import "FLEXManager.h"
#endif

#pragma mark - 证书配置
#define caPassword @"shuige123"
#define openHttpsSSL YES    // 是否打开ssl配置
#define isTest NO           // 配置ssl证书类型 （测试YES 预发NO 生产NO）

//一窗办APP的
#define OpenId            @"ff80808160490bd30160781207090000"
#define Secret            @"485183983ad926a183786ea763b97547566ab01fc1c09758cf7be30c4e7fa594"
#define OpenId_Img        @"ff80808160490bd30160781207090000"
#define Secret_Img        @"485183983ad926a183786ea763b97547566ab01fc1c09758cf7be30c4e7fa594"



/* 服务地址、接口地址-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */


//赣州一窗办
////生产----------------------------------------------------------------------
//#define GZYPT_Base_Url      @"https://api.once.xyvip.com/affairs"//服务器地址      （生产）
//#define GZYPT_Upload_Url    @"https://api.xybat.com/zuul/files/" //上传文件服务器地址（生产）

//预发-----------------------------------------------------------------
#define GZYPT_Base_Url      @"https://api.pre.once.xyvip.com/affairs"//服务器地址     （预发）
#define GZYPT_Upload_Url    @"https://api.pre.xybat.com/zuul/files/"//上传文件服务器地址（预发）

////测试-----------------------------------------------------------------------------------
//#define GZYPT_Base_Url      @"https://192.168.2.96:9443/affairs"//服务器地址     （测试）
//#define GZYPT_Upload_Url    @"https://192.168.2.51/zuul/files/"//上传文件服务器地址（测试）


#define GZYPT_accountlogin_login    @"/accountlogin/login"//登录 POST
#define GZYPT_userrealname_logOut   @"/userrealname/logOut"//退出登录 GET






//头条
#define api_news_feed_v58   @"https://is.snssdk.com/api/news/feed/v58/"//视频数据 GET





//礼物说
#define api_v1_channels_111_items   @"http://api.liwushuo.com/v1/channels/111/items"//视频数据 GET






#endif /* Header_h */
