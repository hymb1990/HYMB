//
//  UIView+Extension.h
//  DouYu
//
//  Created by Lindon on 16/4/21.
//  Copyright © 2016年 Lindon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (assign,nonatomic) CGFloat width;
@property (assign,nonatomic) CGFloat height;
@property (assign,nonatomic) CGFloat X;
@property (assign,nonatomic) CGFloat Y;
@property (assign,nonatomic) CGFloat centerX;
@property (assign,nonatomic) CGFloat centerY;


- (void)setDottedLineWithLineColor:(UIColor*)lineColor WithLineWidth:(CGFloat)lineWidth;

@end
