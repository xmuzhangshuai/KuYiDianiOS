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
#import "KDPersonalCenterViewController.h"
#import "KDScoreViewController.h"
#import "ShareViewController.h"

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
    NSArray     *imageArray;
    
    AppDelegate *myAppDelegate;
    NSUserDefaults *userDefaults;
    
    UILabel     *phoneNumberLabel;  // 电话label
    
    //退出登录按钮
    UIButton *logOutBtn;
    
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
    
    logOutBtn               = [[UIButton alloc] init];
    
     listArray               = @[@"主页", @"我的收藏", @"我的积分", @"闹钟", @"帮助", @"分享", @"设置"];
    imageArray              = @[@"main", @"love", @"N", @"warn", @"help", @"share", @"setting"];
    
    
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
    [self.view addSubview:logOutBtn];
    
    avatarImage.frame = CGRectMake(0, 0, AVATARIMAGE_WIDTH, AVATARIMAGE_HEIGHT);
    avatarImage.center = CGPointMake(0.13*SCREEN_WIDTH, 0.11*SCREEN_HEIGHT);
    avatarImage.image = [UIImage imageNamed:@"head"];
    // 将方形图片剪裁成圆的
    avatarImage.layer.masksToBounds = YES;
    avatarImage.layer.cornerRadius = AVATARIMAGE_WIDTH/2;

    nameLabel.frame = CGRectMake(0.23*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT, NAMELABEL_WIDTH, NAMELABEL_HEIGHT);
    NSLog(@"identity:%d", myAppDelegate.isIdentify);
    if (myAppDelegate.isIdentify) {
        nameLabel.text = [userDefaults objectForKey:@"name"];
    }else {
        nameLabel.text = @"刘云";
    }
    [nameLabel setTextColor:[UIColor colorWithRed:201.0/255 green:202.0/255 blue:203.0/255 alpha:1]];

    nameLabel.textAlignment = NSTextAlignmentLeft;
    
    identificationLabel.frame = CGRectMake(0.23*SCREEN_WIDTH, 0.1*SCREEN_HEIGHT, IDENTIFICATIONLABEL_WIDTH, IDENTIFICATIONLABEL_HEIGHT);
    if (myAppDelegate.isIdentify) {
        identificationLabel.text = [NSString stringWithFormat:@"%@", [userDefaults objectForKey:@"college"]];
    }else {
        identificationLabel.text = @"厦门大学";
    }
    identificationLabel.textAlignment = NSTextAlignmentLeft;
    [identificationLabel setTextColor:[UIColor colorWithRed:201.0/255 green:202.0/255 blue:203.0/255 alpha:1]];
    
    infoTableView.frame = CGRectMake(0, 0.25*SCREEN_HEIGHT, INFOTABLEVIEW_WIDTH, INFOTABLEVIEW_HEIGHT);
    infoTableView.dataSource = self;
    infoTableView.delegate = self;
    infoTableView.scrollEnabled = NO;
    
    
    logOutBtn.frame = CGRectMake(0, 0.95*SCREEN_HEIGHT, SCREEN_WIDTH*0.8666, 0.05*SCREEN_HEIGHT);
    [logOutBtn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [logOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
//    //边框宽度
//    logOutBtn.layer.borderColor = [UIColor whiteColor].CGColor;
//    [logOutBtn.layer setBorderWidth:1.0];
    logOutBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    logOutBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [logOutBtn setTitleColor:[UIColor colorWithRed:201.0/255 green:202.0/255 blue:203.0/255 alpha:1] forState:UIControlStateNormal];
    logOutBtn.backgroundColor = [UIColor colorWithRed:64.0/255 green:64.0/255 blue:63.0/255 alpha:1];
    
}

#pragma mark - button event
-(void)logout {
    //登出,回到登录界面
    [self.delegate removeFromSuperView:YES];
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
    cell.contentView.backgroundColor = [UIColor colorWithRed:64.0/255 green:64.0/255 blue:63.0/255 alpha:1];
    [cell.textLabel setTextColor:[UIColor colorWithRed:201.0/255 green:202.0/255 blue:203.0/255 alpha:1]];
    cell.imageView.image = [UIImage imageNamed:imageArray[indexPath.row]];
    
    cell.textLabel.text = [listArray objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.detailTextLabel setTextColor:[UIColor colorWithRed:201.0/255 green:202.0/255 blue:203.0/255 alpha:1]];
    
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
            //我的积分
            KDScoreViewController *score = [[KDScoreViewController alloc] init];
            [self.delegate getNextViewController:score];
        }
            break;
        case 3:{
            //闹钟
           
        }
            break;
        case 4:{
            //帮助
            
        }
            break;
        case 5:{
            //分享
            ShareViewController *share = [[ShareViewController alloc] init];
            [self.delegate getNextViewController:share];
        }
            break;
        case 6:{
            //设置
            
        }
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:64.0/255 green:64.0/255 blue:63.0/255 alpha:1];
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
