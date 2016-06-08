//
//  InfoViewController.m
//  ElephantBike
//
//  Created by 黄杰锋 on 16/1/20.
//  Copyright © 2016年 黄杰锋. All rights reserved.
//

#import "InfoViewController.h"
#import "KDLoginViewController.h"
#import "KDMarkViewController.h"
#import "KDMainViewController.h"

#import "UISize.h"
#import "AppDelegate.h"
#import "Masonry.h"



@interface InfoViewController () <UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate>

@end

@implementation InfoViewController{
    UILabel     *nameLabel;
    UILabel     *identificationLabel;
    UITableView *infoTableView;
    UIImageView *logoImageView;
    UIImageView *avatarImage;
    NSArray     *listArray;
    
    /** 是否已开通大象会员*/
    UIButton *ElephantMemberButton;
    UIImageView *AdImageView;
    
    AppDelegate *myAppDelegate;
    NSUserDefaults *userDefaults;
    
    UILabel     *phoneNumberLabel;  // 电话label
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super init]) {
        self.view.frame = frame;
       
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        myAppDelegate           = (AppDelegate *)[[UIApplication sharedApplication] delegate];
       
    }
    return self;
}

#pragma mark - UIInit
- (void)UIInit {
    avatarImage             = [[UIImageView alloc] init];
    nameLabel               = [[UILabel alloc] init];
    identificationLabel     = [[UILabel alloc] init];
    infoTableView           = [[UITableView alloc] init];
    logoImageView           = [[UIImageView alloc] init];
    
    userDefaults            = [NSUserDefaults standardUserDefaults];
    phoneNumberLabel        = [[UILabel alloc] init];
    
    /** 会员按钮*/
    ElephantMemberButton    = [UIButton buttonWithType:UIButtonTypeCustom];
    AdImageView             = [[UIImageView alloc] init];
    
     listArray               = @[@"主页", @"我的收藏", @"我的积分", @"分享", @"帮助中心", @"定时器", @"登出"];
    
    [self NavigationInit];
    [self UILayout];
}

- (void)NavigationInit {

}

- (void)UILayout {
    
    [self.view addSubview:avatarImage];
    [self.view addSubview:nameLabel];
    [self.view addSubview:identificationLabel];
    [self.view addSubview:infoTableView];
    
    avatarImage.frame = CGRectMake(0, 0, AVATARIMAGE_WIDTH, AVATARIMAGE_HEIGHT);
    avatarImage.center = CGPointMake(0.13*SCREEN_WIDTH, 0.11*SCREEN_HEIGHT);
    avatarImage.image = [UIImage imageNamed:@"1"];
    // 将方形图片剪裁成圆的
    avatarImage.layer.masksToBounds = YES;
    avatarImage.layer.cornerRadius = AVATARIMAGE_WIDTH/2;

    nameLabel.frame = CGRectMake(0.23*SCREEN_WIDTH, 0.05*SCREEN_HEIGHT, NAMELABEL_WIDTH, NAMELABEL_HEIGHT);
    NSLog(@"identity:%d", myAppDelegate.isIdentify);
    if (myAppDelegate.isIdentify) {
        nameLabel.text = [userDefaults objectForKey:@"name"];
    }else {
        nameLabel.text = @"刘云";
    }

    nameLabel.textAlignment = NSTextAlignmentLeft;
    
    identificationLabel.frame = CGRectMake(0.23*SCREEN_WIDTH, 0.09*SCREEN_HEIGHT, IDENTIFICATIONLABEL_WIDTH, IDENTIFICATIONLABEL_HEIGHT);
    if (myAppDelegate.isIdentify) {
        identificationLabel.text = [NSString stringWithFormat:@"%@", [userDefaults objectForKey:@"college"]];
    }else {
        identificationLabel.text = @"厦门大学";
    }
    identificationLabel.textAlignment = NSTextAlignmentLeft;
    
    infoTableView.frame = CGRectMake(0, 0.25*SCREEN_HEIGHT, INFOTABLEVIEW_WIDTH, INFOTABLEVIEW_HEIGHT);
    infoTableView.dataSource = self;
    infoTableView.delegate = self;
    infoTableView.scrollEnabled = NO;
   
}


#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [listArray objectAtIndex:indexPath.row];
    NSLog(@"indexpath.row:%ld", (long)indexPath.row);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;


    if (indexPath.row == 2) {
        NSString *str = [@"余额:" stringByAppendingString:@"100"];
        NSString *str1 = [str stringByAppendingString:@"分"];
        cell.detailTextLabel.text = str1;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  INFOTABLEVIEW_HEIGHT/7;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            //回到主界面
            [self.delegate removeFromSuperView:NO];
        }
            break;
        case 1:{
            //收藏界面
            KDMarkViewController *mark = [[KDMarkViewController alloc] init];
            [self.delegate getNextViewController:mark];
        }
            break;
        case 2:{
            //我的积分界面
            
        }
            break;
        case 3:{
            //分享界面
            
        }
            break;
        case 4:{
            //帮助中心
           
        }
            break;
        case 5:{
            //定时器
            
        }
            break;
        case 6:{
        //登出,回到登录界面
            [self.delegate removeFromSuperView:YES];
        }
            break;
        default:
            break;
    }
}

//获取当前正在显示的viewController
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self UIInit];
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
