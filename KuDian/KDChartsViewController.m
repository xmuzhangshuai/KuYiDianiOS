//
//  KDChartsViewController.m
//  KuDian
//
//  Created by 黄明族 on 16/6/3.
//  Copyright © 2016年 黄明族. All rights reserved.
//
//排行榜
#import "KDChartsViewController.h"
#import "Masonry.h"
#import "UISize.h"

@interface KDChartsViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation KDChartsViewController {
    UIView *headerView;
    UITableView *chartsTableView;
    UIView *footerView;
    //选择按钮
    UIButton *monthButton;
    UIButton *weekButton;
    UIButton *allTimeButton;
    
    UIButton *schoolButton;
    UIButton *allSchoolButton;
    
    
}

-(void)UIInit {
    headerView = [[UIView alloc] init];
    weekButton = [[UIButton alloc] init];
    weekButton.backgroundColor = [UIColor grayColor];
    weekButton.layer.masksToBounds = YES;
    weekButton.layer.cornerRadius = 6;
    [weekButton setTitle:@"本周" forState:UIControlStateNormal];
    monthButton = [[UIButton alloc] init];
    monthButton.backgroundColor = [UIColor grayColor];
    monthButton.layer.masksToBounds = YES;
    monthButton.layer.cornerRadius = 6;
    [monthButton setTitle:@"本月" forState:UIControlStateNormal];
    allTimeButton = [[UIButton alloc] init];
    allTimeButton.backgroundColor = [UIColor grayColor];
    allTimeButton.layer.masksToBounds = YES;
    allTimeButton.layer.cornerRadius = 6;
    [allTimeButton setTitle:@"所有" forState:UIControlStateNormal];
    chartsTableView = [[UITableView alloc] init];
    chartsTableView.delegate = self;
    chartsTableView.dataSource = self;
    footerView = [[UIView alloc] init];
    schoolButton = [[UIButton alloc] init];
    schoolButton.backgroundColor = [UIColor grayColor];
    schoolButton.layer.masksToBounds = YES;
    schoolButton.layer.cornerRadius = 6;
    [schoolButton setTitle:@"学校" forState:UIControlStateNormal];
    allSchoolButton = [[UIButton alloc] init];
    allSchoolButton.backgroundColor = [UIColor grayColor];
    allSchoolButton.layer.masksToBounds = YES;
    allSchoolButton.layer.cornerRadius = 6;
    [allSchoolButton setTitle:@"所有" forState:UIControlStateNormal];
    
    headerView.backgroundColor = [UIColor whiteColor];
    footerView.backgroundColor = [UIColor whiteColor];
    
    [self UILayout];
}


-(void)UILayout {
    [self.view addSubview:headerView];
    [headerView addSubview:monthButton];
    [headerView addSubview:weekButton];
    [headerView addSubview:allTimeButton];
    [self.view addSubview:chartsTableView];
    [self.view addSubview:footerView];
    [footerView addSubview:schoolButton];
    [footerView addSubview:allSchoolButton];
    
    
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.right.equalTo(self.view);
        make.height.mas_equalTo(0.45*SCREEN_HEIGHT);
    }];
    [monthButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(headerView).offset(-20);
        // 设置左侧距离父视图10
        make.left.equalTo(headerView).with.offset(10);
        // 设置右侧距离和view2的左侧相隔10
        make.right.equalTo(weekButton.mas_left).with.offset(-10);
        // 设置高度
        make.height.mas_equalTo(@30);
        // 宽度设置和view2以及view3相同
        make.width.equalTo(@[weekButton, allTimeButton]);
    }];
    [weekButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(headerView).offset(-20);
        make.height.mas_equalTo(monthButton);
        make.width.equalTo(@[monthButton, allTimeButton]);
    }];
    [allTimeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(headerView).offset(-20);
        make.left.equalTo(weekButton.mas_right).with.offset(10);
        make.right.equalTo(headerView).with.offset(-10);
        make.height.mas_equalTo(monthButton);
        make.width.equalTo(@[weekButton, monthButton]);
    }];
    [chartsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottomMargin);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(0.45*SCREEN_HEIGHT);
    }];
    [footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(chartsTableView.mas_bottom);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    [schoolButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(footerView).offset(20);
        // 设置左侧距离父视图10
        make.left.equalTo(footerView).with.offset(30);
        make.right.equalTo(allSchoolButton.mas_left).offset(-40);
        // 设置高度
        make.height.mas_equalTo(@30);
        // 宽度设置和view2以及view3相同
        make.width.equalTo(allSchoolButton);
    }];
    [allSchoolButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(footerView).offset(20);
        make.right.equalTo(footerView).with.offset(-30);
        make.width.and.height.equalTo(schoolButton);
    }];
    
    
}


-(void)UINavigationInit {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self UIInit];
    [self UINavigationInit];
}

#pragma mark - tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = @"刘云";
    cell.imageView.image = [UIImage imageNamed:@"4"];
    cell.detailTextLabel.text = @"积分：200";
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0.45*SCREEN_HEIGHT/5;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
