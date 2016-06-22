//
//  MarkTableViewCell.m
//  KuDian
//
//  Created by 黄明族 on 16/6/20.
//  Copyright © 2016年 黄明族. All rights reserved.
//

#import "MarkTableViewCell.h"
#import "Masonry.h"
#import "UISize.h"

@implementation MarkTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identity = @"StoreDetailCell";
    MarkTableViewCell *detailCell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (detailCell == nil) {
        detailCell = [[MarkTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    return detailCell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.storeImageView = [[UIImageView alloc] init];
        self.storeName = [[UILabel alloc] init];
        [self.storeName setFont:[UIFont systemFontOfSize:13]];
        self.storeName.numberOfLines = 0;
        self.storeLocation = [[UILabel alloc] init];
        [self.storeLocation setFont:[UIFont systemFontOfSize:9]];
        self.productNum = [[UILabel alloc] init];
        [self.productNum setFont:[UIFont systemFontOfSize:9]];
        
        self.MarkImage = [[UIImageView alloc] init];
        [self.contentView addSubview:self.storeImageView];
        [self.contentView addSubview:self.storeName];
        [self.contentView addSubview:self.storeLocation];
        [self.contentView addSubview:self.productNum];
        [self.contentView addSubview:self.MarkImage];
        
        
        [self.storeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).with.offset(5);
            make.left.equalTo(self.contentView).with.offset(0.1*SCREEN_WIDTH);
            make.bottom.equalTo(self.contentView).with.offset(-5);
            make.width.equalTo(self.contentView).multipliedBy(0.17);
        }];
        [self.storeName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).with.offset(10);
            make.left.equalTo(self.storeImageView.mas_right).with.offset(0.2*SCREEN_WIDTH);
            make.size.mas_equalTo(CGSizeMake(0.8*SCREEN_WIDTH, 10));
        }];
        [self.storeLocation mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.storeImageView.mas_right).with.offset(0.2*SCREEN_WIDTH);
            make.top.equalTo(self.storeName.mas_bottom).with.offset(15);
            //        make.size.mas_equalTo(CGSizeMake(0.5*SCREEN_WIDTH, 10));
        }];
        [self.productNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.storeImageView.mas_right).with.offset(0.2*SCREEN_WIDTH);
            make.top.equalTo(self.storeLocation.mas_bottom).with.offset(2);
            make.size.mas_equalTo(CGSizeMake(0.5*SCREEN_WIDTH, 10));
        }];
        [self.MarkImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-0.1*SCREEN_WIDTH);
            make.top.equalTo(self.storeName.mas_bottom).offset(5);
            make.width.mas_equalTo(@20);
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
