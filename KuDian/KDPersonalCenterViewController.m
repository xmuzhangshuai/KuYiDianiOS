//
//  KDPersonalCenterViewController.m
//  KuDian
//
//  Created by 黄明族 on 16/6/12.
//  Copyright © 2016年 黄明族. All rights reserved.
//

#import "KDPersonalCenterViewController.h"
#import "UISize.h"
#import "KDScoreViewController.h"



#define PERSONALINFORMATIONVIEW_WIDTH 0.616*SCREEN_WIDTH
#define PERSONALINFORMATIONVIEW_HEIGHT 0.154*SCREEN_HEIGHT
#define LTVIEW_HIGHT PERSONALINFORMATIONVIEW_HEIGHT/3


@interface KDPersonalCenterViewController ()

@end

@implementation KDPersonalCenterViewController {
    //头像
    UIImageView *avaImageView;
    //个人信息view
    UIView *PersonalInformationView;
    //四个详细信息View
    UIView *NameView;
    UIView *SchoolView;
    UIView *PhoneNumView;
    //图片
    UIImageView *personalImageView;
    UIImageView *phoneImageView;
    
    //UITextField
    UITextField *NameTextField;
    UITextField *SchoolTextField;
    UITextField *markNumTextField;
    UITextField *phoneNumTextField;
    
    //确定和取消按钮
    UIButton *okBtn;
    UIButton *cancelBtn;
    
}

-(void)UIInit {
    avaImageView = [[UIImageView alloc]  init];
    PersonalInformationView = [[UIView alloc] init];
    
    NameView = [[UIView alloc] init];
    SchoolView = [[UIView alloc] init];
    PhoneNumView = [[UIView alloc] init];
    
    personalImageView = [[UIImageView alloc] init];
    phoneImageView = [[UIImageView alloc] init];
    
    NameTextField = [[UITextField alloc] init];
    SchoolTextField = [[UITextField alloc] init];
    markNumTextField = [[UITextField alloc] init];
    phoneNumTextField =[[UITextField alloc] init];
    okBtn = [[UIButton alloc] init];
    cancelBtn = [[UIButton alloc] init];
    [self UILayout];
}

-(void)UILayout {
    [self.view addSubview:avaImageView];
    [self.view addSubview:PersonalInformationView];
    [self.view addSubview:okBtn];
    [self.view addSubview:cancelBtn];
    
    //placeholder "scorePlaceHoldImage"
    avaImageView.image = [UIImage imageNamed:@"PersonalAvaImage"];
    avaImageView.layer.masksToBounds = YES;
    avaImageView.layer.cornerRadius = 0.3*SCREEN_WIDTH/2;
    avaImageView.frame = CGRectMake(0, 0, 0.3*SCREEN_WIDTH, 0.2*SCREEN_HEIGHT);
    avaImageView.center = CGPointMake(0.5*SCREEN_WIDTH, 0.3*SCREEN_HEIGHT);
    
    PersonalInformationView.frame = CGRectMake(0, 0, PERSONALINFORMATIONVIEW_WIDTH, PERSONALINFORMATIONVIEW_HEIGHT);
    PersonalInformationView.center = CGPointMake(0.5*SCREEN_WIDTH, 0.582*SCREEN_HEIGHT);
    PersonalInformationView.backgroundColor = [UIColor colorWithRed:232.0/255 green:234.0/255 blue:220.0/255 alpha:1];
    
    [PersonalInformationView addSubview:NameView];
    [PersonalInformationView addSubview:SchoolView];
    [PersonalInformationView addSubview:PhoneNumView];
    
    NameView.frame = CGRectMake(0, 0, PERSONALINFORMATIONVIEW_WIDTH, PERSONALINFORMATIONVIEW_HEIGHT/3);
    SchoolView.frame = CGRectMake(0, LTVIEW_HIGHT, PERSONALINFORMATIONVIEW_WIDTH, LTVIEW_HIGHT);
    PhoneNumView.frame = CGRectMake(0, 2*LTVIEW_HIGHT, PERSONALINFORMATIONVIEW_WIDTH, LTVIEW_HIGHT);
    
    
    NameView.backgroundColor = [UIColor colorWithRed:228.0/255 green:226.0/255 blue:214.0/255 alpha:1];
    NameView.layer.borderColor = [UIColor grayColor].CGColor;
    NameView.layer.borderWidth = 0.5;
    
    SchoolView.backgroundColor = [UIColor colorWithRed:237.0/255 green:236.0/255 blue:225.0/255 alpha:1];
    SchoolView.layer.borderColor = [UIColor grayColor].CGColor;
    SchoolView.layer.borderWidth = 0.5;
    
    
    [NameView addSubview:NameTextField];
    [NameView addSubview:personalImageView];
    [SchoolView addSubview:SchoolTextField];
    [PhoneNumView addSubview:phoneNumTextField];
    [PhoneNumView addSubview:phoneImageView];
    
    personalImageView.frame = CGRectMake(0.05*PERSONALINFORMATIONVIEW_WIDTH, 5, 0.064*SCREEN_WIDTH, 0.064*SCREEN_WIDTH);
    personalImageView.image = [UIImage imageNamed:@"scoreImage"];
    phoneImageView.frame = CGRectMake(0.05*PERSONALINFORMATIONVIEW_WIDTH, 5, 0.064*SCREEN_WIDTH, 0.064*SCREEN_WIDTH);
    phoneImageView.image = [UIImage imageNamed:@"scorePhone"];
    NameTextField.textAlignment = NSTextAlignmentCenter;
    SchoolTextField.textAlignment = NSTextAlignmentCenter;
    phoneNumTextField.textAlignment = NSTextAlignmentCenter;
    NameTextField.placeholder = @"名字";
    SchoolTextField.placeholder = @"学校";
    phoneNumTextField.placeholder = @"手机号码";
    [NameTextField setFont:[UIFont systemFontOfSize:15]];
    [SchoolTextField setFont:[UIFont systemFontOfSize:15]];
    NameTextField.frame = CGRectMake(0, 0, PERSONALINFORMATIONVIEW_WIDTH, LTVIEW_HIGHT);
    SchoolTextField.frame = CGRectMake(0, 0, PERSONALINFORMATIONVIEW_WIDTH, LTVIEW_HIGHT);
    phoneNumTextField.frame = CGRectMake(0, 0, PERSONALINFORMATIONVIEW_WIDTH, LTVIEW_HIGHT);
    /*
     startBtn.frame = CGRectMake(0, 0, 0.3*SCREEN_WIDTH, 40);
     startBtn.center = CGPointMake(0.5*SCREEN_WIDTH, 0.82*SCREEN_HEIGHT);
     [startBtn setTitle:@"开始" forState:UIControlStateNormal];
     startBtn.layer.masksToBounds = YES;
     startBtn.layer.cornerRadius = 6;
     startBtn.backgroundColor = [UIColor colorWithRed:232.0/255 green:145.0/255 blue:141.0/255 alpha:1];
     */
    //更改个人信息
    okBtn.frame = CGRectMake(0, SCREEN_HEIGHT-82, SCREEN_WIDTH, 40);
    okBtn.backgroundColor = [UIColor colorWithRed:198.0/255 green:238.0/255 blue:239.0/255 alpha:1];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(changeInformation) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.frame = CGRectMake(0, SCREEN_HEIGHT-40, SCREEN_WIDTH, 40);
    cancelBtn.backgroundColor = [UIColor colorWithRed:198.0/255 green:238.0/255 blue:239.0/255 alpha:1];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelChoose) forControlEvents:UIControlEventTouchUpInside];
}

-(void)UINavigationInit {
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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - button event
-(void)getToPersonal {
    KDScoreViewController *score = [[KDScoreViewController alloc] init];
    [self.navigationController pushViewController:score animated:YES];
    
}

-(void)cancelChoose {
    //取消按钮，应该消除界面上的数据，或者重新加载界面，将界面的数据清空
    NameTextField.text = nil;
    SchoolTextField.text = nil;
    phoneNumTextField.text = nil;
}

-(void)changeInformation {
    //ok按钮，应该保存数据，并且返回积分界面显示。。
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getbackMain {
    [self.navigationController popViewControllerAnimated:YES];
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
