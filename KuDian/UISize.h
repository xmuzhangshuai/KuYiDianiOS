//
//  UISize.h
//  KuDian
//
//  Created by 黄明族 on 16/5/31.
//  Copyright © 2016年 黄明族. All rights reserved.
//

#ifndef UISize_h
#define UISize_h

/** 界面的尺寸大小*/
#define SCREEN_FRAME [UIScreen mainScreen].bounds
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_CENTER_X 0.5*SCREEN_WIDTH
#define SCREEN_CENTER_Y 0.5*SCREEN_HEIGHT
/** 侧拉栏界面的图标大小*/
#define AVATARIMAGE_WIDTH               0.16*SCREEN_WIDTH
#define AVATARIMAGE_HEIGHT              AVATARIMAGE_WIDTH
#define NAMELABEL_WIDTH                 0.225*SCREEN_WIDTH
#define NAMELABEL_HEIGHT                0.6*AVATARIMAGE_HEIGHT
#define IDENTIFICATIONLABEL_WIDTH       (0.8*SCREEN_WIDTH-AVATARIMAGE_WIDTH)/5*4
#define IDENTIFICATIONLABEL_HEIGHT      0.4*AVATARIMAGE_HEIGHT
#define INFOTABLEVIEW_HEIGHT            0.541*SCREEN_HEIGHT
#define INFOTABLEVIEW_WIDTH             SCREEN_WIDTH*0.83

/** 登录界面的frame*/
#define PHONETF_X   0.1*SCREEN_WIDTH
#define PHONETF_Y

#define PHONETF_WIDTH   0.62*SCREEN_WIDTH
#define PHONETF_HEIGHT  0.0562*SCREEN_HEIGHT
#define PHONETF_CENTER_X    0.41*SCREEN_WIDTH
#define PHONETF_CENTER_Y    0.1997*SCREEN_HEIGHT

#define VERIFYBUTTON_WIDTH  0.16*SCREEN_WIDTH
#define VERIFYBUTTON_HEIGHT 0.0562*SCREEN_HEIGHT
#define VERIFYBUTTON_CENTER_X   0.82*SCREEN_WIDTH

#define VERIFYTF_WIDTH  0.8*SCREEN_WIDTH
#define VERIFYTF_CENTER_Y   0.2762*SCREEN_HEIGHT

#define STARTBUTTON_CENTER_Y    0.352*SCREEN_HEIGHT

/** 导航栏的大小*/


/** 应用中的缓存对象*/
#define UserDefaultsIsLogin @"UserDefaultsIsLogin"
#define UserDefaultsName @"UserDefaultsName"

#endif /* UISize_h */
