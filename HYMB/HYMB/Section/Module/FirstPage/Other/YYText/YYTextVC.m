//
//  YYTextVC.m
//  HYMB
//
//  Created by sgft on 2018/9/26.
//  Copyright © 2018年 hymb. All rights reserved.
//

#import "YYTextVC.h"
#import "YYText.h"
@interface YYTextVC ()

@end

@implementation YYTextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setUI {
    
    self.view.backgroundColor = DefaultColor;
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:@"我已仔细阅读并解释《客户须知》、《赣州银行人民币单位结算账户管理协议》，完全同意和接受协议书中全部条款和内容，愿意履行和承担该协议书中约定的权利和义务。"];
    attributedText.yy_font = [UIFont boldSystemFontOfSize:15.0f];
    attributedText.yy_color = [UIColor lightGrayColor];
    NSRange range1 = [self getRangeWithOriginalStr:@"我已仔细阅读并解释《客户须知》、《赣州银行人民币单位结算账户管理协议》，完全同意和接受协议书中全部条款和内容，愿意履行和承担该协议书中约定的权利和义务。" Str:@"《客户须知》"];
    NSRange range2 = [self getRangeWithOriginalStr:@"我已仔细阅读并解释《客户须知》、《赣州银行人民币单位结算账户管理协议》，完全同意和接受协议书中全部条款和内容，愿意履行和承担该协议书中约定的权利和义务。" Str:@"《赣州银行人民币单位结算账户管理协议》"];
    [attributedText yy_setColor:[UIColor redColor] range:range1];
    [attributedText yy_setColor:[UIColor redColor] range:range2];
    [attributedText yy_setTextHighlightRange:range1//设置点击的位置
                             color:BtnBlueColor
                   backgroundColor:[UIColor clearColor]
                         tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                             NSLog(@"这里是点击事件1");
                         }];
    [attributedText yy_setTextHighlightRange:range2//设置点击的位置
                             color:BtnBlueColor
                   backgroundColor:[UIColor clearColor]
                         tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                             NSLog(@"这里是点击事件2");
                         }];
    //设置字体大小
    [attributedText yy_setFont:[UIFont boldSystemFontOfSize:19.0] range:range1];
    //添加下划线
    YYTextDecoration *textDecoration = [YYTextDecoration new];
    textDecoration.style = YYTextLineStyleSingle;
    [attributedText yy_setTextUnderline:textDecoration range:range2];
    [attributedText yy_setUnderlineColor:[UIColor redColor] range:range2];
    
    YYLabel *heightRangeLabel = [YYLabel new];
    heightRangeLabel.frame = CGRectMake(60, 10, kScreen_Width-80, 100);
    heightRangeLabel.attributedText = attributedText;
    heightRangeLabel.numberOfLines = 0;
    heightRangeLabel.userInteractionEnabled = YES;
    //    heightRangeLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:heightRangeLabel];
}

//获取特定字符串在总字符串中的NSRange
- (NSRange )getRangeWithOriginalStr:(NSString *)originalStr Str:(NSString *)str {
    
    NSMutableAttributedString *contentStr = [[NSMutableAttributedString alloc]initWithString:originalStr];
    //找出特定字符在整个字符串中的位置
    NSRange redRange = NSMakeRange([[contentStr string] rangeOfString:str].location, [[contentStr string] rangeOfString:str].length);
    //    //修改特定字符的颜色
    //    [contentStr addAttribute:NSForegroundColorAttributeName value:color range:redRange];
    //    //修改特定字符的字体大小
    //    [contentStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:19] range:redRange];
    
    return redRange;
}


@end
