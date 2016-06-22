//
//  KDLocalScrollView.m
//  KuDian
//
//  Created by 黄明族 on 16/6/14.
//  Copyright © 2016年 黄明族. All rights reserved.
//

#import "KDLocalScrollView.h"
#import "UISize.h"
#import "UIImageView+WebCache.h"


//获取ScrollView的宽度
#define frame_width self.localScrollView.frame.size.width


@interface KDLocalScrollView()<UIScrollViewDelegate>

@property (nonatomic, strong)ClickScrollViewBlock ClickBlock;

@property (nonatomic, strong)NSArray *localImageArr;

@end


@implementation KDLocalScrollView

+(instancetype)localScrollViewWithFrame:(CGRect)frame ImageArr:(NSArray *)localImageArr andClickScrollViewBlock:(ClickScrollViewBlock)ClickBlock {
    return [[KDLocalScrollView alloc] initWithFrame:frame ImageArr:localImageArr AndImageClickBlock:ClickBlock];
}

-(instancetype)initWithFrame:(CGRect)frame ImageArr:(NSArray *)imageNameArray AndImageClickBlock:(ClickScrollViewBlock)clickBlock {
    if (self = [self initWithFrame:frame]) {
        //设置ScrollView的contentSize
        self.localScrollView.contentSize = CGSizeMake((imageNameArray.count)*frame_width/4,0);
//        self.localScrollView.contentSize = CGSizeMake(frame_width/4*(imageNameArray.count),0);

        //设置滚动图片数组
        self.localImageArr=imageNameArray;
        
        //设置图片点击的Block
        self.ClickBlock=clickBlock;
    }
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //初始化轮播ScrollView
        self.localScrollView = [[UIScrollView alloc]init];
        self.localScrollView.delegate = self;
        //设置按页滑动
//        self.localScrollView.pagingEnabled = YES;
        self.localScrollView.frame = self.bounds;
        self.localScrollView.bounces = NO;
        self.localScrollView.backgroundColor = [UIColor grayColor];
        self.localScrollView.scrollsToTop = NO;
        //contentOffset 表示的是当前显示范围的origin点在视图中的位置
        self.localScrollView.contentOffset=CGPointMake(0, 0);
        self.localScrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.localScrollView];
        NSLog(@"height:...%f", self.localScrollView.frame.size.height);

    }
    return self;
}

/**
 *  我们也要使用到UIScrollViewDelegate，通过代理方法来控制轮播图的变化，和定时器开启与关闭！
 */
#pragma mark-========================UIScrollViewDelegate=====================

#pragma mark 开始拖拽代理
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}

#pragma mark 结束拖拽代理
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}

#pragma mark 结束滚动代理
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

#pragma mark 重写图片名字的数组
-(void)setLocalImageArr:(NSArray *)localImageArr {
    _localImageArr = localImageArr;
     [self addImageToScrollView];
}


#pragma mark 图片点击事件
-(void)imageClick:(UITapGestureRecognizer *)tap
{
    UIView *view=tap.view;
    if(self.ClickBlock)
    {
        self.ClickBlock(view.tag);
    }
}

#pragma mark - 根据图片名将图片添加到ScrollView中
-(void)addImageToScrollView {
    //创建一个可变数组
    NSMutableArray *imgMArr=[NSMutableArray arrayWithArray:self.localImageArr];
    //添加第一个和最后一个对象到对应可变数组的最后一个位置和第一个位置
//    [imgMArr insertObject:[self.localImageArr lastObject] atIndex:0];
//    [imgMArr addObject:[self.localImageArr firstObject]];
    
    NSInteger tag=-1;
    if (imgMArr.count == 0)
    {
        return;
    }
    for (NSString *name in imgMArr) {
        //将传进来的图片名在本地初始化
        UIImageView *imgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:name]];
        
        //设置图片的坐标
        imgView.frame=CGRectMake((self.frame.size.width/4)*(tag+1), 0, self.frame.size.width/4, self.frame.size.height);
        
        //如果本地没有这张图片进行网络请求
        if(imgView.image ==nil)
        {
            
            [imgView sd_setImageWithURL:[NSURL URLWithString:name] placeholderImage:nil];
        }
        //让图片进行裁剪显示 显示不全。
        //        imgView.contentMode = UIViewContentModeScaleAspectFit;
        //添加手势
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick:)];
        
        //开启用户交互
        imgView.userInteractionEnabled=YES;
        
        [self.localScrollView addSubview:imgView];
        
        [imgView addGestureRecognizer:tap];
        
        //设置tag
        imgView.tag = tag;
        tag++;
        
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
