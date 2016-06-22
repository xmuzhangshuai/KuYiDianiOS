//
//  KDStoreDetailViewController.h
//  KuDian
//
//  Created by 黄明族 on 16/6/3.
//  Copyright © 2016年 黄明族. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KDStoreDetailViewController : UIViewController

/** 对外属性，商家点击的index*/
@property (nonatomic, strong)NSIndexPath *indexPath;

@property (nonatomic, strong)NSString *storeName;


@end
