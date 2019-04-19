//
//  FirstPageVC.m
//  HYMB
//
//  Created by sgft on 2018/9/7.
//  Copyright © 2018年 hymb. All rights reserved.
//

#import "FirstPageVC.h"
#import "FirstPageCell.h"
#import "UICollectionViewFlowLayout+Add.h"
#import "NomalRefreshVC.h"
#import "AnimationRefreshVC.h"
#import "LoadingAnimationVC.h"
#import "LottieVC.h"
#import "ShimmerVC.h"
#import "SearchVC.h"
#import "TabVC.h"
#import "PopVC.h"
#import "PickerVC.h"
#import "ScanVC.h"
#import "LoopViewController.h"
#import "WeChatPayVC.h"
#import "SSLVC.h"
#import "FSCalendarVC.h"
#import "WebVC.h"
#import "OC_JSVC.h"
#import "YYTextVC.h"
#import "PhotoBrowserVC.h"
#import "propertyListVC.h"
#import "PreferenceVC.h"
#import "NSKeyedArchiverVC.h"
#import "FMDBViewController.h"
#import "CoreDataViewController.h"
#import "AESViewController.h"
#import "DESViewController.h"
#import "MD5ViewController.h"
#import "RSAViewController.h"
#import "SpecialEffectsVC.h"
#import "FingerprintIdentificationVC.h"

@interface FirstPageVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSArray *dataArr;

@end

@implementation FirstPageVC

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];

    self.dataArr = @[
                     @{@"title":@"其它",
                       @"content":@[
                                    @"Swift",
                                    @"https配置",
                                    @"YYText",
                                    @"FSCalendar",
                                    @"webView",
                                    @"OCJS",
                                    @"指纹识别",
                                    ]},
                     
                     @{@"title":@"常用控件",
                       @"content":@[@"Search",
                                    @"Tab",
                                    @"Pop",
                                    @"Picker",
                                    @"Scan",
                                    @"Loop",
                                    @"PhotoBrowser",]},
                     
                     @{@"title":@"加密解密",
                       @"content":@[@"AES",
                                    @"DES",
                                    @"MD5",
                                    @"RSA",
                                    ]},
                     
                     @{@"title":@"数据持久化",
                       @"content":@[@"NSKeyedArchiver(归档)",
                                    @"Preference(偏好设置)",
                                    @"propertyList(属性列表)",
                                    @"FMDB",
                                    @"CoreData",
                                    ]},
                     
                     @{@"title":@"刷新加载",
                       @"content":@[@"普通刷新",
                                    @"动画刷新"]},
                     
                     @{@"title":@"动画",
                       @"content":@[@"加载动画",
                                    @"lottie-ios",
                                    @"Shimmer",
                                    @"特效",]},
                     
                     
                     
//                     @{@"title":@"多媒体",
//                       @"content":@[@"音频",
//                                    @"视频",]},
//
//                     @{@"title":@"支付",
//                       @"content":@[@"微信支付",
//                                    @"支付宝支付",
//                                    @"银联支付"]},
//
//                     @{@"title":@"即时通信",
//                       @"content":@[@"环信",
//                                    @"融云"]},
//
//                     @{@"title":@"地图",
//                       @"content":@[@"系统地图",
//                                    @"百度地图",
//                                    @"高德地图", ]},
//
//                     @{@"title":@"推送",
//                       @"content":@[@"信鸽推送",
//                                    @"极光推送",
//                                    @"个推推送"]},
//
//                     @{@"title":@"第三方登录",
//                       @"content":@[@"友盟",
//                                    @"shareSDK",]},
//
//                     @{@"title":@"分享",
//                       @"content":@[@"系统分享",
//                                    @"友盟",
//                                    @"shareSDK",
//                                    @"openShare", ]},
                     
                     ];
    
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
}

#pragma mark - 构建视图
- (void)setUI {
    
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    

    
    //创建集合视图布局类
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(kScreen_Width, 100);
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 1;
    flowLayout.headerReferenceSize = CGSizeMake(kScreen_Width, 30);
    flowLayout.footerReferenceSize = CGSizeMake(kScreen_Width, CGFLOAT_MIN);
    
    //创建collectionView（并用布局类对象初始化集合视图）
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-NaviH) collectionViewLayout:flowLayout];
    
    self.collectionView.backgroundColor = DefaultColor;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    
    //分区头停留在视图顶端
    ((UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout).sectionHeadersPinToVisibleBoundsAll = YES;
    
    
}


#pragma mark - collectionView代理方法
/**
 * 分区数
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.dataArr.count;
    
}

/**
 * 分区对应的Item个数
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [self.dataArr[section][@"content"] count];
    
}

/**
 * cell的属性设置
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
    [self.collectionView registerNib:[UINib nibWithNibName:@"FirstPageCell" bundle:nil] forCellWithReuseIdentifier:CellIdentifier];
    FirstPageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    cell.titleL.text = self.dataArr[indexPath.section][@"content"][indexPath.row];
    
    return cell;
}


/**
 * cell点击事件
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FirstPageCell *cell = (FirstPageCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    
    if ([cell.titleL.text isEqualToString:@"RSA"]) {
        RSAViewController *VC = [RSAViewController new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if ([cell.titleL.text isEqualToString:@"MD5"]) {
        MD5ViewController *VC = [MD5ViewController new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if ([cell.titleL.text isEqualToString:@"AES"]) {
        AESViewController *VC = [AESViewController new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if ([cell.titleL.text isEqualToString:@"DES"]) {
        DESViewController *VC = [DESViewController new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if ([cell.titleL.text isEqualToString:@"CoreData"]) {
        CoreDataViewController *VC = [CoreDataViewController new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if ([cell.titleL.text isEqualToString:@"FMDB"]) {
        FMDBViewController *VC = [FMDBViewController new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if ([cell.titleL.text isEqualToString:@"NSKeyedArchiver(归档)"]) {
         NSKeyedArchiverVC *VC = [NSKeyedArchiverVC new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if ([cell.titleL.text isEqualToString:@"Preference(偏好设置)"]) {
        PreferenceVC *VC = [PreferenceVC new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if ([cell.titleL.text isEqualToString:@"propertyList(属性列表)"]) {
        propertyListVC *VC = [propertyListVC new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if ([cell.titleL.text isEqualToString:@"普通刷新"]) {
        NomalRefreshVC *VC = [NomalRefreshVC new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if ([cell.titleL.text isEqualToString:@"动画刷新"]) {
        AnimationRefreshVC *VC = [AnimationRefreshVC new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if ([cell.titleL.text isEqualToString:@"加载动画"]) {
        LoadingAnimationVC *VC = [LoadingAnimationVC new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if ([cell.titleL.text isEqualToString:@"lottie-ios"]) {
        LottieVC *VC = [LottieVC new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if ([cell.titleL.text isEqualToString:@"Shimmer"]) {
        ShimmerVC *VC = [ShimmerVC new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if ([cell.titleL.text isEqualToString:@"Search"]) {
        SearchVC *VC = [SearchVC new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if ([cell.titleL.text isEqualToString:@"Tab"]) {
        TabVC *VC = [TabVC new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if ([cell.titleL.text isEqualToString:@"Pop"]) {
        PopVC *VC = [PopVC new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if ([cell.titleL.text isEqualToString:@"Picker"]) {
         PickerVC *VC = [PickerVC new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if ([cell.titleL.text isEqualToString:@"Scan"]) {
        ScanVC *VC = [ScanVC new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if ([cell.titleL.text isEqualToString:@"Loop"]) {
        LoopViewController *VC = [LoopViewController new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if ([cell.titleL.text isEqualToString:@"https配置"]) {
        SSLVC *VC = [SSLVC new];
        [self.navigationController pushViewController:VC animated:YES];
    }
   
    if ([cell.titleL.text isEqualToString:@"FMDB"]) {

    }
    
    if ([cell.titleL.text isEqualToString:@"PhotoBrowser"]) {
        PhotoBrowserVC *VC = [PhotoBrowserVC new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if ([cell.titleL.text isEqualToString:@"YYText"]) {
        YYTextVC *VC = [YYTextVC new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if ([cell.titleL.text isEqualToString:@"FSCalendar"]) {
        FSCalendarVC *VC = [FSCalendarVC new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if ([cell.titleL.text isEqualToString:@"webView"]) {
        WebVC *VC = [WebVC new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if ([cell.titleL.text isEqualToString:@"OCJS"]) {
        OC_JSVC *VC = [OC_JSVC new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if ([cell.titleL.text isEqualToString:@"Swift"]) {
        SwiftViewController *VC = [SwiftViewController new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if ([cell.titleL.text isEqualToString:@"特效"]) {
        SpecialEffectsVC *VC = [SpecialEffectsVC new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if ([cell.titleL.text isEqualToString:@"指纹识别"]) {
        FingerprintIdentificationVC *VC = [FingerprintIdentificationVC new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    

}

/**
 * 返回分区的头和脚
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        NSString *headerIdentifier = [NSString stringWithFormat:@"header%ld%ld",(long)indexPath.section,(long)indexPath.row];
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        view.backgroundColor = DefaultColor;
        
        //移除子视图
        [view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 30)];
        titleL.text = self.dataArr[indexPath.section][@"title"];
        titleL.textAlignment = NSTextAlignmentCenter;
        [view addSubview:titleL];

        return view;
    }else{
        NSString *footerIdentifier = [NSString stringWithFormat:@"footer%ld%ld",(long)indexPath.section,(long)indexPath.row];
         [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerIdentifier];
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerIdentifier forIndexPath:indexPath];
        view.backgroundColor = [UIColor grayColor];
        return view;
    }
    
}

@end

