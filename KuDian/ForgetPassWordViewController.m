//
//  ForgetPassWordViewController.m
//  KuDian
//
//  Created by 黄明族 on 16/6/21.
//  Copyright © 2016年 黄明族. All rights reserved.
//

#import "ForgetPassWordViewController.h"
#import "KDMainViewController.h"


@interface ForgetPassWordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *checkNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *PassWordFirstTextField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordSecondTextField;

@end

@implementation ForgetPassWordViewController
-(void)UIInit {
    //设置textField的placehold的字体颜色
    [self.phoneNumTextField setValue:[UIColor colorWithRed:103.0/255 green:103.0/255 blue:103.0/255 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self.checkNumTextField setValue:[UIColor colorWithRed:103.0/255 green:103.0/255 blue:103.0/255 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self.PassWordFirstTextField setValue:[UIColor colorWithRed:103.0/255 green:103.0/255 blue:103.0/255 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self.PasswordSecondTextField setValue:[UIColor colorWithRed:103.0/255 green:103.0/255 blue:103.0/255 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    
    
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

#pragma mark Textfield Event
//结束编辑
- (IBAction)PhoneNumEdiEnd:(UITextField *)sender {
    NSLog(@"phoneNum:...%@", sender.text);
}
//点击结束事件
- (IBAction)checkNumEditEnd:(UITextField *)sender {
    NSLog(@"checkNum:...%@", sender.text);
}
- (IBAction)FirstPassWordEditEnd:(UITextField *)sender {
}
- (IBAction)PasswordOneceEdiEnd:(UITextField *)sender {
}

#pragma mark - buttonEvent
- (IBAction)confirmInformation:(UIButton *)sender {
    KDMainViewController *main = [[KDMainViewController alloc] init];
    [self.navigationController pushViewController:main animated:YES];
}
- (IBAction)ThirdLogin:(UIButton *)sender {
}



#pragma mark - NavigationBar button event
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
