//
//  YBImageBrowserVC.m
//  HYMB
//
//  Created by sgft on 2018/11/27.
//  Copyright © 2018年 hymb. All rights reserved.
//

#import "YBImageBrowserVC.h"
#import "YBImageBrowserCell.h"
#import "YBImageBrowser.h"
@interface YBImageBrowserVC ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation YBImageBrowserVC

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[@"http://img4.duitang.com/uploads/item/201601/15/20160115231312_TWuG5.gif",
                       @"http://c.hiphotos.baidu.com/baike/pic/item/d1a20cf431adcbefd4018f2ea1af2edda3cc9fe5.jpg",
                       @"http://img3.duitang.com/uploads/item/201605/28/20160528202026_BvuWP.jpeg",
                       @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1524118823131&di=aa588a997ac0599df4e87ae39ebc7406&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201605%2F08%2F20160508154653_AQavc.png",
                       @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=722693321,3238602439&fm=27&gp=0.jpg",
                       @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1524118892596&di=5e8f287b5c62ca0c813a548246faf148&imgtype=0&src=http%3A%2F%2Fwx1.sinaimg.cn%2Fcrop.0.0.1080.606.1000%2F8d7ad99bly1fcte4d1a8kj20u00u0gnb.jpg",
                       @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1524118914981&di=7fa3504d8767ab709c4fb519ad67cf09&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201410%2F05%2F20141005221124_awAhx.jpeg",
                       @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1524118934390&di=fbb86678336593d38c78878bc33d90c3&imgtype=0&src=http%3A%2F%2Fi2.hdslb.com%2Fbfs%2Farchive%2Fe90aa49ddb2fa345fa588cf098baf7b3d0e27553.jpg",
                       @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1524118984884&di=7c73ddf9d321ef94a19567337628580b&imgtype=0&src=http%3A%2F%2Fimg5q.duitang.com%2Fuploads%2Fitem%2F201506%2F07%2F20150607185100_XQvYT.jpeg"];
    
    [self setUI];
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
    
    self.title = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建集合视图布局类
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(100, 100);
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.headerReferenceSize = CGSizeMake(kScreen_Width, CGFLOAT_MIN);
    flowLayout.footerReferenceSize = CGSizeMake(kScreen_Width, 10);
    
    //创建collectionView（并用布局类对象初始化集合视图）
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = DefaultColor;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerId"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerId"];
    [self.view addSubview:self.collectionView];
    
}


#pragma mark - collectionView代理方法
/**
 * 分区数
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

/**
 * 分区对应的Item个数
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return self.dataArray.count;
            break;
//        case 1:
//            return 3;
//            break;
//
        default:
            return 2;
            break;
    }
    
}

/**
 * cell的属性设置
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor whiteColor];
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
    [self.collectionView registerNib:[UINib nibWithNibName:@"YBImageBrowserCell" bundle:nil] forCellWithReuseIdentifier:CellIdentifier];
    YBImageBrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:self.dataArray[indexPath.row]]];
    
    return cell;
}


/**
 * cell点击事件
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MYLog(@"%@", indexPath);
    [self showBrowserForSimpleCaseWithIndex:indexPath.row];
}


/**
 * 返回分区的头和脚
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerId" forIndexPath:indexPath];
        view.backgroundColor = [UIColor grayColor];
        return view;
    }else{
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerId" forIndexPath:indexPath];
        view.backgroundColor = [UIColor grayColor];
        return view;
    }
    
}

- (void)showBrowserForSimpleCaseWithIndex:(NSInteger)index {
    
    NSMutableArray *browserDataArr = [NSMutableArray array];
    [self.dataArray enumerateObjectsUsingBlock:^(NSString *_Nonnull urlStr, NSUInteger idx, BOOL * _Nonnull stop) {
        YBImageBrowseCellData *data = [YBImageBrowseCellData new];
        data.url = [NSURL URLWithString:urlStr];
        data.sourceObject = [self sourceObjAtIdx:idx];
        [browserDataArr addObject:data];
    }];
    
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = browserDataArr;
    browser.currentIndex = index;
    [browser show];
}

- (id)sourceObjAtIdx:(NSInteger)idx {
    YBImageBrowserCell *cell = (YBImageBrowserCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]];
    return cell ? cell.imageV : nil;
}

@end









