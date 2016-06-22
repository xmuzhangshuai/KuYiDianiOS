//
//  KDScoreViewController.m
//  KuDian
//
//  Created by 黄明族 on 16/6/13.
//  Copyright © 2016年 黄明族. All rights reserved.
//

#import "KDScoreViewController.h"

#import "UISize.h"
#import "KDPersonalCenterViewController.h"

#define PERSONALINFORMATIONVIEW_WIDTH 0.616*SCREEN_WIDTH
#define PERSONALINFORMATIONVIEW_HEIGHT 0.154*SCREEN_HEIGHT
#define LTVIEW_HIGHT PERSONALINFORMATIONVIEW_HEIGHT/3


@interface KDScoreViewController () {
    //我的积分
    UIImageView *avaImageView;
    UILabel *scoreNameLabel;
    UILabel *scoreLabel;
    //我全部的积分
    UILabel *allScoreNameLabel;
    UILabel *allScoreLabel;
   
    //个人信息view
    UIView *PersonalInformationView;
    //四个详细信息View
    UIView *NameView;
    UIView *SchoolView;
    UIView *MarkNumView;
    
    //图片
    UIImageView *personalImageView;
    
    //UILabel
    UILabel *NameLabel;
    UILabel *SchoolLabel;
    UILabel *markNumLabel;
    
    //UIButton
//    UIButton *startBtn;
    //修改个人信心
    UIButton *changePersonalBtn;

}

@end

@implementation KDScoreViewController

-(void)UIInit {
    avaImageView = [[UIImageView alloc]  init];
    scoreNameLabel = [[UILabel alloc] init];
    scoreLabel = [[UILabel alloc] init];
    allScoreLabel = [[UILabel alloc] init];
    allScoreNameLabel = [[UILabel alloc] init];
    
    PersonalInformationView = [[UIView alloc] init];
    
    NameView = [[UIView alloc] init];
    SchoolView = [[UIView alloc] init];
    MarkNumView = [[UIView alloc] init];
    
    
    personalImageView = [[UIImageView alloc] init];
    
    
    
    NameLabel = [[UILabel alloc] init];
    SchoolLabel = [[UILabel alloc] init];
    markNumLabel = [[UILabel alloc] init];
    
//    startBtn = [[UIButton alloc] init];
    changePersonalBtn = [[UIButton alloc] init];
    
    [self UILayout];
}

-(void)UILayout {
    [self.view addSubview:avaImageView];
    [avaImageView addSubview:scoreNameLabel];
    [avaImageView addSubview:scoreLabel];
    [avaImageView addSubview:allScoreNameLabel];
    [avaImageView addSubview:allScoreLabel];
    
    [self.view addSubview:PersonalInformationView];
    [self.view addSubview:changePersonalBtn];
//    [self.view addSubview:startBtn];
    
    avaImageView.image = [UIImage imageNamed:@"scoreAvaImage"];
//    avaImageView.layer.masksToBounds = YES;
//    avaImageView.layer.cornerRadius = 6;
    scoreNameLabel.text = @"我的积分";
    scoreNameLabel.textColor = [UIColor whiteColor];
    scoreLabel.text = @"159";
    scoreLabel.textColor = [UIColor whiteColor];
    allScoreNameLabel.text = @"我全部的积分";
    allScoreNameLabel.textColor = [UIColor whiteColor];
    allScoreNameLabel.numberOfLines = 0;
    allScoreLabel.text = @"698";
    allScoreLabel.textColor = [UIColor whiteColor];
    avaImageView.frame = CGRectMake(0, 0, 0.556*SCREEN_WIDTH, 0.36*SCREEN_HEIGHT);
    avaImageView.center = CGPointMake(0.5*SCREEN_WIDTH, 0.34*SCREEN_HEIGHT);
    
    //我的积分
    scoreNameLabel.frame = CGRectMake(0.073*SCREEN_WIDTH, 0.09*SCREEN_HEIGHT, 0.40*SCREEN_WIDTH, 0.034*SCREEN_HEIGHT);
//    scoreNameLabel.center = CGPointMake(0.5*SCREEN_WIDTH, 0.1*SCREEN_HEIGHT);
    
    [scoreNameLabel setFont:[UIFont systemFontOfSize:23]];
    //积分
    scoreLabel.frame = CGRectMake(0.073*SCREEN_WIDTH, scoreNameLabel.frame.origin.y+0.044*SCREEN_HEIGHT, 0.40*SCREEN_WIDTH, 0.077*SCREEN_HEIGHT);
    [scoreLabel setFont:[UIFont systemFontOfSize:49]];
    //我全部的积分
    allScoreNameLabel.frame = CGRectMake(0.073*SCREEN_WIDTH, scoreLabel.frame.origin.y+0.1*SCREEN_HEIGHT, 0.40*SCREEN_WIDTH, 0.034*SCREEN_HEIGHT);
    [allScoreNameLabel setFont:[UIFont systemFontOfSize:17]];
    allScoreLabel.frame = CGRectMake(0.073*SCREEN_WIDTH, allScoreNameLabel.frame.origin.y+0.034*SCREEN_HEIGHT, 0.40*SCREEN_WIDTH, 0.034*SCREEN_HEIGHT);
    [allScoreLabel setFont:[UIFont systemFontOfSize:17]];
    allScoreLabel.textAlignment = NSTextAlignmentCenter;
    allScoreNameLabel.textAlignment = NSTextAlignmentCenter;
    scoreNameLabel.textAlignment = NSTextAlignmentCenter;
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    
    PersonalInformationView.frame = CGRectMake(0, 0, PERSONALINFORMATIONVIEW_WIDTH, PERSONALINFORMATIONVIEW_HEIGHT);
    PersonalInformationView.center = CGPointMake(0.5*SCREEN_WIDTH, 0.7*SCREEN_HEIGHT);
    
    [PersonalInformationView addSubview:NameView];
    [PersonalInformationView addSubview:SchoolView];
    [PersonalInformationView addSubview:MarkNumView];
    
    NameView.frame = CGRectMake(0, 0, PERSONALINFORMATIONVIEW_WIDTH, PERSONALINFORMATIONVIEW_HEIGHT/3);
    SchoolView.frame = CGRectMake(0, LTVIEW_HIGHT, PERSONALINFORMATIONVIEW_WIDTH, LTVIEW_HIGHT);
    MarkNumView.frame = CGRectMake(0, 2*LTVIEW_HIGHT, PERSONALINFORMATIONVIEW_WIDTH, LTVIEW_HIGHT);
    
    NameView.backgroundColor = [UIColor colorWithRed:228.0/255 green:226.0/255 blue:214.0/255 alpha:1];
    NameView.layer.borderColor = [UIColor grayColor].CGColor;
    NameView.layer.borderWidth = 0.5;
    
    SchoolView.backgroundColor = [UIColor colorWithRed:237.0/255 green:236.0/255 blue:225.0/255 alpha:1];
    SchoolView.layer.borderColor = [UIColor grayColor].CGColor;
    SchoolView.layer.borderWidth = 0.5;
    
    MarkNumView.backgroundColor = [UIColor colorWithRed:237.0/255 green:236.0/255 blue:225.0/255 alpha:1];
    MarkNumView.layer.borderColor = [UIColor grayColor].CGColor;
    MarkNumView.layer.borderWidth = 0.5;

    
    [SchoolView addSubview:personalImageView];
    [NameView addSubview:NameLabel];
    [SchoolView addSubview:SchoolLabel];
    
    [MarkNumView addSubview:markNumLabel];
    
    personalImageView.frame = CGRectMake(0.05*PERSONALINFORMATIONVIEW_WIDTH, 5, 0.064*SCREEN_WIDTH, 0.064*SCREEN_WIDTH);
    personalImageView.image = [UIImage imageNamed:@"scoreImage"];
    [NameLabel setFont:[UIFont systemFontOfSize:15]];
    [SchoolLabel setFont:[UIFont systemFontOfSize:15]];
    [markNumLabel setFont:[UIFont systemFontOfSize:15]];
//    NameLabel.frame = CGRectMake(0.3*PERSONALINFORMATIONVIEW_WIDTH, 0, 0.7*PERSONALINFORMATIONVIEW_WIDTH, LTVIEW_HIGHT);
//    NameLabel.text = @"六月 2016";
//    SchoolLabel.frame = CGRectMake(0.3*PERSONALINFORMATIONVIEW_WIDTH, 0, 0.7*PERSONALINFORMATIONVIEW_WIDTH, LTVIEW_HIGHT);
//    SchoolLabel.text = @"刘云";
//    markNumLabel.frame = CGRectMake(0.3*PERSONALINFORMATIONVIEW_WIDTH, 0, 0.7*PERSONALINFORMATIONVIEW_WIDTH, LTVIEW_HIGHT);
//    markNumLabel.text = @"厦门大学";
    NameLabel.textAlignment = NSTextAlignmentCenter;
    SchoolLabel.textAlignment = NSTextAlignmentCenter;
    markNumLabel.textAlignment = NSTextAlignmentCenter;
    NameLabel.frame = CGRectMake(0, 0, PERSONALINFORMATIONVIEW_WIDTH, LTVIEW_HIGHT);
    NameLabel.text = @"六月 2016";
    SchoolLabel.frame = CGRectMake(0, 0, PERSONALINFORMATIONVIEW_WIDTH, LTVIEW_HIGHT);
    SchoolLabel.text = @"刘云";
    markNumLabel.frame = CGRectMake(0, 0, PERSONALINFORMATIONVIEW_WIDTH, LTVIEW_HIGHT);
    markNumLabel.text = @"厦门大学";

    /*
    startBtn.frame = CGRectMake(0, 0, 0.3*SCREEN_WIDTH, 40);
    startBtn.center = CGPointMake(0.5*SCREEN_WIDTH, 0.82*SCREEN_HEIGHT);
    [startBtn setTitle:@"开始" forState:UIControlStateNormal];
    startBtn.layer.masksToBounds = YES;
    startBtn.layer.cornerRadius = 6;
    startBtn.backgroundColor = [UIColor colorWithRed:232.0/255 green:145.0/255 blue:141.0/255 alpha:1];
    */
    //更改个人信息
    changePersonalBtn.frame = CGRectMake(0, SCREEN_HEIGHT-40, SCREEN_WIDTH, 40);
    changePersonalBtn.backgroundColor = [UIColor colorWithRed:198.0/255 green:238.0/255 blue:239.0/255 alpha:1];
    [changePersonalBtn setTitle:@"修改个人信息" forState:UIControlStateNormal];
    [changePersonalBtn addTarget:self action:@selector(getChangePersonal) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)UINavigationInit {
//    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:198.0/255 green:238.0/255 blue:239.0/255 alpha:1]];
    
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
    self.view.backgroundColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:229.0/255 alpha:1];
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

-(void)getChangePersonal {
    KDPersonalCenterViewController *personal = [[KDPersonalCenterViewController alloc] init];
    [self.navigationController pushViewController:personal animated:YES];
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
