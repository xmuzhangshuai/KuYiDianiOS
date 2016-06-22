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
#import "KDPersonalCenterViewController.h"
#import "KDScoreViewController.h"
#import "chartsTableViewCell.h"

@interface KDChartsViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation KDChartsViewController {
    UIView *headerView;
    UITableView *chartsTableView;
    UIView *footerView;
    //图标
    UIImageView *FirstAvaImageView;
    UIImageView *SecondAvaImageView;
    UIImageView *ThirdAvaImageView;
    //搜索信息
    UILabel *firstNameLabel;
    UILabel *secondNameLabel;
    UILabel *thirdNameLabel;
    UILabel *firstLabel;
    UILabel *secondLabel;
    UILabel *thirdLabel;
    
    //选择按钮，时间
    UIButton *monthButton;
    UIButton *weekButton;
    UIButton *allTimeButton;
    //地点选择
    UIButton *schoolButton;
    UIImageView *chartImageView;
    UIButton *allSchoolButton;
    
    NSMutableArray *chartsImageArr;
    
}

-(instancetype)init {
    if (self = [super init]) {
        chartsImageArr = [[NSMutableArray alloc] init];
        for (int i = 1; i < 5; i++) {
            [chartsImageArr addObject:[NSString stringWithFormat:@"avaImage%d", i]];
        }
    }
    return self;
}


-(void)UIInit {
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        //ios 7之后导航栏透明化
        self.navigationController.navigationBar.translucent = YES;
    }
    headerView = [[UIView alloc] init];
    FirstAvaImageView = [[UIImageView alloc] init];
    SecondAvaImageView = [[UIImageView alloc] init];
    ThirdAvaImageView = [[UIImageView alloc] init];
    firstNameLabel = [[UILabel alloc] init];
    secondNameLabel = [[UILabel alloc] init];
    thirdNameLabel = [[UILabel alloc] init];

    firstLabel = [[UILabel alloc] init];
    secondLabel = [[UILabel alloc] init];
    thirdLabel = [[UILabel alloc] init];
    
    weekButton = [[UIButton alloc] init];
//    //对图片进行处理
//    UIImage *image2 = [UIImage imageNamed:@"ChartButton"];
//    CGFloat top = 0; // 顶端盖高度
//    CGFloat bottom = 0; // 底端盖高度
//    CGFloat left = 15; // 左端盖宽度
////    CGFloat right = 15; // 右端盖宽度
////    
//    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
//    
//    image2 = [image2 resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
//    
//    [weekButton setBackgroundImage:image2 forState:UIControlStateNormal];
    weekButton.backgroundColor = [UIColor colorWithRed:233.0/255 green:232.0/255 blue:209.0/255 alpha:1];
    weekButton.layer.masksToBounds = YES;
    weekButton.layer.cornerRadius = 6;
    [weekButton setTitle:@"本周" forState:UIControlStateNormal];
    monthButton = [[UIButton alloc] init];
    monthButton.backgroundColor = [UIColor colorWithRed:233.0/255 green:232.0/255 blue:209.0/255 alpha:1];
    monthButton.layer.masksToBounds = YES;
    monthButton.layer.cornerRadius = 6;
    [monthButton setTitle:@"本月" forState:UIControlStateNormal];
    allTimeButton = [[UIButton alloc] init];
    allTimeButton.backgroundColor = [UIColor colorWithRed:233.0/255 green:232.0/255 blue:209.0/255 alpha:1];
    allTimeButton.layer.masksToBounds = YES;
    allTimeButton.layer.cornerRadius = 6;
    [allTimeButton setTitle:@"所有" forState:UIControlStateNormal];
    chartsTableView = [[UITableView alloc] init];
    chartsTableView.delegate = self;
    chartsTableView.dataSource = self;
    footerView = [[UIView alloc] init];
    schoolButton = [[UIButton alloc] init];
    schoolButton.backgroundColor = [UIColor colorWithRed:233.0/255 green:232.0/255 blue:209.0/255 alpha:1];
    schoolButton.layer.masksToBounds = YES;
    schoolButton.layer.cornerRadius = 6;
    [schoolButton setTitle:@"学校" forState:UIControlStateNormal];
    //chart的图标
    chartImageView = [[UIImageView alloc] init];
    chartImageView.image = [UIImage imageNamed:@"chartImage"];
    
    allSchoolButton = [[UIButton alloc] init];
    allSchoolButton.backgroundColor = [UIColor colorWithRed:233.0/255 green:232.0/255 blue:209.0/255 alpha:1];
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
    [headerView addSubview:FirstAvaImageView];
    [headerView addSubview:SecondAvaImageView];
    [headerView addSubview:ThirdAvaImageView];
    [headerView addSubview:firstNameLabel];
    [headerView addSubview:secondNameLabel];
    [headerView addSubview:thirdNameLabel];
    [headerView addSubview:firstLabel];
    [headerView addSubview:secondLabel];
    [headerView addSubview:thirdLabel];
    
    FirstAvaImageView.image = [UIImage imageNamed:@"headerAvaImage3"];
    [firstNameLabel setFont:[UIFont systemFontOfSize:11]];
    [firstLabel setFont:[UIFont systemFontOfSize:9]];
    firstNameLabel.textAlignment = NSTextAlignmentCenter;
    firstLabel.textAlignment = NSTextAlignmentCenter;
    firstNameLabel.text = @"刘云";
    firstLabel.numberOfLines = 0;
    firstLabel.text = @"本校\n积分：258\n等级：50";
    SecondAvaImageView.image = [UIImage imageNamed:@"headerAvaImage1"];
    [secondNameLabel setFont:[UIFont systemFontOfSize:11]];
    [secondLabel setFont:[UIFont systemFontOfSize:9]];
    secondNameLabel.textAlignment = NSTextAlignmentCenter;
    secondLabel.textAlignment = NSTextAlignmentCenter;
    secondNameLabel.text = @"刘云";
    secondLabel.numberOfLines = 0;
    secondLabel.text = @"本校\n积分：258\n等级：50";
    ThirdAvaImageView.image = [UIImage imageNamed:@"headerAvaImage2"];
    [thirdNameLabel setFont:[UIFont systemFontOfSize:11]];
    [thirdLabel setFont:[UIFont systemFontOfSize:9]];
    thirdNameLabel.textAlignment = NSTextAlignmentCenter;
    thirdLabel.textAlignment = NSTextAlignmentCenter;
    thirdNameLabel.text = @"刘云";
    thirdLabel.numberOfLines = 0;
    thirdLabel.text = @"本校\n积分：258\n等级：50";


    [self.view addSubview:chartsTableView];
    [self.view addSubview:footerView];
    [footerView addSubview:schoolButton];
    [footerView addSubview:chartImageView];
    [footerView addSubview:allSchoolButton];
    headerView.backgroundColor = [UIColor colorWithRed:244.0/255 green:154.0/255 blue:148.0/255 alpha:1];
    [monthButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [weekButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [allTimeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [schoolButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [allSchoolButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    footerView.backgroundColor = [UIColor colorWithRed:244.0/255 green:154.0/255 blue:148.0/255 alpha:1];
    
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.right.equalTo(self.view);
        make.height.mas_equalTo(0.45*SCREEN_HEIGHT);
    }];
    
    //创建间隙相等
    UIView * spaceOneView = UIView.new;
    UIView * spaceTwoView = UIView.new;
    [headerView addSubview:spaceTwoView];
    [headerView addSubview:spaceOneView];
    CGSize size = CGSizeMake(0.251*SCREEN_WIDTH, 0.15*SCREEN_HEIGHT);
    [FirstAvaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(size);
        make.top.equalTo(headerView).offset(80);
        make.left.equalTo(headerView).offset(20);
        make.right.equalTo(spaceOneView.mas_left);
    }];
    [firstNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(FirstAvaImageView.mas_bottomMargin);
        make.centerX.equalTo(FirstAvaImageView);
    }];
    [firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(FirstAvaImageView);
        make.top.equalTo(firstNameLabel.mas_bottom).offset(3);
    }];
    [SecondAvaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(FirstAvaImageView);
        make.top.equalTo(headerView).offset(70);
        make.left.equalTo(spaceOneView.mas_right);
        make.right.equalTo(spaceTwoView.mas_left);
    }];
    [secondNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(SecondAvaImageView.mas_bottomMargin);
        make.centerX.equalTo(SecondAvaImageView);
    }];
    [secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(SecondAvaImageView);
        make.top.equalTo(secondNameLabel.mas_bottom).offset(3);
    }];
    [ThirdAvaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(FirstAvaImageView);
        make.top.equalTo(headerView).offset(80);
        make.right.equalTo(headerView).offset(-30);
        make.left.equalTo(spaceTwoView.mas_right);
    }];
    [thirdNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ThirdAvaImageView.mas_bottomMargin);
        make.centerX.equalTo(ThirdAvaImageView);
    }];
    [thirdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ThirdAvaImageView);
        make.top.equalTo(thirdNameLabel.mas_bottom).offset(3);
    }];
    
    [spaceOneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(spaceTwoView.mas_width);
        make.top.equalTo(headerView);
    }];
    [spaceTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView);
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
        make.right.equalTo(chartImageView.mas_left).offset(-10);
        // 设置高度
        make.height.mas_equalTo(@30);
        // 宽度设置和view2以及view3相同
        make.width.equalTo(allSchoolButton);
    }];
    [chartImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(footerView).offset(20);
        make.height.mas_equalTo(schoolButton);
    }];
    [allSchoolButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(footerView).offset(20);
        make.left.equalTo(chartImageView.mas_right).offset(10);
        make.right.equalTo(footerView).with.offset(-30);
        make.width.and.height.equalTo(schoolButton);
    }];

}


-(void)UINavigationInit {
    
    ///Logo
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
}

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
    return 4;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    chartsTableViewCell *cell = [chartsTableViewCell cellWithTableView:tableView];
    cell.NameLabel.text = @"刘云";
    cell.rankImageView.image = [UIImage imageNamed:chartsImageArr[indexPath.row]];
    cell.rankScopeLabel.text = @"本校   积分：258   等级：50";
    cell.rankNumLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row+4];
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
