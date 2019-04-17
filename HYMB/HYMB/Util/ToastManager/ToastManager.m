//
//  ToastManager.m
//  XQBAPP
//
//  Created by sgft on 2018/12/6.
//  Copyright © 2018年 Lindon. All rights reserved.
//

#import "ToastManager.h"

@implementation ToastManager

/**
 提示框
 
 @param view 展示到的页面
 @param tips 提示语
 */
+ (void)showToastInView:(UIView *)view
                   tips:(NSString *)tips {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.bezelView.alpha = 0.7;
    //    hud.label.text = title;
    hud.detailsLabel.text = tips;
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.detailsLabel.font = [UIFont systemFontOfSize:18];
    [hud setOffset:CGPointMake(0, -NaviH)];
    [hud hideAnimated:YES afterDelay:2];
    
}

/**
 提示框
 
 @param view 展示到的页面
 @param tips 提示语
 @param delay 几秒后隐藏
 */
+ (void)showToastInView:(UIView *)view
                   tips:(NSString *)tips
                  delay:(NSTimeInterval)delay {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.bezelView.alpha = 0.7;
    //    hud.label.text = title;
    hud.detailsLabel.text = tips;
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.detailsLabel.font = [UIFont systemFontOfSize:18];
    [hud setOffset:CGPointMake(0, -NaviH)];
    [hud hideAnimated:YES afterDelay:delay];
    
}



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
                  delay:(NSTimeInterval)delay {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.bezelView.alpha = 0.7;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:tipsImageName]];
    //    hud.label.text = title;
    hud.detailsLabel.text = tips;
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.detailsLabel.font = [UIFont systemFontOfSize:18];
    [hud setOffset:CGPointMake(0, -NaviH)];
    [hud hideAnimated:YES afterDelay:delay];
    
}

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
                  delay:(NSTimeInterval)delay {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.bezelView.alpha = 0.7;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:tipsImageName]];
    //    hud.label.text = title;
    hud.detailsLabel.text = tips;
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.detailsLabel.font = [UIFont systemFontOfSize:18];
    if (postion == 0) {//顶部
        [hud setOffset:CGPointMake(0, -kScreen_Height/2+NaviH)];
    }else if (postion == 1) {//中部
        [hud setOffset:CGPointMake(0, -NaviH)];
    }else if (postion == 2) {//底部
        [hud setOffset:CGPointMake(0, kScreen_Height/2-NaviH)];
    }
    [hud hideAnimated:YES afterDelay:delay];
    
}

/**
 提示框
 
 @param view 展示到的页面
 @param tips 提示语
 @param tipsImageName 提示图片名称
 @param postion 位置（0顶部 1中间 2底部）
 @param delay 几秒后隐藏
 @param translucent UINavigationBar translucent = YES (坐标原点向下移动一个导航条的位置)
 */
+ (void)showToastInView:(UIView *)view
                   tips:(NSString *)tips
          tipsImageName:(NSString *)tipsImageName
                postion:(NSInteger)postion
                  delay:(NSTimeInterval)delay
            translucent:(BOOL)translucent {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.bezelView.alpha = 0.7;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:tipsImageName]];
    //    hud.label.text = title;
    hud.detailsLabel.text = tips;
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.detailsLabel.font = [UIFont systemFontOfSize:18];
    if (translucent) {
        if (postion == 0) {//顶部
            [hud setOffset:CGPointMake(0, -kScreen_Height/2+NaviH+NaviH)];
        }else if (postion == 1) {//中部
            [hud setOffset:CGPointMake(0, -NaviH)];
        }else if (postion == 2) {//底部
            [hud setOffset:CGPointMake(0, kScreen_Height/2-NaviH)];
        }
    }else {
        if (postion == 0) {//顶部
            [hud setOffset:CGPointMake(0, -kScreen_Height/2+NaviH)];
        }else if (postion == 1) {//中部
            [hud setOffset:CGPointMake(0, -NaviH)];
        }else if (postion == 2) {//底部
            [hud setOffset:CGPointMake(0, kScreen_Height/2-NaviH)];
        }
    }
    [hud hideAnimated:YES afterDelay:delay];
    
}


@end
