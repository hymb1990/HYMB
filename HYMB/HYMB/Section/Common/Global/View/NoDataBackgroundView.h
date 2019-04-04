//
//  NoDataBackgroundView.h
//  XQBAPP
//
//  Created by wujing on 2018/7/25.
//  Copyright © 2018年 Lindon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoDataBackgroundView : UIView

-(instancetype)initWithFrame:(CGRect)frame;

-(void)hidden;
-(void)show;

@property (nonatomic, copy) NSString *tipsText;

@end
