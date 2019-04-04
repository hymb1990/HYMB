//
//  ToastManager.h
//  XQBAPP
//
//  Created by sgft on 2018/12/6.
//  Copyright © 2018年 Lindon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToastManager : NSObject

/**
 提示框
 
 @param view 展示到的页面
 @param tips 提示语
 */
+ (void)showToastInView:(UIView *)view
                   tips:(NSString *)tips;

/**
 提示框
 
 @param view 展示到的页面
 @param tips 提示语
 @param delay 几秒后隐藏
 */
+ (void)showToastInView:(UIView *)view
                   tips:(NSString *)tips
                  delay:(NSTimeInterval)delay;

/**
 提示框
 
 @param view 展示到的页面
 @param tips 提示语
 @param tipsImageName 提示图片名称
 @param delay 几秒后隐藏
 */
+ (void)showToastInView:(UIView *)view
                   tips:(NSString *)tips
          tipsImageName:(NSString *)tipsImageName
                  delay:(NSTimeInterval)delay;

/**
 提示框
 
 @param view 展示到的页面
 @param tips 提示语
 @param tipsImageName 提示图片名称
 @param postion 位置（0顶部 1中间 2底部）
 @param delay 几秒后隐藏
 */
+ (void)showToastInView:(UIView *)view
                   tips:(NSString *)tips
          tipsImageName:(NSString *)tipsImageName
                postion:(NSInteger)postion
                  delay:(NSTimeInterval)delay;


/**
 提示框
 
 @param view 展示到的页面
 @param tips 提示语
 @param tipsImageName 提示图片名称
 @param postion 位置（0顶部 1中间 2底部）
 @param delay 几秒后隐藏
 @param translucent UINavigationBar的 translucent = YES (坐标原点向下移动一个导航条的位置)
 */
+ (void)showToastInView:(UIView *)view
                   tips:(NSString *)tips
          tipsImageName:(NSString *)tipsImageName
                postion:(NSInteger)postion
                  delay:(NSTimeInterval)delay
            translucent:(BOOL)translucent;


@end

NS_ASSUME_NONNULL_END
