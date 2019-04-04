//
//  UIView+Extension.m
//  DouYu
//
//  Created by Lindon on 16/4/21.
//  Copyright © 2016年 Lindon. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setWidth:(CGFloat)width {
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
    
}
- (CGFloat)width {
    
    return self.frame.size.width;
}
- (void)setHeight:(CGFloat)height {
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;

}
- (CGFloat)height {
    
    return self.frame.size.height;
}
- (void)setX:(CGFloat)X {
    CGRect rect = self.frame;
    rect.origin.x = X;
    self.frame = rect;


}

- (CGFloat)X {
    
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)Y{
    CGRect rect = self.frame;
    rect.origin.y = Y;
    self.frame = rect;
    
    
}

- (CGFloat)Y {
    
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;

}
- (CGFloat)centerX {
    
    return self.center.x;
}
- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)centerY {
    
    return self.center.y;
}


- (void)setDottedLineWithLineColor:(UIColor*)lineColor WithLineWidth:(CGFloat)lineWidth{
    
    CAShapeLayer *border = [CAShapeLayer layer];
    
    //虚线的颜色
    border.strokeColor = lineColor.CGColor;
    //填充的颜色
    border.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:5];
    
    //设置路径
    border.path = path.CGPath;
    
    border.frame = self.bounds;
    //虚线的宽度
    border.lineWidth = lineWidth;
    
    
    //设置线条的样式
    //    border.lineCap = @"square";
    //虚线的间隔
    border.lineDashPattern = @[@4, @2];
    
    self.layer.cornerRadius = 5.f;
    self.layer.masksToBounds = YES;
    
    [self.layer addSublayer:border];
    
   
    
    
    
    
}





@end
