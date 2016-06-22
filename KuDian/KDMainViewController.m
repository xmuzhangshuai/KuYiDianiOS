//
//  KDMainViewController.m
//  KuDian
//
//  Created by 黄明族 on 16/5/31.
//  Copyright © 2016年 黄明族. All rights reserved.
//

#import "KDMainViewController.h"
//侧拉栏模块
#import "InfoViewController.h"

#import "UISize.h"
#import "KDADScrollView.h"
#import "KDLocalScrollView.h"
#import "KDMainCollectionViewCell.h"
#import "Masonry.h"
#import "KDStoreViewController.h"
#import "KDMapViewController.h"
#import "KDLaProductViewController.h"
#import "KDMarkViewController.h"
#import "KDChartsViewController.h"
#import "KDPersonalCenterViewController.h"
#import "KDScoreViewController.h"
#import "KDRecommandViewController.h"

#define  Demo1CellID @"demo1_cell_id"
#define  ADScrollView_HEIGHT 0.127*SCREEN_HEIGHT
#define  LocalScrollView_HEIGHT 0.087*SCREEN_HEIGHT
#define  LABEL_HEIGHT 0.018*SCREEN_HEIGHT

@interface KDMainViewController ()<InfoViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)UICollectionView *collectionView;

@end

@implementation KDMainViewController {
    //侧面菜单
    InfoViewController *infoViewController;
    UIView                      *cover;
    UISwipeGestureRecognizer    *leftSwipGestureRecognizer;
    NSMutableArray *ADImageArr;
    
    //collection的类别名称
    NSArray *typeNameArray;
    NSMutableArray *typeImageArray;
    
    //附近商家的图片数组
    NSMutableArray *localImageNameArray;
    
}

-(instancetype)init {
    if (self = [super init]) {
        //广告栏
        ADImageArr = [[NSMutableArray alloc] init];
        for (int i = 5; i < 10; i++) {
            [ADImageArr addObject:[NSString stringWithFormat:@"%d.jpg", i]];
        }
        localImageNameArray = [[NSMutableArray alloc] init];
        for (int i = 1; i < 5; i++) {
            [localImageNameArray addObject:[NSString stringWithFormat:@"LocalStore%d.jpg", i]];
        }
        typeImageArray = [[NSMutableArray alloc] init];
        for (int i = 1; i < 7; i++) {
            [typeImageArray addObject:[NSString stringWithFormat:@"mainView%d", i]];
        }
        
        typeNameArray = @[@"商家列表", @"最新商品", @"地图", @"收藏", @"排行榜", @"酷易点推荐"];
        
    }
    return self;
}

-(void)UIInit {
    self.view.backgroundColor = [UIColor whiteColor];
   
    //侧拉栏
    cover           = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    cover.hidden = YES;
    [self.navigationController.view addSubview:cover];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenCover)];
    UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenCover)];
    rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [cover addGestureRecognizer:tap];
    [cover addGestureRecognizer:rightSwipeGestureRecognizer];
    
    infoViewController = [[InfoViewController alloc] initWithFrame:CGRectMake((-1)*SCREEN_WIDTH, 0, SCREEN_WIDTH*0.8666, SCREEN_HEIGHT)];
    infoViewController.delegate = self;
    [self.navigationController.view addSubview:infoViewController.view];
    
    leftSwipGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showMenu)];
    [self.view addGestureRecognizer:leftSwipGestureRecognizer];
    
    [self navigationInit];
   [self UILayout];
}

-(void)navigationInit {
    
     [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:198.0/255 green:238.0/255 blue:239.0/255 alpha:1]];
    //Logo
    UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-30, 20, 0.15*SCREEN_WIDTH, 0.05*SCREEN_HEIGHT)];
    titleImageView.image = [UIImage imageNamed:@"kuyidian"];
    titleImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = titleImageView;
    //侧拉栏
    UIBarButtonItem *sideButton;
    sideButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backmain"] style:UIBarButtonItemStylePlain target:self action:@selector(information)];
    sideButton.tintColor = [UIColor colorWithRed:75.0/255 green:73.0/255 blue:70.0/255 alpha:1];
    
    //跳转到个人中心界面
    UIBarButtonItem *personalButton;
    personalButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"personalmain"] style:UIBarButtonItemStylePlain target:self action:@selector(getToPersonal)];
    personalButton.tintColor = [UIColor colorWithRed:75.0/255 green:73.0/255 blue:70.0/255 alpha:1];

    self.navigationItem.rightBarButtonItem = personalButton;
    self.navigationItem.leftBarButtonItem = sideButton;
    
}

-(void)UILayout {
    KDADScrollView *adScrollView = [KDADScrollView direcWithtFrame:CGRectMake(0, 0, SCREEN_WIDTH, ADScrollView_HEIGHT) ImageArr:ADImageArr AndImageClickBlock:^(NSInteger index) {
        NSLog(@"当前按中:...%ld", index);
    }];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, ADScrollView_HEIGHT, SCREEN_WIDTH, LABEL_HEIGHT);
    label.text = @"附近商家";
    [label setFont:[UIFont systemFontOfSize:10]];
    
    KDLocalScrollView *localScrollView = [KDLocalScrollView localScrollViewWithFrame:CGRectMake(0, label.frame.origin.y+LABEL_HEIGHT, SCREEN_WIDTH, LocalScrollView_HEIGHT) ImageArr:localImageNameArray andClickScrollViewBlock:^(NSInteger index) {
            NSLog(@"当前按中:....%ld", index);
        }];
    [self.view addSubview:localScrollView];
    [self.view addSubview:adScrollView];
    [self.view addSubview:label];
    
    //UIcollection 分类
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH/2, 0.218*SCREEN_HEIGHT);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumLineSpacing = 0;//设置每个item之间的间距
    flowLayout.minimumInteritemSpacing = 0;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, localScrollView.frame.origin.y+LocalScrollView_HEIGHT+LABEL_HEIGHT, SCREEN_WIDTH, 0.8*SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    //设置滑动
//    collectionView.showsVerticalScrollIndicator = YES;
//    collectionView.backgroundColor = [UIColor whiteColor];
//    collectionView.alwaysBounceVertical = YES;
    
    [self.view addSubview:collectionView];
    
    _collectionView=collectionView;
    
    //初始化遮罩层
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.6;
    cover.hidden = YES;
    
    
    [self.collectionView registerClass:[KDMainCollectionViewCell class] forCellWithReuseIdentifier:Demo1CellID];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UIInit];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

#pragma mark - 个人中心
-(void)getToPersonal {
    KDScoreViewController *score = [[KDScoreViewController alloc] init];
    [self.navigationController pushViewController:score animated:YES];
}

#pragma mark - Button Event侧拉栏
/** 隐藏遮罩层，左滑隐藏侧栏*/
- (void)hiddenCover {
    [self hiddenMenu];
    [UIView animateWithDuration:0.25 animations:^{
        cover.alpha = 0.0;
    }];
    cover.hidden = YES;
}

//点击按钮显示侧拉栏
- (void)information {
    [self showMenu];
}
//右滑显示侧拉栏
- (void)showMenu {
    CGRect infoView = infoViewController.view.frame;
    infoView.origin.x += SCREEN_WIDTH;
    // 动画
    [UIView animateWithDuration:0.4f
                          delay:0.0f
         usingSpringWithDamping:1.0
          initialSpringVelocity:4.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         infoViewController.view.frame = infoView;
                         cover.hidden = NO;
                         cover.alpha = 0.6;
                     }
                     completion:^(BOOL finished){
                     }];



}

- (void)hiddenMenu {
    CGRect infoView = infoViewController.view.frame;
    infoView.origin.x -= SCREEN_WIDTH;
    // 动画
    cover.hidden = YES;
    [UIView animateWithDuration:0.4f
                          delay:0.0f
         usingSpringWithDamping:1.0
          initialSpringVelocity:4.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         infoViewController.view.frame = infoView;
                         cover.alpha = 0;
                     }
                     completion:^(BOOL finished){
                     }];
    [UIView commitAnimations];

    
}

#pragma mark - kdSideViewControllerDelegate
-(void)getNextViewController:(id)nextViewController {
    [self hiddenMenu];
    cover.hidden = YES;
    [self.navigationController pushViewController:nextViewController animated:YES];
}

-(void)removeFromSuperView:(BOOL)isLogOut {
    [self hiddenCover];
    if (isLogOut) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}

#pragma mark - KdMainCollection
#pragma mark- UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KDMainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Demo1CellID forIndexPath:indexPath];
    if(!cell){
        cell = [[KDMainCollectionViewCell alloc] init];
    }
    [cell setImageName:typeImageArray[indexPath.row] andContent:typeNameArray[indexPath.row]];
    
    
    switch (indexPath.row) {
        case 0:{
            cell.contentView.backgroundColor = [UIColor colorWithRed:245.0/255 green:164.0/255 blue:160.0/255 alpha:1];
        }
            break;
        case 1:{
            cell.contentView.backgroundColor = [UIColor colorWithRed:215.0/255 green:238.0/255 blue:220.0/255 alpha:1];
        }
            break;
        case 2:{
            cell.contentView.backgroundColor = [UIColor colorWithRed:248.0/255 green:246.0/255 blue:233.0/255 alpha:1];
        }
            break;
        case 3:{
            cell.contentView.backgroundColor = [UIColor colorWithRed:156.0/255 green:136.0/255 blue:129.0/255 alpha:1];
        }
            break;
        case 4:{
            cell.contentView.backgroundColor = [UIColor colorWithRed:198.0/255 green:238.0/255 blue:239.0/255 alpha:1];
        }
            break;
        case 5:{
            cell.contentView.backgroundColor = [UIColor colorWithRed:203.0/255 green:219.0/255 blue:242.0/255 alpha:1];
        }
            break;
        default:
            break;
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            //商家列表
            KDStoreViewController *store = [[KDStoreViewController alloc] init];
            [self.navigationController pushViewController:store animated:YES];
        }
            break;
        case 1:{
            //最新商品
            KDLaProductViewController *product = [[KDLaProductViewController alloc] init];
            [self.navigationController pushViewController:product animated:YES];
        }
            break;
        case 2:{
            //地图
            KDMapViewController *map = [[KDMapViewController alloc] init];
            [self.navigationController pushViewController:map animated:YES];
        }
            break;
        case 3:{
            //收藏
            KDMarkViewController *mark = [[KDMarkViewController alloc] init];
            [self.navigationController pushViewController:mark animated:YES];
        }
            break;
        case 4:{
            //排行榜
            KDChartsViewController *charts = [[KDChartsViewController alloc] init];
            [self.navigationController pushViewController:charts animated:YES];
        }
            break;
        case 5:{
            //酷易点推荐
            KDRecommandViewController *recommand = [[KDRecommandViewController alloc] init];
            [self.navigationController pushViewController:recommand animated:YES];
        }
            break;
        default:
            break;
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
