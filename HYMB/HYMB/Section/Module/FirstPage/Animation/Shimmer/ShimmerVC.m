//
//  ShimmerVC.m
//  HYMB
//
//  Created by sgft on 2018/9/26.
//  Copyright © 2018年 hymb. All rights reserved.
//

#import "ShimmerVC.h"
#import "FBShimmeringView.h"
@interface ShimmerVC ()

@end

@implementation ShimmerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    FBShimmeringView *shimmeringView = [[FBShimmeringView alloc] initWithFrame:CGRectMake((kScreen_Width-200)/2, (kScreen_Height-100)/2, 200, 100)];
    [self.view addSubview:shimmeringView];

//    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:shimmeringView.bounds];
//    loadingLabel.textAlignment = NSTextAlignmentCenter;
//    loadingLabel.font = [UIFont systemFontOfSize:30];
//    loadingLabel.text = NSLocalizedString(@"今日头条", nil);
//    shimmeringView.contentView = loadingLabel;
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:shimmeringView.bounds];
    imageV.image = [UIImage imageNamed:@"今日头条"];
    shimmeringView.contentView = imageV;
    
    

    // Start shimmering.
    shimmeringView.shimmering = YES;
    shimmeringView.shimmeringPauseDuration = 0.1;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
