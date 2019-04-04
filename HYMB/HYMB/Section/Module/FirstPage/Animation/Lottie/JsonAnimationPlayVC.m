//
//  JsonAnimationPlayVC.m
//  HYMB
//
//  Created by sgft on 2018/9/26.
//  Copyright © 2018年 hymb. All rights reserved.
//

#import "JsonAnimationPlayVC.h"

@interface JsonAnimationPlayVC ()

@end

@implementation JsonAnimationPlayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DefaultColor;
    
    LOTAnimationView *animation = [LOTAnimationView animationNamed:self.type];
    animation.frame = self.view.frame;
    [self.view addSubview:animation];
    
    [animation playWithCompletion:^(BOOL animationFinished) {
        // Do Something
        animation.hidden = YES;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
