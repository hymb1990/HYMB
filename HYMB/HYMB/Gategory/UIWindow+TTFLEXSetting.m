//
//  UIWindow+TTFLEXSetting.m
//  HYMB
//
//  Created by sgft on 2018/9/26.
//  Copyright © 2018年 hymb. All rights reserved.
//

#import "UIWindow+TTFLEXSetting.h"
#if DEBUG
#import "FLEXManager.h"
#endif
@implementation UIWindow (TTFLEXSetting)

#if DEBUG
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    [super motionBegan:motion withEvent:event];
    if (motion == UIEventSubtypeMotionShake) {
        [[FLEXManager sharedManager] showExplorer];
    }
}
#endif

@end
