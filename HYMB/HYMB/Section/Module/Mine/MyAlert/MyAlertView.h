//
//  MyAlertView.h
//  HYMB
//
//  Created by 863 on 2019/3/1.
//  Copyright © 2019年 hymb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^CancelBlock)(void);
typedef void (^ConfirmBlock)(void);

@interface MyAlertView : UIView

@property (nonatomic, copy) CancelBlock cancelBlock;//取消
@property (nonatomic, copy) ConfirmBlock confirmBlock;//确定

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message;
- (void)show;//展示

@end

NS_ASSUME_NONNULL_END
