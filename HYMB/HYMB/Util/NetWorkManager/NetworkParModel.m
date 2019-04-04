//
//  NetworkParModel.m
//  XQBAPP
//
//  Created by sgft on 2018/12/13.
//  Copyright © 2018年 Lindon. All rights reserved.
//

#import "NetworkParModel.h"

@implementation NetworkParModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _hudTips = @"加载中";//默认菊花框提示语
        _showHud = YES;     //默认展示菊花框
        _showErrMes = YES;  //默认展示Code=Err时的Mes
    }
    return self;
}


@end
