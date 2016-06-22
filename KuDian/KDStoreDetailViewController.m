//
//  KDStoreDetailViewController.m
//  KuDian
//
//  Created by 黄明族 on 16/6/3.
//  Copyright © 2016年 黄明族. All rights reserved.
//
//商家详情页面
#import "KDStoreDetailViewController.h"
#import "UISize.h"
#import "Masonry.h"
#import "MBProgressHUD.h"
#import "KDPersonalCenterViewController.h"
#import "KDScoreViewController.h"
#import "StoreDetailTableViewCell.h"
//#import "InfoViewController.h"
//#import "KDMainViewController.h"


@interface KDStoreDetailViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@end

@implementation KDStoreDetailViewController {
    UITableView *detailTableView;
    
    
    //productImageArr
    NSMutableArray *productImageArr;
    
//    //侧拉栏
//    InfoViewController *infoViewController;
//    UIView                      *cover;
//    UISwipeGestureRecognizer    *leftSwipGestureRecognizer;
}

-(instancetype)init {
    if (self = [super init]) {
        productImageArr = [[NSMutableArray alloc] init];
        for (int i = 1; i < 8; i++) {
            [productImageArr addObject:[NSString stringWithFormat:@"product%d", i]];
        }
    }
    return self;
}


-(void)UIInit {
    detailTableView = [[UITableView alloc] init];
    detailTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    detailTableView.delegate = self;
    detailTableView.dataSource = self;
    
    NSLog(@"storeName:...%@", self.storeName);
//    //侧拉栏
//    //侧拉栏
//    cover           = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    cover.hidden = YES;
//    [self.navigationController.view addSubview:cover];
//    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenCover)];
//    UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenCover)];
//    rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
//    [cover addGestureRecognizer:tap];
//    [cover addGestureRecognizer:rightSwipeGestureRecognizer];
//    
//    infoViewController = [[InfoViewController alloc] initWithFrame:CGRectMake((-1)*SCREEN_WIDTH, 0, SCREEN_WIDTH*0.8666, SCREEN_HEIGHT)];
//    infoViewController.delegate = self;
//    [self.navigationController.view addSubview:infoViewController.view];
//    
//    leftSwipGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showMenu)];
//    [self.view addGestureRecognizer:leftSwipGestureRecognizer];
//    //初始化遮罩层
//    cover.backgroundColor = [UIColor blackColor];
//    cover.alpha = 0.6;
//    cover.hidden = YES;
    
    [self.view addSubview:detailTableView];
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

//#pragma mark - kdSideViewControllerDelegate
//-(void)getNextViewController:(id)nextViewController {
//    [self hiddenMenu];
//    cover.hidden = YES;
//    [self.navigationController pushViewController:nextViewController animated:YES];
//}
//
//-(void)removeFromSuperView:(BOOL)isLogOut {
//    [self hiddenCover];
//    if (isLogOut) {
//        [self.navigationController popToRootViewControllerAnimated:NO];
//    }
//    
//}

#pragma mark - button event 
-(void)getToPersonal {
    KDScoreViewController *score = [[KDScoreViewController alloc] init];
    [self.navigationController pushViewController:score animated:YES];
    
}

-(void)getbackMain {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - detaiTableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *cellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (cell == nil) {÷
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
//    }
    StoreDetailTableViewCell *cell = [StoreDetailTableViewCell cellWithTableView:tableView];
    if (indexPath.row % 2 == 0) {
         cell.contentView.backgroundColor = [UIColor colorWithRed:215.0/255 green:238.0/255 blue:220.0/255 alpha:1];
    }else {
       cell.contentView.backgroundColor = [UIColor colorWithRed:238.0/255 green:248.0/255 blue:240.0/255 alpha:1];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.textLabel.text = @"鸡腿";
    cell.productName.text = @"鸡腿";
    cell.productImageView.image = [UIImage imageNamed:productImageArr[indexPath.row]];
    cell.scoreNum.text = @"所需积分：30  以换取29次";
    cell.discountImageView.image = [UIImage imageNamed:@"convertImage"];
    //    cell.detailTextLabel.text = @"所需积分：100";
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0.112*SCREEN_HEIGHT;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提醒" message:@"是否确定兑换此商品?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    */
    //ios9新增警告框方法, 两次确定的警告框。
    UIAlertController *FirstAlertController = [UIAlertController alertControllerWithTitle:@"温馨提醒" message:@"是否使用积分兑换此商品" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"这是取消按钮");
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"这是确定按钮");
        UIAlertController *SecondAlertController = [UIAlertController alertControllerWithTitle:@"温馨提醒" message:@"是否确定使用积分兑换此商品，注意该操作无法取消!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"这是第一个取消按钮");
        }];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"这是第二个确定按钮");
            
        }];
        [SecondAlertController addAction:confirmAction];
        [SecondAlertController addAction:cancelAction];
        [self presentViewController:SecondAlertController animated:YES completion:nil];

    }];
    [FirstAlertController addAction:confirmAction];
    [FirstAlertController addAction:cancelAction];
    //将警告框模态出来
    [self presentViewController:FirstAlertController animated:YES completion:nil];

}



#pragma mark - headerView
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *storeView = [[UIView alloc] init];
    storeView.backgroundColor = [UIColor colorWithRed:238.0/255 green:248.0/255 blue:240.0/255 alpha:1];
    /** 商家图片*/
    UIImageView *storeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"storeImage6"]];
    UILabel *storeName = [[UILabel alloc] init];
    [storeName setFont:[UIFont systemFontOfSize:13]];
    storeName.numberOfLines = 0;
    UILabel *storeLocation = [[UILabel alloc] init];
    [storeLocation setFont:[UIFont systemFontOfSize:9]];
    UILabel *productNum = [[UILabel alloc] init];
    [productNum setFont:[UIFont systemFontOfSize:9]];
    
    
    UIImageView *locationImage = [[UIImageView alloc] init];
    locationImage.image = [UIImage imageNamed:@"smallLocation"];
    UIImageView *MarkImage = [[UIImageView alloc] init];
    MarkImage.image = [UIImage imageNamed:@"redLove"];
    productNum.text = @"商品数量：288";
    storeName.text = self.storeName;
    storeLocation.text = @"厦门市思明区";
    [storeView addSubview:storeImageView];
    [storeView addSubview:storeName];
    [storeView addSubview:storeLocation];
    [storeView addSubview:productNum];
    [storeView addSubview:locationImage];
    [storeView addSubview:MarkImage];
    
    
    [storeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(storeView).with.offset(10);
        make.left.equalTo(storeView).with.offset(0.1*SCREEN_WIDTH);
        make.bottom.equalTo(storeView).with.offset(-10);
        make.width.equalTo(storeView).multipliedBy(0.17);
    }];
    [storeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(storeImageView).with.offset(10);
        make.left.equalTo(storeImageView.mas_right).with.offset(0.15*SCREEN_WIDTH);
        make.size.mas_equalTo(CGSizeMake(0.8*SCREEN_WIDTH, 10));
    }];
    [storeLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(storeImageView.mas_right).with.offset(0.15*SCREEN_WIDTH);
        make.top.equalTo(storeName.mas_bottom).with.offset(10);
//        make.size.mas_equalTo(CGSizeMake(0.5*SCREEN_WIDTH, 10));
    }];
    [productNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(storeImageView.mas_right).with.offset(0.15*SCREEN_WIDTH);
        make.top.equalTo(storeLocation.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(0.5*SCREEN_WIDTH, 10));
    }];
    [locationImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(storeLocation.mas_right).offset(5);
        make.top.equalTo(storeName.mas_bottom).offset(5);
        make.width.mas_equalTo(10);
    }];
    [MarkImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(storeView).offset(-0.1*SCREEN_WIDTH);
        make.top.equalTo(storeName.mas_bottom).offset(5);
        make.width.mas_equalTo(@20);
    }];
    
    return storeView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.124*SCREEN_HEIGHT;
}

#pragma mark - buttonEvent
-(void)getMark {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"已收藏";
    hud.margin = 10.f;
    hud.yOffset = 150.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
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
