//
//  RecommendView.m
//  League of Legends
//
//  Created by 刘永杰 on 15/11/13.
//  Copyright © 2015年 刘永杰. All rights reserved.
//

#import "RecommendView.h"

#define kWidth self.bounds.size.width
#define kHeight self.bounds.size.height

@interface RecommendView ()

@property (strong, nonatomic) UIScrollView *scrollView;

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
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight )];
//    self.scrollView.contentSize = CGSizeMake(kWidth * 5, kHeight);
    
        
    self.headImageView = [[UIImageView alloc] init];
    self.headImageView.backgroundColor = [UIColor redColor];
    self.headImageView.frame = CGRectMake(0, 0, kWidth, kHeight);
    [self.scrollView addSubview:self.headImageView];
    
    self.Headlabel = [[UILabel alloc] init];
    self.Headlabel.backgroundColor = [UIColor blueColor];
    self.Headlabel.frame = CGRectMake(0, 170, kWidth, 20);
    [self.headImageView addSubview:self.Headlabel];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(kWidth - 120, 170, 100, 20)];
    self.pageControl.numberOfPages = 5;
    
    [self.scrollView addSubview:self.pageControl];
    
    [self addSubview:self.scrollView];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
