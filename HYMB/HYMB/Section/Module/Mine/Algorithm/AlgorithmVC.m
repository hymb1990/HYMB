//
//  AlgorithmVC.m
//  HYMB
//
//  Created by 863Soft on 2019/5/16.
//  Copyright © 2019 hymb. All rights reserved.
//

#import "AlgorithmVC.h"
#import "MyAlertView.h"

@interface AlgorithmVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation AlgorithmVC

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = @[@"OC-排序算法总结",@"",@"",];
    
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
    
    self.title = @"算法";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    self.tableView.backgroundColor = DefaultColor;
    [self.view addSubview:self.tableView];
    
}

#pragma mark - tableView代理方法
/**
 * tableView的分区数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


/**
 * tableView分区里的行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    switch (section) {
//        case 0:
//            return 1;
//            break;
//        case 1:
//            return 2;
//            break;
//
//        default:
//            return 1;
//            break;
//    }
    
    return self.dataArr.count;
}

/**
 * tableViewCell的相关属性
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    //修改cell属性，使其在选中时无色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *title = self.dataArr[indexPath.row];
    
    cell.textLabel.text = title;
    
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
    
     UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell.textLabel.text isEqualToString:@"OC-排序算法总结"]) {
        
        NSMutableArray *arr = [NSMutableArray arrayWithObjects:@1,@4,@2,@3,@5,nil];
        [self sortWithArr:arr];
        
    }
}



#pragma mark - 排序算法总结
-(void)sortWithArr:(NSMutableArray *)arr
{
    
    NSString *mes1 = [NSString stringWithFormat:@"排序前：%@", arr];
    
    //1.冒泡排序
    [self popSortWithArr:arr];
    
//    //2.选择排序
//    [self chooseSortWithArr:arr];
    
//    //3.插入排序
//    [self insetSortWithArr:arr];
//    InsetSort (arr, 0);
    
//    //4.快速排序 （有问题）
//    [self quickSequence:arr andleft:0 andright:(int)arr.count];
    
//    //5.希尔排序
//    [self shellSort:arr];
    
//    //6.堆排序
//    [self heapSort:arr];
    
    NSString *mes2 = [NSString stringWithFormat:@"排序后：%@", arr];
    
    
    
    NSString *mes = [NSString stringWithFormat:@"%@，%@", mes1, mes2];
    
    MyAlertView *alertView = [[MyAlertView alloc] initWithTitle:@"数据" message:mes];
    alertView.cancelBlock = ^{
        MYLog(@"取消");
    };
    alertView.confirmBlock = ^{
        MYLog(@"确定");
    };
    [alertView show];
    
}

//冒泡排序
- (void)popSortWithArr:(NSMutableArray *)arr {
    
        //普通排序-交换次数较多
        for (int i = 0; i < arr.count; ++i) {
            for (int j = 0; j < arr.count-1-i; ++j) {
                if ([arr[j+1] intValue] < [arr[j] intValue]) {
                    [arr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                }
            }
        }
    
    //    //优化后算法-从第一个开始排序，空间复杂度相对更大一点
    //    for (int i = 0; i < arr.count; ++i) {
    //        bool flag=false;
    //        //遍历数组的每一个`索引`（不包括最后一个,因为比较的是j+1）
    //        for (int j = 0; j < arr.count-1-i; ++j) {
    //
    //            //根据索引的`相邻两位`进行`比较`
    //            if ([arr[j+1] intValue] < [arr[j] intValue]) {
    //                flag = true;
    //                [arr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
    //            }
    //        }
    //        if (!flag) {
    //            break;//没发生交换直接退出，说明是有序数组
    //        }
    //    }
    
    //    //优化后算法-从最后一个开始排序
    //    for (int i = 0; i <arr.count; ++i) {
    //        bool flag=false;
    //        //遍历数组的每一个`索引`（不包括最后一个,因为比较的是j+1）
    //        for (int j = (int)arr.count-1; j >i; --j) {
    //
    //            //根据索引的`相邻两位`进行`比较`
    //            if ([arr[j-1] intValue] > [arr[j] intValue]) {
    //                flag = true;
    //                [arr exchangeObjectAtIndex:j withObjectAtIndex:j-1];
    //            }
    //        }
    //        if (!flag) {
    //            break;//没发生交换直接退出，说明是有序数组
    //        }
    //    }
}

//选择排序
- (void)chooseSortWithArr:(NSMutableArray *)arr {
//    //选择排序-依次找出剩余元素最小值 ,对于长度为 N 的数组,选择排序需要大约 N^2 次比较和 N 次交换
//    for (int i = 0; i<arr.count; i++) {
//        int min = i;
//        int a = [arr[i] intValue];
//        for (int j = i+1; j<arr.count; j++) {
//            if ([arr[j] intValue]<a) {
//                min = j;
//                a = [arr[j] intValue];
//            }
//        }
//        [arr exchangeObjectAtIndex:i withObjectAtIndex:min];
//    }
    
        //或者下面方法，就是交换次数比较多
        for (int i = 0; i<arr.count; i++) {
            for (int j = i+1; j<arr.count; j++) {
                if ([arr[j] intValue]<[arr[i] intValue]) {
                    [arr exchangeObjectAtIndex:i withObjectAtIndex:j];
                }
            }
        }
}

//插入排序
- (void)insetSortWithArr:(NSMutableArray *)arr {
    for (int i = 1; i<arr.count; i++) {
        int a=[arr[i] intValue];
        int k = i-1;
        while (k>=0&&[arr[k] intValue]>a) {
            arr[k + 1] = arr[k];
            k-=1;
        }
        arr[k+1] = [NSString stringWithFormat:@"%d",a];
        NSLog(@"%@",arr);
    }
}

//插入排序
NSMutableArray *InsetSort(NSMutableArray *mArray, NSInteger start) {
    
    if (start == mArray.count) {
        return mArray;
    }
    for (NSInteger i = start; i > 0; i --) {
        if ([mArray[i] intValue] < [mArray[i-1] intValue]) {
            int temp = [mArray[i] intValue];
            int k =  (int)(i - 1);
            
            while (k >= 0 && [mArray[k] intValue] > temp) {
                mArray[k + 1] = mArray[k];
                k -= 1;
            }
            mArray[k+1] = [NSString stringWithFormat:@"%d",temp];
        }
    }
    InsetSort(mArray, start + 1);
    return mArray;
}

//快速排序
-(void)quickSequence:(NSMutableArray *)arr andleft:(int)left andright:(int)right
{
    if (left >= right) {//如果数组长度为0或1时返回
        return ;
    }
    int key = [arr[left] intValue];
    int i = left;
    int j = right;
    
    while (i<j){
        while (i<j&&[arr[j] intValue]>=key) {
            j--;
        }
        arr[i] = arr[j];
        
        while (i<j&&[arr[i] intValue]<=key) {
            i++;
        }
        arr[j] = arr[i];
    }
    arr[i] = [NSString stringWithFormat:@"%d",key];
    [self quickSequence:arr andleft:left andright:i-1];
    [self quickSequence:arr andleft:i+1 andright:right];
}

//希尔排序
//起始间隔值gap设置为总数的一半，直到gap==1结束
-(void)shellSort:(NSMutableArray *)list{
    int gap = (int)list.count / 2;
    while (gap >= 1) {
        for(int i = gap ; i < [list count]; i++){
            NSInteger temp = [[list objectAtIndex:i] intValue];
            int j = i;
            while (j >= gap && temp < [[list objectAtIndex:(j - gap)] intValue]) {
                [list replaceObjectAtIndex:j withObject:[list objectAtIndex:j-gap]];
                j -= gap;
            }
            [list replaceObjectAtIndex:j withObject:[NSNumber numberWithInteger:temp]];
        }
        gap = gap / 2;
    }
    //或者
    //    while (gap >= 1) {
    //        for(int i = gap ; i < [list count]; i++){
    //            int temp = [list[i] intValue];
    //            int j = i;
    //            while (j >= gap && temp < [list[j - gap] intValue]) {
    //                [list exchangeObjectAtIndex:j withObjectAtIndex:j-gap];
    //                j -= gap;
    //            }
    //        }
    //        gap = gap / 2;
    //    }
}

//堆排序
- (void)heapSort:(NSMutableArray *)list
{
    NSInteger i ,size;
    size = list.count;
//    //找出最大的元素放到堆顶
//    for (i= list.count/2; i>=0; i--) {
//        [self createBiggesHeap:list withSize:size beIndex:i];
//    }
    //找出最大的元素放到堆顶
    for (i= list.count/2-1; i>=0; i--) {
        [self createBiggesHeap:list withSize:size beIndex:i];
    }
    
    
    while(size > 0){
        [list exchangeObjectAtIndex:size-1 withObjectAtIndex:0]; //将根(最大) 与数组最末交换
        size -- ;//树大小减小
        [self createBiggesHeap:list withSize:size beIndex:0];
    }
    NSLog(@"%@",list);
}


- (void)createBiggesHeap:(NSMutableArray *)list withSize:(NSInteger) size beIndex:(NSInteger)element
{
    NSInteger lchild = element *2 + 1,rchild = lchild+1; //左右子树
    while (rchild < size) { //子树均在范围内
        if (list[element]>=list[lchild] && list[element]>=list[rchild]) return; //如果比左右子树都大，完成整理
        if (list[lchild] > list[rchild]) { //如果左边最大
            [list exchangeObjectAtIndex:element withObjectAtIndex:lchild]; //把左面的提到上面
            element = lchild; //循环时整理子树
        }else{//否则右面最大
            [list exchangeObjectAtIndex:element withObjectAtIndex:rchild];
            element = rchild;
        }
        
        lchild = element * 2 +1;
        rchild = lchild + 1; //重新计算子树位置
    }
    //只有左子树且子树大于自己
    if (lchild < size && list[lchild] > list[element]) {
        [list exchangeObjectAtIndex:lchild withObjectAtIndex:element];
    }
}

@end



