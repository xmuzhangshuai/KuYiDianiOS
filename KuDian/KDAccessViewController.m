//
//  KDAccessViewController.m
//  KuDian
//
//  Created by 黄明族 on 16/6/8.
//  Copyright © 2016年 黄明族. All rights reserved.
//

#import "KDAccessViewController.h"
#import "MBProgressHUD.h"
#import "UISize.h"
#import "AppDelegate.h"
#import "KDMainViewController.h"

@interface KDAccessViewController ()<UITextFieldDelegate, MBProgressHUDDelegate>

@end

@implementation KDAccessViewController {

    UITextField     *phoneTF;
    UITextField     *verifyTF;
    UIButton        *verifyButton;
    UIButton        *startButton;
    NSString    *previousTextFieldContent;
    UITextRange *previousSelection;
    
    UIView          *cover;
    NSTimer         *countDownTime;
    NSUserDefaults  *userDefaults;
    NSString        *phoneNumber;
    AppDelegate     *MyAppDelegate;
    BOOL            isConnect;
    int             countDown;
    
}

-(instancetype)init {
    if (self = [super init]) {
        phoneTF         = [[UITextField alloc]init];
        verifyTF        = [[UITextField alloc]init];
        verifyButton    = [[UIButton alloc]init];
        startButton     = [[UIButton alloc]init];
    }
    return self;
}


- (void)UIInit {
    phoneTF.frame = CGRectMake(0, 0, PHONETF_WIDTH, PHONETF_HEIGHT);
    phoneTF.center = CGPointMake(PHONETF_CENTER_X, PHONETF_CENTER_Y);
    phoneTF.placeholder = @"手机号";
    phoneTF.layer.cornerRadius = 6;
    phoneTF.layer.borderColor = [UIColor grayColor].CGColor;
    phoneTF.layer.borderWidth = 1;
    phoneTF.borderStyle = UITextBorderStyleRoundedRect;
    phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    phoneTF.delegate = self;
    [phoneTF addTarget:self action:@selector(TextFieldChanged) forControlEvents:UIControlEventEditingChanged];
    
    verifyButton.frame = CGRectMake(0, 0, VERIFYBUTTON_WIDTH, VERIFYBUTTON_HEIGHT);
    verifyButton.center = CGPointMake(VERIFYBUTTON_CENTER_X, PHONETF_CENTER_Y);
    verifyButton.backgroundColor = [UIColor grayColor];
    verifyButton.layer.cornerRadius = 6;
    verifyButton.enabled = false;
    [verifyButton setTitle:@"验证" forState:UIControlStateNormal];
    [verifyButton addTarget:self action:@selector(buttonDidVerify) forControlEvents:UIControlEventTouchUpInside];
    
    verifyTF.frame = CGRectMake(0, 0, VERIFYTF_WIDTH, PHONETF_HEIGHT);
    verifyTF.center = CGPointMake(SCREEN_CENTER_X, VERIFYTF_CENTER_Y);
    verifyTF.layer.cornerRadius = 6;
    verifyTF.layer.borderColor = [UIColor grayColor].CGColor;
    verifyTF.layer.borderWidth = 1;
    verifyTF.borderStyle = UITextBorderStyleRoundedRect;
    verifyTF.placeholder = @"验证码";
    verifyTF.keyboardType = UIKeyboardTypeNumberPad;
    // 点击验证按钮后才出现 没收到？
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0.15*SCREEN_WIDTH*1.5, 0.05*SCREEN_HEIGHT)];
    [rightButton setImage:[UIImage imageNamed:@"没收到验证码"] forState:UIControlStateNormal];
    verifyTF.rightView = rightButton;
    verifyTF.rightView.hidden = YES;
    [rightButton addTarget:self action:@selector(requestForCalling) forControlEvents:UIControlEventTouchUpInside];
    [verifyTF addTarget:self action:@selector(TextFieldChanged) forControlEvents:UIControlEventEditingChanged];
    
    startButton.frame = CGRectMake(0, 0, VERIFYTF_WIDTH, PHONETF_HEIGHT);
    startButton.center = CGPointMake(SCREEN_CENTER_X, STARTBUTTON_CENTER_Y);
    startButton.backgroundColor = [UIColor grayColor];
    startButton.layer.cornerRadius = 6;
    startButton.enabled = false;
    [startButton setTitle:@"开始" forState:UIControlStateNormal];
    
    [startButton addTarget:self action:@selector(buttonDidStart) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view addSubview:phoneTF];
    [self.view addSubview:verifyButton];
    [self.view addSubview:verifyTF];
    [self.view addSubview:startButton];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UIInit];
    
}


- (void)timeChanged {
    if (countDown == 0) {
        [countDownTime invalidate];
        countDownTime = nil;
        countDown = 60;
        verifyButton.backgroundColor = [UIColor greenColor];
        [verifyButton setTitle:@"验证" forState:UIControlStateNormal];
        verifyButton.enabled = true;
    }else {
        [verifyButton setTitle:[NSString stringWithFormat:@"%d秒", countDown--] forState:UIControlStateNormal];
    }
}


#pragma mark - UIButton Event

#pragma mark - TextField changed
-(void)TextFieldChanged {
    if (phoneTF.isFirstResponder) {
        NSUInteger targetCursorPosition = [phoneTF offsetFromPosition:phoneTF.beginningOfDocument
                                                           toPosition:phoneTF.selectedTextRange.start];
        // nStr表示不带空格的号码
        NSString* nStr = [phoneTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString* preTxt = [previousTextFieldContent stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        char editFlag = 0;// 正在执行删除操作时为0，否则为1
        
        if (nStr.length <= preTxt.length) {
            editFlag = 0;
        }
        else {
            editFlag = 1;
        }
        
        // textField设置text
        if (nStr.length > 11)
        {
            phoneTF.text = previousTextFieldContent;
            phoneTF.selectedTextRange = previousSelection;
            return;
        }
        
        // 空格
        NSString* spaceStr = @" ";
        
        NSMutableString* mStrTemp = [NSMutableString new];
        int spaceCount = 0;
        if (nStr.length < 3 && nStr.length > -1)
        {
            spaceCount = 0;
        }else if (nStr.length < 7 && nStr.length >2)
        {
            spaceCount = 1;
            
        }else if (nStr.length < 12 && nStr.length > 6)
        {
            spaceCount = 2;
        }
        
        for (int i = 0; i < spaceCount; i++)
        {
            if (i == 0) {
                [mStrTemp appendFormat:@"%@%@", [nStr substringWithRange:NSMakeRange(0, 3)], spaceStr];
            }else if (i == 1)
            {
                [mStrTemp appendFormat:@"%@%@", [nStr substringWithRange:NSMakeRange(3, 4)], spaceStr];
            }else if (i == 2)
            {
                [mStrTemp appendFormat:@"%@%@", [nStr substringWithRange:NSMakeRange(7, 4)], spaceStr];
            }
        }
        
        if (nStr.length == 11)
        {
            [mStrTemp appendFormat:@"%@%@", [nStr substringWithRange:NSMakeRange(7, 4)], spaceStr];
        }
        
        if (nStr.length < 4)
        {
            [mStrTemp appendString:[nStr substringWithRange:NSMakeRange(nStr.length-nStr.length % 3, nStr.length % 3)]];
        }else if(nStr.length > 3)
        {
            NSString *str = [nStr substringFromIndex:3];
            [mStrTemp appendString:[str substringWithRange:NSMakeRange(str.length-str.length % 4,
                                                                       str.length % 4)]];
            if (nStr.length == 11)
            {
                [mStrTemp deleteCharactersInRange:NSMakeRange(13, 1)];
            }
        }
        
        phoneTF.text = mStrTemp;
        // textField设置selectedTextRange
        NSUInteger curTargetCursorPosition = targetCursorPosition;// 当前光标的偏移位置
        if (editFlag == 0)
        {
            //删除
            if (targetCursorPosition == 9 || targetCursorPosition == 4)
            {
                curTargetCursorPosition = targetCursorPosition - 1;
            }
        }
        else {
            //添加
            if (nStr.length == 8 || nStr.length == 4)
            {
                curTargetCursorPosition = targetCursorPosition + 1;
            }
        }
        
        UITextPosition *targetPosition = [phoneTF positionFromPosition:[phoneTF beginningOfDocument]
                                                                offset:curTargetCursorPosition];
        [phoneTF setSelectedTextRange:[phoneTF textRangeFromPosition:targetPosition
                                                         toPosition :targetPosition]];
        
        if ([verifyButton.titleLabel.text isEqualToString:@"验证"]) {
            if ([phoneTF.text isEqual:@""]) {
                verifyButton.backgroundColor = [UIColor grayColor];
            }else if ([self isMobileNumber:[phoneTF.text stringByReplacingOccurrencesOfString:@" " withString:@""]]){
                verifyButton.backgroundColor = [UIColor greenColor];
                verifyButton.enabled = YES;
            }
        }
    }else if(verifyTF.isFirstResponder){
        if ([verifyTF.text length] >= 6) {
            verifyTF.text = [verifyTF.text substringWithRange:NSMakeRange(0, 6)];
        }
        if ([verifyTF.text isEqual:@""]) {
            startButton.backgroundColor = [UIColor grayColor];
        }else if([self isVerifyNumber:verifyTF.text]){
            startButton.backgroundColor = [UIColor greenColor];
            startButton.enabled = YES;
        }
    }
}

#pragma mark - VertifyButton TouchInside
-(void)buttonDidVerify {
    
}

#pragma mark - 没收到验证码
-(void)requestForCalling {
    
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

#pragma mark - 私有方法
- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    NSString *pattern = @"^1+[3578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:mobileNum];
    return isMatch;
}

- (BOOL)isVerifyNumber:(NSString *)verifyNum
{
    NSString *pattern = @"[0-9]{6}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:verifyNum];
    return isMatch;
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
