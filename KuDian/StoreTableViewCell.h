//
//  StoreTableViewCell.h
//  KuDian
//
//  Created by king_hm on 16/6/12.
//  Copyright © 2016年 黄明族. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *StoreImageView;

@property (weak, nonatomic) IBOutlet UILabel *StoreNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *AdressLabel;

@property (weak, nonatomic) IBOutlet UILabel *NumOfProductLabel;

@property (weak, nonatomic) IBOutlet UIButton *MarkImageButton;

/*
 点击cell上的button，要跳转到指定的页面，传递的是经纬度。
 */


@end
