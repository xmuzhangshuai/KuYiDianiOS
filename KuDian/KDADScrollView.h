//
//  KDADScrollView.h
//  KuDian
//
//  Created by 黄明族 on 16/6/2.
//  Copyright © 2016年 黄明族. All rights reserved.
//

#import <UIKit/UIKit.h>

/** block 传递点击的广告图片的index*/
typedef void(^imageClickBlock)(NSInteger index);


@interface KDADScrollView : UIView
/**
 *  轮播的ScrollView
 */
@property(strong,nonatomic) UIScrollView * direct;
/**
 *  轮播的页码
 */
@property(strong,nonatomic) UIPageControl *pageVC;
/**
 *  轮播的时间
 */
@property(assign,nonatomic) CGFloat time;


/**
 *  初始化图片轮播图方法
 *
 *  @param frame          坐标
 *  @param imageNameArray 图片数组
 *  @param clickBlock     点击事件的Block回调
 *
 *  @return 当前对象
 */
+(instancetype)direcWithtFrame:(CGRect)frame
                      ImageArr:(NSArray *)imageNameArray
            AndImageClickBlock:(imageClickBlock)clickBlock;

//开始定时器
-(void)beginTimer;

//销毁定时器
-(void)stopTimer;



@end
