//
//  StoreDetailTableViewCell.h
//  KuDian
//
//  Created by 黄明族 on 16/6/20.
//  Copyright © 2016年 黄明族. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreDetailTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView *productImageView;
@property (nonatomic, strong)UILabel *productName;
@property (nonatomic, strong)UILabel *scoreNum;
@property (nonatomic, strong)UILabel *lsChargeNumLabel;
@property (nonatomic, strong)UIImageView *discountImageView;


+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
