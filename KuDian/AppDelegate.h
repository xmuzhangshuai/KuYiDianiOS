//
//  AppDelegate.h
//  KuDian
//
//  Created by 黄明族 on 16/5/31.
//  Copyright © 2016年 黄明族. All rights reserved.
//

#import <UIKit/UIKit.h>
//引入百度地图模块
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

@interface AppDelegate : UIResponder <UIApplicationDelegate, BMKGeneralDelegate>

@property (strong, nonatomic) UIWindow *window;
/** 是否登录*/
@property (nonatomic, assign)BOOL isLogin;
/** 是否身份认证*/
@property (nonatomic, assign)BOOL isIdentify;


@end

