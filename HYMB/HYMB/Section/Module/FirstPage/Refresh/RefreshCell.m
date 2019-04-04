//
//  RefreshCell.m
//  HYMB
//
//  Created by sgft on 2018/9/7.
//  Copyright © 2018年 hymb. All rights reserved.
//

#import "RefreshCell.h"

@implementation RefreshCell


+(instancetype)cellWithTableView:(UITableView *)tableView;
{
    
    [tableView registerNib:[UINib nibWithNibName:@"RefreshCell" bundle:nil] forCellReuseIdentifier:@"cellId"];
//    RefreshCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    RefreshCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    //修改cell属性，使其在选中时无色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)setModel:(RefreshModel *)model {
    
    _model = model;
    
    self.titleL.text = model.title;
    NSURL *url = [NSURL URLWithString:model.cover_image_url];
    [self.imageV sd_setImageWithURL:url];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
