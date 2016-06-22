//
//  KDLaProductViewController.m
//  KuDian
//
//  Created by 黄明族 on 16/6/3.
//  Copyright © 2016年 黄明族. All rights reserved.
//
//最新商品界面
#import "KDLaProductViewController.h"
#import "UISize.h"
#import "KDPersonalCenterViewController.h"
#import "KDScoreViewController.h"
#import "StoreDetailTableViewCell.h"
#import "KDADScrollView.h"


#define  ADScrollView_HEIGHT 0.143*SCREEN_HEIGHT


@interface KDLaProductViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation KDLaProductViewController {
     UITableView *ProductTableView;
    
    //广告栏数组
    NSMutableArray *ADImageArr;
    
    //最新商品图片数组
    NSMutableArray *productImageArr;

}

-(instancetype)init {
    if (self = [super init]) {
        //广告栏
        ADImageArr = [[NSMutableArray alloc] init];
        for (int i = 5; i < 10; i++) {
            [ADImageArr addObject:[NSString stringWithFormat:@"%d.jpg", i]];
        }        
        productImageArr = [[NSMutableArray alloc] init];
        for (int i = 1; i < 7; i++) {
            [productImageArr addObject:[NSString stringWithFormat:@"lsProduct%d", i]];
        }
    }
    return self;
}

-(void)UIInit {
    
    KDADScrollView *adScrollView = [KDADScrollView direcWithtFrame:CGRectMake(0, 0, SCREEN_WIDTH, ADScrollView_HEIGHT) ImageArr:ADImageArr AndImageClickBlock:^(NSInteger index) {
        NSLog(@"当前按中:...%ld", index);
    }];
    
    ProductTableView = [[UITableView alloc] init];
    ProductTableView.frame = CGRectMake(0, ADScrollView_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-ADScrollView_HEIGHT);
    ProductTableView.delegate = self;
    ProductTableView.dataSource = self;
    [self.view addSubview:adScrollView];
    [self.view addSubview:ProductTableView];
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
    self.edgesForExtendedLayout = UIRectEdgeNone;

}

#pragma mark - button event
-(void)getToPersonal {
    KDScoreViewController *score = [[KDScoreViewController alloc] init];
    [self.navigationController pushViewController:score animated:YES];
    
}

-(void)getbackMain {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ProductDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"肯德基 甜筒";
    cell.imageView.image = [UIImage imageNamed:@"4"];
    cell.detailTextLabel.text = @"积分：30/兑换8折";
    */
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
    cell.scoreNum.text = @"积分：30/兑换8折";
    cell.discountImageView.image = [UIImage imageNamed:@"discount"];
    cell.lsChargeNumLabel.text = @"已兑换29次";
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 0.112*SCREEN_HEIGHT;
    return (SCREEN_HEIGHT-ADScrollView_HEIGHT)/6;
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
