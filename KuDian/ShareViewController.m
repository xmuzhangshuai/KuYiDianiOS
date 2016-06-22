//
//  ShareViewController.m
//  KuDian
//
//  Created by 黄明族 on 16/6/20.
//  Copyright © 2016年 黄明族. All rights reserved.
//

#import "ShareViewController.h"
#import "UISize.h"
#import "KDScoreViewController.h"

@interface ShareViewController ()

@end

@implementation ShareViewController {
    //分享描述
    UILabel *shareNameLabel;
    UILabel *shareDetailLabel;
    //分享代码View
    UIView *shareView;
    UILabel *Label1;
    UILabel *codeLabel;
    //input
    UITextField *inputTextField;
    //sharebutton
    UIButton *shareButton;
}


-(void)UIInit {
    shareNameLabel = [[UILabel alloc] init];
    shareDetailLabel = [[UILabel alloc] init];
    shareView = [[UIView alloc] init];
    Label1 = [[UILabel alloc] init];
    codeLabel = [[UILabel alloc] init];
    inputTextField = [[UITextField alloc] init];
    shareButton = [[UIButton alloc] init];
    
    [self UILayout];
}

-(void)UILayout {
    [self.view addSubview:shareNameLabel];
    [self.view addSubview:shareDetailLabel];
    [self.view addSubview:shareView];
    [shareView addSubview:Label1];
    [shareView addSubview:codeLabel];
    [self.view addSubview:inputTextField];
    [self.view addSubview:shareButton];
    
    shareNameLabel.frame = CGRectMake(0, 0, 0.263*SCREEN_WIDTH, 0.028*SCREEN_HEIGHT);
    shareNameLabel.center = CGPointMake(0.22*SCREEN_WIDTH, 0.168*SCREEN_HEIGHT);
    [shareNameLabel setFont:[UIFont systemFontOfSize:19]];
    shareNameLabel.text = @"分享代码";
    shareDetailLabel.frame = CGRectMake(0, 0, 0.71*SCREEN_WIDTH, 0.105*SCREEN_HEIGHT);
    shareDetailLabel.center = CGPointMake(0.511*SCREEN_WIDTH, 0.312*SCREEN_HEIGHT);
    [shareDetailLabel setFont:[UIFont systemFontOfSize:17]];
    shareDetailLabel.numberOfLines = 0;
    shareDetailLabel.text = @"点击分享可以邀请您的朋友。当邀请成功时，则会同时获得10分免费积分！";
    
    shareView.frame = CGRectMake(0, 0, 0.408*SCREEN_WIDTH, 0.12*SCREEN_HEIGHT);
    shareView.center = self.view.center;
    shareView.backgroundColor = [UIColor colorWithRed:198.0/255 green:238.0/255 blue:238.0/255 alpha:1];
    shareView.layer.masksToBounds = YES;
    shareView.layer.cornerRadius = 6;
    Label1.frame = CGRectMake(0, 0, shareView.frame.size.width, shareView.frame.size.height/2);
    [Label1 setFont:[UIFont systemFontOfSize:17]];
    Label1.textAlignment = NSTextAlignmentCenter;
    Label1.text = @"您的分享代码：";
    codeLabel.frame = CGRectMake(0, Label1.frame.size.height-10, shareView.frame.size.width, shareView.frame.size.height/2);
    [codeLabel setFont:[UIFont systemFontOfSize:17]];
    codeLabel.textAlignment = NSTextAlignmentCenter;
    codeLabel.text = @"5JUDJ";
    inputTextField.frame = CGRectMake(0, 0, 0.512*SCREEN_WIDTH, 0.072*SCREEN_HEIGHT);
    inputTextField.center = CGPointMake(0.5*SCREEN_WIDTH, 0.64*SCREEN_HEIGHT);
    inputTextField.layer.masksToBounds = YES;
    inputTextField.layer.cornerRadius = 6;
    inputTextField.placeholder = @"请输入代码";
    inputTextField.backgroundColor = [UIColor whiteColor];
    shareButton.frame = CGRectMake(0, 0, 0.66*SCREEN_WIDTH, 0.076*SCREEN_HEIGHT);
    shareButton.center = CGPointMake(0.5*SCREEN_WIDTH, 0.84*SCREEN_HEIGHT);
    shareButton.layer.masksToBounds = YES;
    shareButton.layer.cornerRadius = 6;
    [shareButton setTitle:@"分享" forState:UIControlStateNormal];
    shareButton.backgroundColor = [UIColor colorWithRed:213.0/255 green:135.0/255 blue:132.0/255 alpha:1];
    [shareButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:248.0/255 green:246.0/255 blue:233.0/255 alpha:1];
    [self UIInit];
    [self UINavigationInit];
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


#pragma mark - button event
-(void)getToPersonal {
    KDScoreViewController *score = [[KDScoreViewController alloc] init];
    [self.navigationController pushViewController:score animated:YES];
}

-(void)getbackMain {
    [self.navigationController popViewControllerAnimated:YES];
}

//分享
-(void)share {
    
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
