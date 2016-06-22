//
//  AppDelegate.m
//  KuDian
//
//  Created by 黄明族 on 16/5/31.
//  Copyright © 2016年 黄明族. All rights reserved.
//

#import "AppDelegate.h"
#import "KDLeadViewController.h"
#import "KDLoginViewController.h"
#import "UISize.h"
#import "KDMainViewController.h"

@interface AppDelegate ()<BMKGeneralDelegate>

@end

@implementation AppDelegate {
    UINavigationController *navigationController;
    //引入百度地图模块
    BMKMapManager* _mapManager;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self initUserDefaults];
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    /** 引导页的设置*/
    NSUserDefaults *useDef = [NSUserDefaults standardUserDefaults];
    // 使用 NSUserDefaults 读取用户数据
    if (![useDef boolForKey:@"notFirst"]) {
        // 如果是第一次进入引导页
        navigationController = [[UINavigationController alloc] initWithRootViewController:[[KDLeadViewController alloc] init]];
    }
    else{
        // 否则直接进入应用
        navigationController = [[UINavigationController alloc] initWithRootViewController:[[KDLoginViewController alloc] init]];
    }
//    //全局设置导航栏的样式,背景图片
//    UINavigationBar * appearance = [UINavigationBar appearance];
//    UIImage *navBackgroundImg =[UIImage imageNamed:@"navClear.png"];
//    [appearance setBackgroundImage:navBackgroundImg forBarMetrics:UIBarMetricsDefault];

    //百度地图
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"0DLYurs7z4GExHP1fo67sYAZroe8sKvG"  generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    _window.rootViewController = navigationController;
    [_window makeKeyAndVisible];
    return YES;
}

#pragma mark - 私有方法

#pragma mark - 初始化缓存
-(void)initUserDefaults {
    if (![[NSUserDefaults standardUserDefaults] objectForKey:UserDefaultsIsLogin]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:UserDefaultsIsLogin];
    }
    if (![[NSUserDefaults standardUserDefaults] objectForKey:UserDefaultsName]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"张三" forKey:UserDefaultsName];
    }
    
    
}

#pragma mark - BMKGeneralDelegate
- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
