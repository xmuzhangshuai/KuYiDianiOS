//
//  KDLeadViewController.m
//  KuDian
//
//  Created by 黄明族 on 16/5/31.
//  Copyright © 2016年 黄明族. All rights reserved.
//

#import "KDLeadViewController.h"
#import "KDLoginViewController.h"
#import "UISize.h"

@interface KDLeadViewController ()<UIScrollViewDelegate>

@end

@implementation KDLeadViewController {
    // 创建页码控制器
    UIPageControl *pageControl;
    // 判断是否是第一次进入应用
    BOOL flag;
    NSArray *imageArray;
}

-(instancetype)init{
    if (self = [super init]) {
        imageArray = @[@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg"];
    }
    return self;
}

-(void)UIInit {
    UIScrollView *myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    for (int i=0; i<imageArray.count; i++) {
        UIImage *image = [UIImage imageNamed:imageArray[i]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        // 在最后一页创建按钮
        if (i == imageArray.count-1) {
            // 必须设置用户交互 否则按键无法操作
            imageView.userInteractionEnabled = YES;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectMake(SCREEN_WIDTH / 3, SCREEN_HEIGHT * 7 / 8, SCREEN_WIDTH / 3, SCREEN_HEIGHT / 16);
            [button setTitle:@"点击进入" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            button.layer.borderWidth = 2;
            button.layer.cornerRadius = 5;
            button.clipsToBounds = YES;
            button.layer.borderColor = [UIColor blueColor].CGColor;
            [button addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
        }
        imageView.image = image;
        [myScrollView addSubview:imageView];
    }
    myScrollView.bounces = NO;
    myScrollView.pagingEnabled = YES;
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * imageArray.count, SCREEN_HEIGHT);
    myScrollView.delegate = self;
    [self.view addSubview:myScrollView];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 3, SCREEN_HEIGHT * 15 / 16, SCREEN_WIDTH / 3, SCREEN_HEIGHT / 16)];
    // 设置页数
    pageControl.numberOfPages = imageArray.count;
    // 设置页码的点的颜色
    pageControl.pageIndicatorTintColor = [UIColor yellowColor];
    // 设置当前页码的点颜色
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
    [self.view addSubview:pageControl];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UIInit];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 计算当前在第几页
    pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width);
}

// 点击按钮保存数据并切换根视图控制器
- (void) go:(UIButton *)sender{
    flag = YES;
    NSUserDefaults *useDef = [NSUserDefaults standardUserDefaults];
    // 保存用户数据
    [useDef setBool:flag forKey:@"notFirst"];
    [useDef synchronize];
    // 切换根视图控制器
    self.view.window.rootViewController = [[KDLoginViewController alloc] init];
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
