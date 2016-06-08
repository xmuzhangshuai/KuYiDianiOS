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


@interface KDStoreDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation KDStoreDetailViewController {
    UITableView *detailTableView;
}

-(void)UIInit {
    detailTableView = [[UITableView alloc] init];
    detailTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    detailTableView.delegate = self;
    detailTableView.dataSource = self;
    
    [self.view addSubview:detailTableView];
}

-(void)UINavigation {
    UIBarButtonItem *rightItem;
//    rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Mark"] style:UIBarButtonItemStylePlain target:self action:@selector(getMark)];
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [rightButton setImage:[UIImage imageNamed:@"Star"] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"WhiteStar"] forState:UIControlStateSelected];
    [rightButton addTarget:self action:@selector(getMark) forControlEvents:UIControlEventTouchUpInside];
    rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self UIInit];
    [self UINavigation];
    NSLog(@"indexPath:....%ld", self.indexPath.row);
}

#pragma mark - detaiTableViewDelegate
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = @"奶奶的信";
    cell.imageView.image = [UIImage imageNamed:@"1"];
    cell.detailTextLabel.text = @"所需积分：100";
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCREEN_HEIGHT/10;
}

#pragma mark - headerView
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *storeView = [[UIView alloc] init];
    storeView.backgroundColor = [UIColor whiteColor];
    /** 商家图片*/
    UIImageView *storeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"4.jpg"]];
    UILabel *storeName = [[UILabel alloc] init];
    storeName.numberOfLines = 0;
    UILabel *storeLocation = [[UILabel alloc] init];
    storeName.text = @"商店名称：见福便利店";
    storeLocation.text = @"地址：建兴路";
    [storeView addSubview:storeImageView];
    [storeView addSubview:storeName];
    [storeView addSubview:storeLocation];
    [storeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(storeView).with.offset(10);
        make.bottom.equalTo(storeView).with.offset(-10);
        make.width.equalTo(storeView).multipliedBy(0.2);
    }];
    [storeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(storeImageView).with.offset(10);
        make.left.equalTo(storeImageView.mas_right).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(0.8*SCREEN_WIDTH, 10));
    }];
    [storeLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(storeImageView.mas_right).with.offset(10);
        make.top.equalTo(storeName.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(0.5*SCREEN_WIDTH, 20));
    }];
    return storeView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.2*SCREEN_HEIGHT;
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
