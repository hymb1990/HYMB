//
//  LoadingAnimationVC.m
//  HYMB
//
//  Created by sgft on 2018/9/10.
//  Copyright © 2018年 hymb. All rights reserved.
//

#import "LoadingAnimationVC.h"
#import "RefreshModel.h"
#import "RefreshCell.h"
#import "SFWaterLoadingView.h"
@interface LoadingAnimationVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger pageNumber;//页码
@property (nonatomic, strong) NSMutableArray *dataArr;//数据
@property (nonatomic, strong) NoDataBackgroundView *noDataView;
@property (nonatomic, strong) SFWaterLoadingView *loadingView;

@end

@implementation LoadingAnimationVC

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    
    self.dataArr = [NSMutableArray array];
    
    [self setRefreshHeaderAndFooter];
    //    [self.tableView.mj_header beginRefreshing];
    [self loadNewData];
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

- (void)setRefreshHeaderAndFooter {
    
    __weak typeof(self)weakself = self;
    //    //头
    //    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    //        [weakself loadNewData];
    //    }];
    //    //    header.lastUpdatedTimeLabel.hidden = YES;
    //    self.tableView.mj_header = header;
    //脚
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself loadMoreData];
    }];
    self.tableView.mj_footer = footer;
}


- (void)loadNewData {
    self.pageNumber = 1;
    // 请求地址
    NSString *url = api_v1_channels_111_items;
    // 请求参数
    NSDictionary *parameters = @{
                                 @"limit":@"20",
                                 @"offset":[NSString stringWithFormat:@"%ld", self.pageNumber],
                                 };
    
   [[NetworkService sharedNetworkService] getRequestWithTarget:self url:url parameters:parameters showHud:YES block:^(id responseObject, NSError *error) {
//        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer resetNoMoreData];
       int code = [responseObject[@"code"] intValue];
       if (code == 200) {
            [self.dataArr removeAllObjects];
            self.loadingView.hidden = YES;
            if ([responseObject[@"data"][@"items"] count] > 0) {
                self.noDataView.hidden = YES;
                for (NSDictionary *dict in responseObject[@"data"][@"items"]) {
                    RefreshModel *model = [RefreshModel mj_objectWithKeyValues:dict];
                    [self.dataArr addObject:model];
                    self.pageNumber = self.pageNumber + 1;
                }
            } else {
                self.noDataView.hidden = NO;
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        
            [self.tableView reloadData];
        }else {
            self.loadingView.hidden = NO;
        }
    }];
}

- (void)loadMoreData {
    
    self.loadingView.hidden = YES;
    
    // 请求地址
    NSString *url = api_v1_channels_111_items;
    // 请求参数
    NSDictionary *parameters = @{
                                 @"limit":@"20",
                                 @"offset":[NSString stringWithFormat:@"%ld", self.pageNumber],
                                 };
    
   [[NetworkService sharedNetworkService] getRequestWithTarget:self url:url parameters:parameters showHud:YES block:^(id responseObject, NSError *error) {
        [self.tableView.mj_footer endRefreshing];
       int code = [responseObject[@"code"] intValue];
       if (code == 200) {
            if ([responseObject[@"data"][@"items"] count]> 0) {
                for (NSDictionary *dict in responseObject[@"data"][@"items"]) {
                    RefreshModel *model = [RefreshModel mj_objectWithKeyValues:dict];
                    [self.dataArr addObject:model];
                    self.pageNumber = self.pageNumber + 1;
                }
                
                [self.tableView reloadData];
            }else {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
    }];
    
}


#pragma mark - 构建视图
- (void)setUI {
    
    self.title = @"加载动画";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-NaviH) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = DefaultColor;
    [self.view addSubview:self.tableView];
    
    //无数据时背景
    self.noDataView = [[NoDataBackgroundView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-NaviH)];
    self.noDataView.tipsText = @"暂无数据";
    self.noDataView.hidden = YES;
    [self.tableView addSubview:self.noDataView];
    
    //加载数据时动画
    self.loadingView = [[SFWaterLoadingView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-NaviH)
                                                           title:@"哈哈"
                                                            font:[UIFont boldSystemFontOfSize:40]
                                                    showLoadNote:YES];
    [self.tableView addSubview:self.loadingView];
    
}

#pragma mark - tableView代理方法
/**
 * tableView的分区数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArr.count;
}


/**
 * tableView分区里的行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

/**
 * tableViewCell的相关属性
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RefreshCell" bundle:nil] forCellReuseIdentifier:@"cellId"];
    RefreshCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    //修改cell属性，使其在选中时无色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    RefreshModel *model = self.dataArr[indexPath.section];
    cell.titleL.text = model.title;
    NSURL *url = [NSURL URLWithString:model.cover_image_url];
    [cell.imageV sd_setImageWithURL:url];
    
    return cell;
}

/**
 * tableViewCell的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160;
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

@end









