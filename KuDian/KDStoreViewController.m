//
//  KDStoreViewController.m
//  KuDian
//
//  Created by 黄明族 on 16/6/3.
//  Copyright © 2016年 黄明族. All rights reserved.
//

//商家列表
#import "KDStoreViewController.h"
#import "UISize.h"
#import "KDStoreDetailViewController.h"
//#import "InfoViewController.h"
#import "StoreTableViewCell.h"
#import "KDPersonalCenterViewController.h"
#import "KDADScrollView.h"
#import "KDScoreViewController.h"


#define  ADScrollView_HEIGHT 0.143*SCREEN_HEIGHT


@interface KDStoreViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation KDStoreViewController {
    UITableView *storeTableView;
    //广告栏数组
    NSMutableArray *ADImageArr;
    
    //商家图标
    NSMutableArray *storeImageArr;
    
    //分类图标视图
    UIView *LogoView;
    UIImageView *LogoImageView;
    
//    //侧拉栏
//    InfoViewController *infoViewController;
//    UIView                      *cover;
//    UISwipeGestureRecognizer    *leftSwipGestureRecognizer;
    
}

-(instancetype)init {
    if (self = [super init]) {
        //广告栏
        ADImageArr = [[NSMutableArray alloc] init];
        for (int i = 5; i < 10; i++) {
            [ADImageArr addObject:[NSString stringWithFormat:@"%d.jpg", i]];
        }
        storeImageArr = [[NSMutableArray alloc] init];
        for (int i = 1; i < 7; i++) {
            [storeImageArr addObject:[NSString stringWithFormat:@"storeImage%d", i]];
        }
        
    }
    return self;
}



-(void)UIInit {
    
    KDADScrollView *adScrollView = [KDADScrollView direcWithtFrame:CGRectMake(0, 0, SCREEN_WIDTH, ADScrollView_HEIGHT) ImageArr:ADImageArr AndImageClickBlock:^(NSInteger index) {
        NSLog(@"当前按中:...%ld", index);
    }];
    
    
    storeTableView = [[UITableView alloc] init];
//        storeTableView.frame = CGRectMake(0, ADScrollView_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-ADScrollView_HEIGHT);
    storeTableView.frame = CGRectMake(0, ADScrollView_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-ADScrollView_HEIGHT-0.15*SCREEN_HEIGHT);
    storeTableView.delegate = self;
    storeTableView.dataSource = self;
    
//    LogoView = [[UIView alloc] init];
//    LogoView.frame = CGRectMake(0, 0.85*SCREEN_HEIGHT, SCREEN_WIDTH, 0.1*SCREEN_HEIGHT);
//    LogoView.backgroundColor = [UIColor colorWithRed:198.0/255 green:238.0/255 blue:239.0/255 alpha:1];
    
    [self.view addSubview:adScrollView];
    [self.view addSubview:storeTableView];
//    [self.view addSubview:LogoView];

}

-(void)UINavigation {
    
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
    [self UINavigation];
    //设置从导航栏下方开始布局
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

//#pragma mark - Button Event侧拉栏
///** 隐藏遮罩层，左滑隐藏侧栏*/
//- (void)hiddenCover {
//    [self hiddenMenu];
//    [UIView animateWithDuration:0.25 animations:^{
//        cover.alpha = 0.0;
//    }];
//    cover.hidden = YES;
//}
//
////点击按钮显示侧拉栏
//- (void)information {
//    [self showMenu];
//}
////右滑显示侧拉栏
//- (void)showMenu {
//    CGRect infoView = infoViewController.view.frame;
//    infoView.origin.x += SCREEN_WIDTH;
//    // 动画
//    [UIView animateWithDuration:0.4f
//                          delay:0.0f
//         usingSpringWithDamping:1.0
//          initialSpringVelocity:4.0
//                        options: UIViewAnimationOptionCurveEaseInOut
//                     animations:^{
//                         infoViewController.view.frame = infoView;
//                         cover.hidden = NO;
//                         cover.alpha = 0.6;
//                     }
//                     completion:^(BOOL finished){
//                     }];
//    
//}
//
//- (void)hiddenMenu {
//    CGRect infoView = infoViewController.view.frame;
//    infoView.origin.x -= SCREEN_WIDTH;
//    // 动画
//    cover.hidden = YES;
//    [UIView animateWithDuration:0.4f
//                          delay:0.0f
//         usingSpringWithDamping:1.0
//          initialSpringVelocity:4.0
//                        options: UIViewAnimationOptionCurveEaseInOut
//                     animations:^{
//                         infoViewController.view.frame = infoView;
//                         cover.alpha = 0;
//                     }
//                     completion:^(BOOL finished){
//                     }];
//    [UIView commitAnimations];
//    
//    
//}
//
//#pragma mark - kdSideViewControllerDelegate
//-(void)getNextViewController:(id)nextViewController {
//    [self hiddenMenu];
//    cover.hidden = YES;
//    [self.navigationController pushViewController:nextViewController animated:YES];
//}
//
//-(void)removeFromSuperView:(BOOL)isLogOut {
//    [self hiddenCover];
//    [self.navigationController popViewControllerAnimated:YES];
//    if (isLogOut) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }
//}

#pragma mark - button event 
-(void)getToPersonal {
    KDScoreViewController *score = [[KDScoreViewController alloc] init];
    [self.navigationController pushViewController:score animated:YES];
    
}

-(void)getbackMain {
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identity = @"StoreTableViewCell";
    StoreTableViewCell *cell = (StoreTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identity];
    if (cell == nil) {
        cell = (StoreTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:identity owner:self options:nil] lastObject];
    }
    cell.StoreImageView.image = [UIImage imageNamed:storeImageArr[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return (StoreTableViewCell *)cell;
}

//修改cell的背景色。
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row%2 == 0) {
//        [cell.contentView setBackgroundColor:[UIColor colorWithRed:215.0/255 green:238.0/255 blue:222.0/255 alpha:1]];
//        cell.backgroundColor = [UIColor colorWithRed:215.0/255 green:238.0/255 blue:222.0/255 alpha:1];
//    }else {
//        [cell.contentView setBackgroundColor:[UIColor colorWithRed:233.0/255 green:246.0/255 blue:236.0/255 alpha:1]];
//    }
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (SCREEN_HEIGHT-ADScrollView_HEIGHT)/6;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //获取点击的cell
    StoreTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //跳转到商家详细界面
    KDStoreDetailViewController *detailViewController = [[KDStoreDetailViewController alloc] init];
    //将点击的index的行号传值（不合适，应该传递的是商家的名称）
//    detailViewController.indexPath = indexPath;
    detailViewController.storeName = cell.StoreNameLabel.text;
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    
    
    
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
