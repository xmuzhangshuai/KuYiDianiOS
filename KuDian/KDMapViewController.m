//
//  KDMapViewController.m
//  KuDian
//
//  Created by 黄明族 on 16/6/3.
//  Copyright © 2016年 黄明族. All rights reserved.
//
//地图界面
#import "KDMapViewController.h"
//引入地图功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Base/BMKTypes.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件


#import "UISize.h"

@interface KDMapViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate>

@property (nonatomic, strong)BMKMapView *mapView;
@property (nonatomic, strong)BMKLocationService *locService;

@end

@implementation KDMapViewController

-(void)UIInit {
    self.mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        //ios 7之后导航栏透明化
        self.navigationController.navigationBar.translucent = NO;
    }
   
    
    [self.view insertSubview:self.mapView atIndex:0];
}

-(void)UINavigationInit {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self UIInit];
    [self UINavigationInit];
    // 初始化百度位置服务
    [self initBMLocationService];
    // 设置MapView的一些属性
    [self setMapViewProperty];
    
}

-(void)initBMLocationService {
    self.locService = [[BMKLocationService alloc] init];
    // 设置距离过滤，表示每移动10更新一次位置
    self.locService.distanceFilter = 6;
    // 设置定位精度
    self.locService.desiredAccuracy=kCLLocationAccuracyBest;
    self.locService.delegate = self;
}

-(void)setMapViewProperty {
    
    //启动LocationService
    [self.locService startUserLocationService];
    
    //打开定位图层
    self.mapView.showsUserLocation = YES;
    
    // 设置定位模式
    self.mapView.userTrackingMode = BMKUserTrackingModeNone;

    // 允许旋转地图
    self.mapView.rotateEnabled = YES;
    
    // 显示比例尺
    self.mapView.showMapScaleBar = YES;
    //比例尺的位置
    self.mapView.mapScaleBarPosition = CGPointMake(self.view.frame.size.width - 50, self.view.frame.size.height - 50);
    
    // 定位图层自定义样式参数
    BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc]init];
    displayParam.isRotateAngleValid = NO;//跟随态旋转角度是否生效
    displayParam.isAccuracyCircleShow = NO;//精度圈是否显示
    displayParam.locationViewOffsetX = 0;//定位偏移量(经度)
    displayParam.locationViewOffsetY = 0;//定位偏移量（纬度）
    [self.mapView updateLocationViewWithParam:displayParam];
}


#pragma mark - BMKLocationDelegate
/** 用户方向更新*/
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    
    [self.mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [self.mapView updateLocationData:userLocation];
    
    
//    self.mapView.maxZoomLevel = 17.4;
//    self.mapView.minZoomLevel = 16;
//    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(39.923018, 116.404440);
//    BMKCoordinateSpan span = BMKCoordinateSpanMake(0.013142, 0.011678);
//    self.mapView.limitMapRegion = BMKCoordinateRegionMake(center, span);
//    self.mapView.overlookEnabled = NO;
//    self.mapView.rotateEnabled = NO;//禁用旋转手势
//    self.mapView.mapType = BMKMapTypeNone;
    /** 以用户目前的位置 作为地图的中心点 并设定显示的扇区*/
//    BMKCoordinateRegion adjustRegion = [self.mapView regionThatFits:BMKCoordinateRegionMake(userLocation.location.coordinate, BMKCoordinateSpanMake(0.002, 0.002))];
//    [self.mapView setRegion:adjustRegion animated:YES];
    
    /** 判断用户是否在户外*/
    if (userLocation.location.horizontalAccuracy > kCLLocationAccuracyNearestTenMeters) {//室内使用基站或wifi，精度较GPS低
        return;
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [self.mapView viewWillAppear];
    self.mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    self.locService.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil; // 不用时，置nil
    self.locService.delegate = nil;
}


/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}


- (void)dealloc {
    if (self.mapView) {
        self.mapView = nil;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
