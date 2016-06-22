//
//  KDLocalScrollView.h
//  KuDian
//
//  Created by 黄明族 on 16/6/14.
//  Copyright © 2016年 黄明族. All rights reserved.
//

#import <UIKit/UIKit.h>

//定义一个block用来回传点击的index
typedef void (^ClickScrollViewBlock)(NSInteger index);

@interface KDLocalScrollView : UIView

@property (nonatomic, strong)UIScrollView *localScrollView;


+(instancetype)localScrollViewWithFrame:(CGRect)frame ImageArr:(NSArray *)localImageArr andClickScrollViewBlock:(ClickScrollViewBlock)ClickBlock;

@end
