//
//  LTPickerView.m
//  protoBuffer
//
//  Created by chenfujie on 15/11/20.
//  Copyright © 2015年 Meeno04. All rights reserved.
//

#define LTColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define Screen_Width [[UIScreen mainScreen] bounds].size.width
#define Screen_Height [[UIScreen mainScreen] bounds].size.height

#import "LTPickerView.h"
@interface LTPickerView()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIPickerView *myPickerView;
@property (weak, nonatomic) IBOutlet UIToolbar *myToolbar;
@property (weak, nonatomic) IBOutlet UIButton *titleBtn;
@property (nonatomic,strong) UIWindow* window;
@property (nonatomic,strong) UITapGestureRecognizer* gesture;
@property (nonatomic,strong) UIView* view;
@end

@implementation LTPickerView

-(instancetype)init{
    if (self = [super init]) {
    }
    return self;
}

-(void)awakeFromNib
{
    [self loadNibFile];
}

-(void)loadNibFile
{
    [[NSBundle mainBundle]loadNibNamed:@"LTPickerView" owner:self options:nil];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.contentView.frame = self.bounds;
    
}

-(void)loadUI{
    
    [self addSubview:self.contentView];
    if (self.title) {
        [self.titleBtn setTitle:self.title forState:UIControlStateNormal];
    }
    
    [self.myToolbar.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIBarButtonItem* itemBtn = (UIBarButtonItem*)obj;
        NSDictionary * attributes = @{NSForegroundColorAttributeName: [UIColor blackColor]};
        [itemBtn setTitleTextAttributes:attributes forState:UIControlStateNormal];
    }];
    
    _window = [UIApplication sharedApplication].keyWindow;
    //给window加点击手势关闭self
    _gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
    [_window addGestureRecognizer:_gesture];
    _view = [[UIView alloc]initWithFrame:_window.bounds];
    _view.backgroundColor = LTColor(0, 0, 0, 0.2);
    [_window addSubview:_view];
    [_view addSubview:self];
    self.frame = CGRectMake(0, Screen_Height, Screen_Width, 250);
}

#pragma - 懒加载
-(NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
}

#pragma - 数据源方法
// 一共多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// 第component列显示多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataSource.count;
}

#pragma - 代理方法
// 第component列的第row行显示什么文字
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.dataSource[row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 35;
}

#pragma mark 打开与关闭方法
-(void)show{
    if (!self.dataSource.count) {
        return;
    }
    [self loadNibFile];
    [self loadUI];
    self.myPickerView.dataSource = self;
    self.myPickerView.delegate = self;
    if ([self.dataSource containsObject:self.defaultStr]) {
        NSInteger selectRow = [self.dataSource indexOfObject:self.defaultStr];
        [self.myPickerView selectRow:selectRow inComponent:0 animated:NO];
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, Screen_Height - 250, Screen_Width, 250);
    }];
    
}

-(void)close{
    //移除点击手势
    [_window removeGestureRecognizer:_gesture];
    _gesture = nil;
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(0, Screen_Height, Screen_Width, 250);
    } completion:^(BOOL finished) {
        [_view removeFromSuperview];
    }];
}

#pragma mark 确定
- (IBAction)clockDetermine:(id)sender {
    NSString* str = [self pickerView:self.myPickerView titleForRow:[self.myPickerView selectedRowInComponent:0] forComponent:0];
    if (self.block) {
        self.block(self,str,[self.myPickerView selectedRowInComponent:0]);
    }
    [self close];
}

#pragma mark 取消
- (IBAction)cancel:(id)sender {
    [self close];
}


@end
