//
//  NoDataBackgroundView.m
//  XQBAPP
//
//  Created by wujing on 2018/7/25.
//  Copyright © 2018年 Lindon. All rights reserved.
//

#import "NoDataBackgroundView.h"


@interface NoDataBackgroundView()

@property (nonatomic, strong) UIImageView *backgroundImg;
@property (nonatomic, strong) UILabel *tipsLabel;

@end

@implementation NoDataBackgroundView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = DefaultColor;
        [self addSubview:self.backgroundImg];
        [self addSubview:self.tipsLabel];
    }
    return self;
}

- (UIImageView *)backgroundImg {
    
    if (!_backgroundImg) {
        
        _backgroundImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"空"]];
        [self addSubview:_backgroundImg];
        _backgroundImg.sd_layout.heightIs(95)
        .widthIs(201)
        .centerXEqualToView(self)
        .topSpaceToView(self, self.height / 2 - 100);
    }
    return _backgroundImg;
}

- (UILabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel = [UILabel new];
        [self addSubview:_tipsLabel];
        _tipsLabel.font = [UIFont systemFontOfSize:14.0];
        _tipsLabel.textColor = ColorWithRGBP(150, 150, 150, 1);
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        
        _tipsLabel.sd_layout.leftEqualToView(self)
        .rightEqualToView(self)
        .heightIs(20)
        .topSpaceToView(self.backgroundImg, 20);
        
//        _tipsLabel.backgroundColor = [UIColor redColor];
        
    }
    return _tipsLabel;
}

- (void)setTipsText:(NSString *)tipsText {
    _tipsText = tipsText;
    
    self.tipsLabel.text = tipsText;
}
-(void)hidden{
    
    [self setHidden:YES];
}
-(void)show{
    
    [self setHidden:NO];
}

@end
