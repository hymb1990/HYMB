//
//  RefreshCell.h
//  HYMB
//
//  Created by sgft on 2018/9/7.
//  Copyright © 2018年 hymb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshModel.h"
@interface RefreshCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) RefreshModel *model;
@end
