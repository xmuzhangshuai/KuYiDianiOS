//
//  chartsTableViewCell.h
//  KuDian
//
//  Created by 黄明族 on 16/6/20.
//  Copyright © 2016年 黄明族. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface chartsTableViewCell : UITableViewCell
//排行榜名次
@property (nonatomic, strong)UILabel *rankNumLabel;
//排行榜的头像
@property (nonatomic, strong)UIImageView *rankImageView;
//名字
@property (nonatomic, strong)UILabel *NameLabel;
//排行的范围
@property (nonatomic, strong)UILabel *rankScopeLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;


@end
