//
//  DouBanGifFooter.m
//  HYMB
//
//  Created by 863Soft on 2019/4/16.
//  Copyright © 2019 hymb. All rights reserved.
//

#import "DouBanGifFooter.h"

@implementation DouBanGifFooter
#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    self.refreshingTitleHidden = YES;
    self.stateLabel.hidden = YES;
}
@end
