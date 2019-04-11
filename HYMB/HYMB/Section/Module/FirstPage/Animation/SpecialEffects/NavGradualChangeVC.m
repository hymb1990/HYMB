//
//  NavGradualChangeVC.m
//  HYMB
//
//  Created by 863Soft on 2019/4/11.
//  Copyright © 2019 hymb. All rights reserved.
//

#import "NavGradualChangeVC.h"

@interface NavGradualChangeVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, retain) UIImageView *zoomImageView;

@end

@implementation NavGradualChangeVC

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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //设置透明导航栏
    self.navigationController.navigationBar.subviews.firstObject.alpha = 0.0;
}

#pragma mark - 构建视图
- (void)setUI {
    
    self.title = @"导航条渐变";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置透明导航栏
    UIView *barImageView = self.navigationController.navigationBar.subviews.firstObject;
    barImageView.alpha = 0.0;
    
    //添加tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -NaviH, kScreen_Width, kScreen_Height) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    self.tableView.backgroundColor = DefaultColor;
    [self.view addSubview:self.tableView];
    
    
    //添加headerV
    UIView *headerV = [UIView new];
    headerV.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_WIDTH/622*438);
    
    self.zoomImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"magiGifts"]];
    self.zoomImageView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_WIDTH/622*438);
    //contentMode = UIViewContentModeScaleAspectFill时，高度改变宽度也跟着改变
    self.zoomImageView.contentMode = UIViewContentModeScaleAspectFill;
    [headerV addSubview:self.zoomImageView];
    
    self.tableView.tableHeaderView = headerV;
    
}

#pragma mark - tableView代理方法
/**
 * tableView的分区数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}


/**
 * tableView分区里的行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
            
        default:
            return 1;
            break;
    }
}

/**
 * tableViewCell的相关属性
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    //修改cell属性，使其在选中时无色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

/**
 * tableViewCell的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

/**
 * 分区头的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

/**
 * 分区脚的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

/**
 * 分区头
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = DefaultColor;
    return view;
}

/**
 * 分区脚
 */
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = DefaultColor;
    return view;
}


/**
 * tableViewCell的点击事件
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MYLog(@"%@", indexPath);
}

#pragma mark - 下拉图片放大、导航条渐变
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //下拉图片放大
    CGFloat y = scrollView.contentOffset.y;
    if (y < 0) {
        CGRect frame = self.zoomImageView.frame;
        frame.origin.y = y;
        frame.size.height = -y+kSCREEN_WIDTH/622*438;
        self.zoomImageView.frame = frame;
    }
    

    //导航条渐变
    CGFloat minAlphaOffset = 0;
    CGFloat maxAlphaOffset = kSCREEN_WIDTH/622*438-NaviH;
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
    //    barImageView = self.navigationController.navigationBar.subviews.firstObject；
    //    MYLog(@"%f", offset);
    //    MYLog(@"%f", alpha);
    self.navigationController.navigationBar.subviews.firstObject.alpha = alpha;
    
}

//#pragma mark - 导航条渐变
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat minAlphaOffset = - 64;
//    CGFloat maxAlphaOffset = 200;
//    CGFloat offset = scrollView.contentOffset.y;
//    CGFloat alpha = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
//    //    barImageView = self.navigationController.navigationBar.subviews.firstObject；
//    self.navigationController.navigationBar.subviews.firstObject.alpha = alpha;
//}

@end







