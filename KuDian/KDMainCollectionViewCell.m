
//
//  KDMainCollectionViewCell.m
//  KuDian
//
//  Created by 黄明族 on 16/6/3.
//  Copyright © 2016年 黄明族. All rights reserved.
//

//主界面cell

#import "KDMainCollectionViewCell.h"
#import "UISize.h"

@interface KDMainCollectionViewCell ()
@property (nonatomic , strong) UIImageView *imageShow;
@property (nonatomic, strong)UILabel *typeName;
@end


@implementation KDMainCollectionViewCell

-(instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageShow = [[UIImageView alloc] initWithFrame:CGRectZero];
        //设置Label 类别名称
        UILabel *typeName = [[UILabel alloc] init];
        typeName.numberOfLines = 0;
        typeName.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
        typeName.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:imageShow];
        [self.contentView addSubview:typeName];
        _imageShow = imageShow;
        _typeName = typeName;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _imageShow.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    _typeName.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
}

-(void)setImageName:(NSString *)imageName andContent:(NSString *)typeName {
    _imageShow.image = [UIImage imageNamed:imageName];
    _typeName.text = typeName;
}



@end
