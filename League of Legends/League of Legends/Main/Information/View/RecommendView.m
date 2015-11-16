//
//  RecommendView.m
//  League of Legends
//
//  Created by 刘永杰 on 15/11/13.
//  Copyright © 2015年 刘永杰. All rights reserved.
//

#import "RecommendView.h"
#import "InfoModel.h"

static int num;

#define kWidth self.bounds.size.width
#define kHeight self.bounds.size.height

@interface RecommendView ()<UIScrollViewDelegate>

@end

@implementation RecommendView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setupViews];
    }
    return self;
}

- (void)p_setupViews
{
    
    int count = 10;
    int count1 = 0;
    
    self.headScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight )];
    self.headScrollView.contentSize = CGSizeMake(kWidth * 6, kHeight);
    self.headScrollView.backgroundColor = [UIColor yellowColor];
    self.headScrollView.pagingEnabled = YES;
    self.headScrollView.contentOffset = CGPointMake(kWidth, 0);
    self.headScrollView.delegate = self;
    
    for (int i = 0; i < 6; i++) {
        self.headImageView = [[UIImageView alloc] init];
        self.headImageView.backgroundColor = [UIColor redColor];
        self.headImageView.frame = CGRectMake(i * kWidth, 0, kWidth, kHeight);
        self.headImageView.tag = count++;
        [self.headScrollView addSubview:self.headImageView];
        
        
        self.Headlabel = [[UILabel alloc] init];
        self.Headlabel.backgroundColor = [UIColor grayColor];
        self.Headlabel.frame = CGRectMake(i * kWidth, 170, kWidth, 30);
        self.Headlabel.alpha = 0.7;
        self.Headlabel.tag = count1++;
        [self.headScrollView addSubview:self.Headlabel];
    }
    
    [self addSubview:self.headScrollView];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(kWidth - 50, 185, 0, 0)];
    self.pageControl.numberOfPages = 4;
    
    self.pageControl.currentPageIndicatorTintColor = [UIColor yellowColor];
    
    [self addSubview:self.pageControl];
    
    [self addtimer];
    
}


//定时器
- (void)addtimer{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    
}

//下一张图片方法实现
- (void)nextImage
{
    num = self.headScrollView.contentOffset.x / kWidth;
    self.pageControl.currentPage = num;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.headScrollView.contentOffset = CGPointMake(kWidth * (num + 1), 0);
    }];
    if (num == 4) {
        
        self.pageControl.currentPage = num = 0;  //记住这里的Bug
        
        self.headScrollView.contentOffset = CGPointMake(kWidth * (num + 1), 0);
        
    } else {
        
        num ++;
    }
    
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addtimer];
}

//将要拖拽的时候停止定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
    self.timer = nil;
}

//拖拽完毕后开始定时器
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    [self addtimer];
}

//手动轮播图实现
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.timer invalidate];
    self.timer = nil;
    
    int num = scrollView.contentOffset.x / kWidth;
    //    self.rv.pageControl.currentPage = num - 1;
    
    
    if (num == 0 || num == 5) {
        
        if (num == 0) {
            scrollView.contentOffset = CGPointMake(kWidth * 4, 0);
            self.pageControl.currentPage = 4;
        } else {
            scrollView.contentOffset = CGPointMake(kWidth, 0);
            self.pageControl.currentPage = 0;
        }
        
    } else {
        
        self.pageControl.currentPage = num - 1;
    }
    
    
}

- (void)pageControlAction:(UIPageControl *)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        
        self.headScrollView.contentOffset = CGPointMake(kWidth * sender.currentPage + kWidth, 0);
    }];
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
