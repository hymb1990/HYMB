//
//  CollectionViewController.m
//  TracePlatform
//
//  Created by lym on 2017/5/2.
//  Copyright © 2017年 ehsureTec. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation CollectionViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
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
    flowLayout.itemSize = CGSizeMake(150, 100);
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
    return 10;
}

/**
 * 分区对应的Item个数
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 3;
            break;
            
        default:
            return 2;
            break;
    }

}

/**
 * cell的属性设置
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}


/**
 * cell点击事件
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MYLog(@"%@", indexPath);
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

@end
