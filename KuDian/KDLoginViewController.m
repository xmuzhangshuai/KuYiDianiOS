//
//  KDLoginViewController.m
//  KuDian
//
//  Created by 黄明族 on 16/5/31.
//  Copyright © 2016年 黄明族. All rights reserved.
//

#import "KDLoginViewController.h"
#import "UISize.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "KDMainViewController.h"



@interface KDLoginViewController ()<UITextFieldDelegate, MBProgressHUDDelegate>
@property (weak, nonatomic) IBOutlet UITextField *LoginNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *LoginPassWordTextField;
@property (weak, nonatomic) IBOutlet UIButton *StartAccessBtn;
@property (weak, nonatomic) IBOutlet UIButton *ForgetPassWordBtn;
@property (weak, nonatomic) IBOutlet UIButton *SignUpBtn;
@property (weak, nonatomic) IBOutlet UIButton *WechatLoginBtn;

@end

@implementation KDLoginViewController {
    AppDelegate     *MyAppDelegate;
    

}

-(instancetype)init {
    if (self = [super init]) {
       
    }
    return self;
}


- (void)UIInit {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UIInit];
    
}


#pragma mark - buttonDidStart
-(void)buttonDidStart {
        //验证等待动画
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.delegate = self;
        hud.labelText = @"请稍候";
        hud.dimBackground = YES;
        [hud hide:YES afterDelay:1];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //整个view失去第一响应者的身份
    [self.view endEditing:YES];
}

#pragma mark - MBProgressDelegate
-(void)hudWasHidden:(MBProgressHUD *)hud {
    KDMainViewController *mainViewController = [[KDMainViewController alloc] init];
    [self.navigationController pushViewController:mainViewController animated:YES];
}


#pragma mark - ButtonEvent
- (IBAction)ForgetPassWord:(id)sender {
    
}
/** 注册*/
- (IBAction)SignUp:(id)sender {
    
}
/** 第三方登录*/
- (IBAction)WeChatLogin:(id)sender {
    
}
/** 登录*/
- (IBAction)StartAccess:(id)sender {
    //验证等待动画
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.delegate = self;
    hud.labelText = @"请稍候";
    hud.dimBackground = YES;
    [hud hide:YES afterDelay:1];
}
/** 用户名*/
- (IBAction)TextFieldChange:(id)sender {
    NSLog(@"NameTextField发生了改变");
}
/** 密码*/
- (IBAction)passWordTextFieldChange:(id)sender {
    NSLog(@"passWordTextField发生了改变");
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
