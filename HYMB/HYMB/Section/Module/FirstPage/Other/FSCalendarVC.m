//
//  FSCalendarVC.m
//  HYMB
//
//  Created by sgft on 2018/9/26.
//  Copyright © 2018年 hymb. All rights reserved.
//

#import "FSCalendarVC.h"
#import "FSCalendar.h"
@interface FSCalendarVC ()<FSCalendarDelegate, FSCalendarDataSource>
@property (weak , nonatomic) FSCalendar *calendar;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@end

@implementation FSCalendarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = DefaultColor;
    
    // In loadView(Recommended) or viewDidLoad
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 300)];
    calendar.dataSource = self;
    calendar.delegate = self;
    [self.view addSubview:calendar];
    self.calendar = calendar;
    
    
    
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did select date %@",[self.dateFormatter stringFromDate:date]);
//    [self configureVisibleCells];
}

- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did deselect date %@",[self.dateFormatter stringFromDate:date]);
//    [self configureVisibleCells];
}



@end
