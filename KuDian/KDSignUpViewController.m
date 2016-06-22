//
//  KDSignUpViewController.m
//  KuDian
//
//  Created by 黄明族 on 16/6/17.
//  Copyright © 2016年 黄明族. All rights reserved.
//

#import "KDSignUpViewController.h"
#import "KDMainViewController.h"


@interface KDSignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *smallNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *schoolNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumLabel;
@property (weak, nonatomic) IBOutlet UITextField *checkNumLabel;

@end

@implementation KDSignUpViewController



-(void)UIInit {
    
    
    [self UINavigationInit];
}

-(void)UINavigationInit {
    //侧拉栏
    UIBarButtonItem *backButton;
    backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(getbackMain)];
    backButton.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self UIInit];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //整个view失去第一响应者的身份
    [self.view endEditing:YES];
}


#pragma mark - button event
-(void)getbackMain {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)confirm:(UIButton *)sender {
    KDMainViewController *mainVC = [[KDMainViewController alloc] init];
    [self.navigationController pushViewController:mainVC animated:YES];
    
}

- (IBAction)thirdSignup:(UIButton *)sender {
}
- (IBAction)editSmallNameLabel:(UITextField *)sender {
}
- (IBAction)editSchoolNameLabel:(UITextField *)sender {
}
- (IBAction)editPhondeNumLabel:(UITextField *)sender {
}
- (IBAction)editCheckNumLabel:(UITextField *)sender {
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
