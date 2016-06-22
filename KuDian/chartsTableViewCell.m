//
//  chartsTableViewCell.m
//  KuDian
//
//  Created by 黄明族 on 16/6/20.
//  Copyright © 2016年 黄明族. All rights reserved.
//

#import "chartsTableViewCell.h"
#import "UISize.h"
#import "Masonry.h"



@implementation chartsTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identity = @"StoreDetailCell";
    chartsTableViewCell *detailCell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (detailCell == nil) {
        detailCell = [[chartsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    return detailCell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.rankNumLabel = [[UILabel alloc] init];
        [self.rankNumLabel setFont:[UIFont systemFontOfSize:17]];
        self.rankImageView = [[UIImageView alloc] init];
        self.rankScopeLabel = [[UILabel alloc] init];
        [self.rankScopeLabel setFont:[UIFont systemFontOfSize:9]];
        self.NameLabel = [[UILabel alloc] init];
        [self.NameLabel setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:self.rankNumLabel];
        [self.contentView addSubview:self.rankImageView];
        [self.contentView addSubview:self.NameLabel];
        [self.contentView addSubview:self.rankScopeLabel];

        [self.rankNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).with.offset(10);
            make.top.equalTo(self.contentView).with.offset(30);
            make.width.mas_equalTo(@30);
        }];
        [self.rankImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.rankNumLabel.mas_right).with.offset(20);
            make.top.equalTo(self.contentView).with.offset(10);
            make.width.equalTo(self.contentView).multipliedBy(0.13);
            make.height.equalTo(self.contentView.mas_width).multipliedBy(0.13);
        }];
        [self.NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.rankImageView.mas_right).offset(30);
            make.top.equalTo(self.contentView).offset(20);
            make.width.equalTo(self.contentView).multipliedBy(0.6);
        }];
        [self.rankScopeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.NameLabel.mas_bottom).offset(2);
            make.left.equalTo(self.rankImageView.mas_right).offset(30);
            make.width.equalTo(self.contentView).multipliedBy(0.6);
        }];
        
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
