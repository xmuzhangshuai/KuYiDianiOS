//
//  KDMarkViewController.m
//  KuDian
//
//  Created by 黄明族 on 16/6/3.
//  Copyright © 2016年 黄明族. All rights reserved.
//
//收藏界面
#import "KDMarkViewController.h"
#import "UISize.h"
#import "KDStoreDetailViewController.h"


@interface KDMarkViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation KDMarkViewController {
    UITableView *markTableView;
}

-(void)UIInit {
    markTableView = [[UITableView alloc] init];
    markTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    markTableView.delegate = self;
    markTableView.dataSource = self;
    
    [self.view addSubview:markTableView];
    
    [self UINavigation];
}



-(void)UINavigation {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self UIInit];
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
    cell.textLabel.text = @"被收藏的店铺";
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
