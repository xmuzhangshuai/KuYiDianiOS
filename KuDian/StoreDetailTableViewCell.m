//
//  StoreDetailTableViewCell.m
//  KuDian
//
//  Created by 黄明族 on 16/6/20.
//  Copyright © 2016年 黄明族. All rights reserved.
//

#import "StoreDetailTableViewCell.h"
#import "UISize.h"
#import "Masonry.h"


@implementation StoreDetailTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identity = @"StoreDetailCell";
    StoreDetailTableViewCell *detailCell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (detailCell == nil) {
        detailCell = [[StoreDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    return detailCell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.productImageView = [[UIImageView alloc] init];
        self.productName = [[UILabel alloc] init];
        [self.productName setFont:[UIFont systemFontOfSize:13]];
        self.scoreNum = [[UILabel alloc] init];
        [self.scoreNum setFont:[UIFont systemFontOfSize:13]];
        self.lsChargeNumLabel = [[UILabel alloc] init];
        [self.lsChargeNumLabel setFont:[UIFont systemFontOfSize:13]];
        self.discountImageView = [[UIImageView alloc] init];
        
        [self.contentView addSubview:self.productName];
        [self.contentView addSubview:self.productImageView];
        [self.contentView addSubview:self.scoreNum];
        [self.contentView addSubview:self.lsChargeNumLabel];
        [self.contentView addSubview:self.discountImageView];
    
        [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).with.offset(10);
            make.left.equalTo(self.contentView).with.offset(0.1*SCREEN_WIDTH);
//            make.bottom.equalTo(self.contentView).with.offset(-10);
            make.height.equalTo(self.contentView.mas_width).multipliedBy(0.144);
            make.width.equalTo(self.contentView).multipliedBy(0.144);
        }];
        [self.productName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).with.offset(20);
            make.left.equalTo(self.productImageView.mas_right).with.offset(0.18*SCREEN_WIDTH);
            make.size.mas_equalTo(CGSizeMake(0.8*SCREEN_WIDTH, 10));
        }];
        [self.scoreNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.productImageView.mas_right).with.offset(0.18*SCREEN_WIDTH);
            make.top.equalTo(self.productName.mas_bottom).with.offset(10);
        }];
        [self.discountImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.scoreNum.mas_right).offset(5);
            make.top.equalTo(self.productName.mas_bottom).offset(5);
            make.width.mas_equalTo(15);
        }];
        [self.lsChargeNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.productImageView.mas_right).with.offset(0.18*SCREEN_WIDTH);
            make.top.equalTo(self.scoreNum.mas_bottom).with.offset(2);
        }];
//        self.productImageView.frame = CGRectMake(10, 10, 0.144*SCREEN_WIDTH, 0.144*SCREEN_WIDTH);
//        self.productName.frame = CGRectMake(0.2*SCREEN_WIDTH, 0.1*SCREEN_HEIGHT, 0.8*SCREEN_WIDTH, 10);
        
        
        
        
    }
    return self;
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
