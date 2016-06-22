//
//  MarkTableViewCell.h
//  KuDian
//
//  Created by 黄明族 on 16/6/20.
//  Copyright © 2016年 黄明族. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarkTableViewCell : UITableViewCell


@property (nonatomic, strong)UIImageView *storeImageView;
@property (nonatomic, strong)UILabel *storeName;
@property (nonatomic, strong)UILabel *storeLocation;
@property (nonatomic, strong)UILabel *productNum;
@property (nonatomic, strong)UIImageView *MarkImage;


+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
