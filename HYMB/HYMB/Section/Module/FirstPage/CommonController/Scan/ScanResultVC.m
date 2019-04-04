//
//  ScanResultVC.m
//  HYMB
//
//  Created by 863 on 2019/1/23.
//  Copyright © 2019年 hymb. All rights reserved.
//

#import "ScanResultVC.h"

@interface ScanResultVC ()
@property (weak, nonatomic) IBOutlet UILabel *resultL;
@property (weak, nonatomic) IBOutlet UIImageView *resultIV;

@end

@implementation ScanResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"扫描结果";
    
    self.resultL.text = self.result.strScanned;
    self.resultIV.image = self.result.imgScanned;
    
}



@end
