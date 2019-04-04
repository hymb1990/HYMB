//
//  MyAlertView.m
//  HYMB
//
//  Created by 863 on 2019/3/1.
//  Copyright © 2019年 hymb. All rights reserved.
//

//屏幕宽高
#define kScreen_Width   [UIScreen mainScreen].bounds.size.width
#define kScreen_Height  [UIScreen mainScreen].bounds.size.height

#define kAlertWidth     (kScreen_Width-80)//弹出框的宽度
#define kScrollViewMaxHeight 300//scrollView的最大高度
#define kBottomBHeight  45//底部按钮的高度
#define titleLFont      [UIFont boldSystemFontOfSize:18]//titleL的Font
#define messageLFont    [UIFont systemFontOfSize:13]//messageL的Font
#define ColorWithRGB(r, g, b)       [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]

#import "MyAlertView.h"

@interface MyAlertView ()

@property (nonatomic, strong) UIView *alert;//弹出框
@property (nonatomic, strong) UIScrollView *scrollView;//titleL、messageL添加在scrollView上
@property (nonatomic, strong) UILabel *titleL;//标题Label
@property (nonatomic, strong) UILabel *messageL;//内容Label
@property (nonatomic, strong) UIButton *cancelB;//取消Btn
@property (nonatomic, strong) UIButton *confirmB;//确定Btn
@property (nonatomic, strong) UIView *horizontalLine;//水平线
@property (nonatomic, strong) UIView *verticalLine;//竖直线

@end

@implementation MyAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message {
    if (self = [self init]) {
        [self setUIWithTitle:title message:message];
        _titleL.text = title;
        _messageL.text = message;
    }
    return self;
}

- (void)setUIWithTitle:(NSString *)title message:(NSString *)message {

    float titleLHeight = [Util measureMutilineStringHeight:title andFont:titleLFont andWidthSetup:kAlertWidth-20];
    float messageLHeight = [Util measureMutilineStringHeight:message andFont:messageLFont andWidthSetup:kAlertWidth-20];
    float scrollViewHeight = titleLHeight+messageLHeight;
    scrollViewHeight = (scrollViewHeight > kScrollViewMaxHeight)?kScrollViewMaxHeight:scrollViewHeight;

    
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3f];
    
    _alert = [[UIView alloc] init];
    _alert.backgroundColor = [UIColor whiteColor];
    _alert.layer.cornerRadius = 15.f;
    _alert.layer.masksToBounds = YES;
    [self addSubview:_alert];
    [_alert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo((kScreen_Height-scrollViewHeight-kBottomBHeight)/2);
        make.left.mas_equalTo((kScreen_Width-kAlertWidth)/2);
        make.width.mas_equalTo(kAlertWidth);
        make.height.mas_equalTo(scrollViewHeight+kBottomBHeight);
    }];
    
    _scrollView = [UIScrollView new];
    _scrollView.contentSize = CGSizeMake(kAlertWidth, titleLHeight+messageLHeight+20);
    [_alert addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kAlertWidth);
        make.height.mas_equalTo(scrollViewHeight);
    }];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textAlignment = NSTextAlignmentCenter;
    _titleL.font = titleLFont;
    _titleL.numberOfLines = 0;
    _titleL.text = title;
    [_scrollView addSubview:_titleL];
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(kAlertWidth-20);
        make.height.mas_equalTo(titleLHeight);
    }];
    
    _messageL = [[UILabel alloc] init];
    _messageL.textAlignment = NSTextAlignmentLeft;
    _messageL.font = messageLFont;
    _messageL.numberOfLines = 0;
    _messageL.text = message;
    [_scrollView addSubview:_messageL];
    [_messageL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleL.mas_bottom).with.offset(0);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(kAlertWidth-20);
        make.height.mas_equalTo(messageLHeight);
    }];

    _cancelB = [[UIButton alloc] init];
    [_cancelB setTitleColor:ColorWithRGB(27, 114, 229) forState:(UIControlStateNormal)];
    [_cancelB setTitle:@"取消" forState:(UIControlStateNormal)];
    _cancelB.titleLabel.font = [UIFont systemFontOfSize:16];
    [_cancelB addTarget:self action:@selector(cancelBAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_alert addSubview:_cancelB];
    [_cancelB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.mas_bottom).with.offset(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo((kAlertWidth)/2);
        make.height.mas_equalTo(kBottomBHeight);
    }];
    
    _confirmB = [[UIButton alloc] init];
    [_confirmB setTitleColor:ColorWithRGB(27, 114, 229) forState:(UIControlStateNormal)];
    [_confirmB setTitle:@"确定" forState:(UIControlStateNormal)];
    _confirmB.titleLabel.font = [UIFont systemFontOfSize:16];
    [_confirmB addTarget:self action:@selector(confirmBAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_alert addSubview:_confirmB];
    [_confirmB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.mas_bottom).with.offset(0);
        make.left.mas_equalTo((kAlertWidth)/2);
        make.width.mas_equalTo((kAlertWidth)/2);
        make.height.mas_equalTo(kBottomBHeight);
    }];
    
    _horizontalLine = [UIView new];
    _horizontalLine.backgroundColor = [UIColor lightGrayColor];
    [_alert addSubview:_horizontalLine];
    [_horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.mas_bottom).with.offset(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kAlertWidth);
        make.height.mas_equalTo(0.5);
    }];
    
    _verticalLine = [UIView new];
    _verticalLine.backgroundColor = [UIColor lightGrayColor];
    [_alert addSubview:_verticalLine];
    [_verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.mas_bottom).with.offset(0);
        make.left.mas_equalTo(kAlertWidth/2);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(kBottomBHeight);
    }];
    
}

//触摸事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)show {
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    self.alert.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
    self.alert.alpha = 0;

    [UIView animateWithDuration:.7f delay:0.f usingSpringWithDamping:.7f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alert.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        self.alert.alpha = 1.0;
    } completion:nil];
    
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.3f animations:^{
        self.alert.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
        self.alert.alpha = 0;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}



//取消
- (void)cancelBAction {
    [self dismiss];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

//确定
- (void)confirmBAction {
    [self dismiss];
    if (self.confirmBlock) {
        self.confirmBlock();
    }
}


@end
