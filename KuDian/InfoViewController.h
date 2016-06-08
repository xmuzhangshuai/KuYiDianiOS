//
//  InfoViewController.h
//  ElephantBike
//
//  Created by 黄杰锋 on 16/1/20.
//  Copyright © 2016年 黄杰锋. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol InfoViewControllerDelegate <NSObject>

- (void)getNextViewController:(id)nextViewController;
//增加一个参数判断是否是登出，还是退回到主页
- (void)removeFromSuperView:(BOOL)isLogOut;

@end
@interface InfoViewController : UIViewController

- (instancetype)initWithFrame:(CGRect)frame;

@property (weak) id<InfoViewControllerDelegate>delegate;

@end

