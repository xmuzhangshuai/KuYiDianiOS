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
#import "InfoViewController.h"

@interface KDStoreViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation KDStoreViewController {
    UITableView *storeTableView;
    
    //侧拉栏
    InfoViewController *infoViewController;
    UIView                      *cover;
    UISwipeGestureRecognizer    *leftSwipGestureRecognizer;
    
}

-(void)UIInit {
    storeTableView = [[UITableView alloc] init];
    storeTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    storeTableView.delegate = self;
    storeTableView.dataSource = self;
    
    //侧拉栏
    //侧拉栏
//    cover           = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    cover.hidden = YES;
//    [self.navigationController.view addSubview:cover];
//    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenCover)];
//    UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenCover)];
//    rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
//    [cover addGestureRecognizer:tap];
//    [cover addGestureRecognizer:rightSwipeGestureRecognizer];
    
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

    
    [self.view addSubview:storeTableView];
}

-(void)UINavigation {
//    UIBarButtonItem *sideButton;
//    sideButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"个人中心"] style:UIBarButtonItemStylePlain target:self action:@selector(information)];
//    sideButton.tintColor = [UIColor grayColor];
//    self.navigationItem.leftBarButtonItem = sideButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self UIInit];
    [self UINavigation];
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

-(void)removeFromSuperView {
    [self hiddenCover];
    
}


#pragma mark - tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = @"解忧杂货铺";
    cell.imageView.image = [UIImage imageNamed:@"2"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCREEN_HEIGHT/10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //跳转到商家详细界面
    KDStoreDetailViewController *detailViewController = [[KDStoreDetailViewController alloc] init];
    //将点击的index的行号传值
    detailViewController.indexPath = indexPath;
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
