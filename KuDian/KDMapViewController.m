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
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
//自定义大头针以及弹出的泡泡
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>
//#import "sys/utsname.h"


#import "UISize.h"
#import "KDPersonalCenterViewController.h"
#import "KDStoreDetailViewController.h"
#import "KDScoreViewController.h"

@interface KDMapViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate>

@property (nonatomic, strong)BMKMapView *mapView;
@property (nonatomic, strong)BMKLocationService *locService;

@end

@implementation KDMapViewController {
    BOOL once;
    int j;
    BMKPointAnnotation *pointAnnotation;
}

-(void)UIInit {
    self.mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    once = YES;
    j = 0;
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        //ios 7之后导航栏透明化
        self.navigationController.navigationBar.translucent = NO;
    }
   
    [self.view insertSubview:self.mapView atIndex:0];
}

-(void)UINavigationInit {
     [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:198.0/255 green:238.0/255 blue:239.0/255 alpha:1]];
    //Logo
    UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-30, 20, 0.15*SCREEN_WIDTH, 0.05*SCREEN_HEIGHT)];
    titleImageView.image = [UIImage imageNamed:@"kuyidian"];
    titleImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = titleImageView;
    //跳转到个人中心界面
    UIBarButtonItem *personalButton;
    personalButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"personalmain"] style:UIBarButtonItemStylePlain target:self action:@selector(getToPersonal)];
    personalButton.tintColor = [UIColor colorWithRed:75.0/255 green:73.0/255 blue:70.0/255 alpha:1];
    
    //侧拉栏
    UIBarButtonItem *backButton;
    backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(getbackMain)];
    backButton.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = personalButton;
    self.navigationItem.leftBarButtonItem = backButton;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self UIInit];
    [self UINavigationInit];
    // 初始化百度位置服务
    [self initBMLocationService];
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
    self.mapView.delegate = self;
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

#pragma mark - button event
-(void)getToPersonal {
    KDScoreViewController *score = [[KDScoreViewController alloc] init];
    [self.navigationController pushViewController:score animated:YES];
    
}

-(void)getbackMain {
    [self.navigationController popViewControllerAnimated:YES];
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
    self.mapView.centerCoordinate = userLocation.location.coordinate;
    //设置显示范围
    BMKCoordinateRegion adjustRegion = [self.mapView regionThatFits:BMKCoordinateRegionMake(self.locService.userLocation.location.coordinate, BMKCoordinateSpanMake(0.02f,0.02f))];
    //设置兴趣点
    if (once) {
        for (int i = 0; i < 5; i++) {
            pointAnnotation = [[BMKPointAnnotation alloc]init];
            CLLocationCoordinate2D coor;
            coor.latitude = self.locService.userLocation.location.coordinate.latitude+0.001*i;
            NSLog(@"latitude:.....%f", coor.latitude);
            coor.longitude = self.locService.userLocation.location.coordinate.longitude+0.001*i;
            pointAnnotation.coordinate = coor;
            pointAnnotation.title = @"肯德基";
            pointAnnotation.subtitle = @"距我1080米";
            [self.mapView addAnnotation:pointAnnotation];
        }
    }
    once = NO;
    
    [self.mapView setRegion:adjustRegion animated:YES];
    
    /** 判断用户是否在户外*/
    if (userLocation.location.horizontalAccuracy > kCLLocationAccuracyNearestTenMeters) {//室内使用基站或wifi，精度较GPS低
        return;
    }
}

#pragma mark - 点击标注事件
// 当点击annotation view弹出的泡泡时，调用此接口
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view {
    //跳转到对应的商家
    KDStoreDetailViewController *store = [[KDStoreDetailViewController alloc] init];
    store.storeName = view.reuseIdentifier;
    [self.navigationController pushViewController:store animated:YES];
    
}

#pragma mark - 自定义annotation的view
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
   
    //CLLocationCoordinate2D coordinate是标注view的中心坐标 将annotation的title当做重用标志传递。
    NSString *identityID = [NSString stringWithFormat:@"%@", annotation.title];
    BMKAnnotationView * view = [[BMKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identityID];
    //设置标注的图片
    view.image=[UIImage imageNamed:@"annotation"];
    //点击显示图详情视图 必须MJPointAnnotation对象设置了标题和副标题
    view.canShowCallout=YES;
    //创建了两个view
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 32, 41)];
    UIImageView *storeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"storeImage"]];
    storeImageView.frame = CGRectMake(0, 0, 32, 41);
    [view1 addSubview:storeImageView];
    UIView * view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 32, 41)];
    UILabel *nextLabel = [[UILabel alloc] init];
    nextLabel.text = @">";
    [nextLabel setTextColor:[UIColor blackColor]];
    nextLabel.frame = CGRectMake(0, 0, view2.frame.size.width, view2.frame.size.height);
    [view2 addSubview:nextLabel];
    //设置左右辅助视图
    view.leftCalloutAccessoryView=view1;
    view.rightCalloutAccessoryView=view2;
    //设置拖拽 可以通过点击不放进行拖拽
    view.draggable=YES;
   
    return view;
    
    //自定义标注view
    /*
    NSString *AnnotationViewID = [NSString stringWithFormat:@"renameMark%d", j];
    BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        // 设置颜色
        annotationView.pinColor = BMKPinAnnotationColorPurple;
        // 从天上掉下效果
        annotationView.animatesDrop = YES;
        // 设置可拖拽
        annotationView.draggable = YES;
        //设置大头针图标
        annotationView.image = [UIImage imageNamed:@"annotation"];
        //设置标注的view
        UIView *popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 60)];
        //设置弹出气泡图片
//        UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wenzi"]];
//        image.frame = CGRectMake(0, 0, 100, 60);
        UIView *backgroundView = [[UIView alloc] init];
        backgroundView.backgroundColor = [UIColor colorWithRed:214.0/255 green:238.0/255 blue:221.0/255 alpha:1];
        backgroundView.frame = CGRectMake(0, 0, 100, 60);
        [popView addSubview:backgroundView];
        //商家的标志
        UIImageView *storeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"head"]];
        storeImageView.frame = CGRectMake(0, 0, 0.2*popView.frame.size.width, 0.8*popView.frame.size.height);
        [popView addSubview:storeImageView];
        //自定义显示的内容
        UILabel *driverName = [[UILabel alloc]initWithFrame:CGRectMake(0, 3, 100, 20)];
        driverName.text = @"肯德基";
        driverName.backgroundColor = [UIColor clearColor];
        driverName.font = [UIFont systemFontOfSize:14];
        driverName.textColor = [UIColor whiteColor];
        driverName.textAlignment = NSTextAlignmentCenter;
        [popView addSubview:driverName];
        UILabel *carName = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, 100, 20)];
        carName.text = @"距您1080米";
        carName.backgroundColor = [UIColor clearColor];
        carName.font = [UIFont systemFontOfSize:14];
        carName.textColor = [UIColor whiteColor];
        carName.textAlignment = NSTextAlignmentCenter;
        [popView addSubview:carName];
        //点击跳转标志
        UIImageView *nextImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"返回"]];
        nextImageView.frame = CGRectMake(0.8*popView.frame.size.width, 0, 0.2*popView.frame.size.width, 0.8*popView.frame.size.height);
        [popView addSubview:nextImageView];
        //泡泡view
        BMKActionPaopaoView *pView = [[BMKActionPaopaoView alloc]initWithCustomView:popView];
        pView.frame = CGRectMake(0, 0, 100, 60);
        annotationView.paopaoView = nil;
        annotationView.paopaoView = pView;
        j++;
    }
    return annotationView;
     */
}


#pragma mark - ViewWillAppear

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
