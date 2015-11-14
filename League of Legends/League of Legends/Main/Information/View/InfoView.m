//
//  InfoView.m
//  League of Legends
//
//  Created by 刘永杰 on 15/11/11.
//  Copyright © 2015年 刘永杰. All rights reserved.
//

#import "InfoView.h"
#import "RecommendView.h"

#define kWidth self.allScrollView.bounds.size.width
#define kHeight self.allScrollView.bounds.size.height

@implementation InfoView

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
    
    self.allScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
//    self.allScrollView.backgroundColor = [UIColor redColor];
    [self addSubview:self.allScrollView];
    self.allScrollView.bounces = NO;
    
    
//    self.allScrollView.showsHorizontalScrollIndicator = NO;
//    self.allScrollView.directionalLockEnabled = YES;
    
    self.allScrollView.contentSize = CGSizeMake(kWidth * 8, kHeight);
    self.allScrollView.pagingEnabled = YES;
//    self.allScrollView.tag = 10000;
    
//    self.infoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0 , kWidth, kHeight) style:UITableViewStylePlain];
//    [self.allScrollView addSubview:self.infoTableView];
    
    NSLog(@"%f", kHeight);
    
    int count = 1000;
    
    for (int i = 0; i < 8; i++) {
        
        self.infoTableView = [[UITableView alloc] initWithFrame:CGRectMake(kWidth * i, 0, kWidth, kHeight) style:UITableViewStylePlain];
        self.infoTableView.tag = count++;
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(kWidth * i, 0, kWidth, kHeight)];
//        [view addSubview:self.infoTableView];
        
        [self.allScrollView addSubview:self.infoTableView];
        _infoTableView.tableFooterView = [[UIView alloc]init];
    }
    
//    UITableView *tableView = (UITableView *)[self.allScrollView viewWithTag:1000];
//    RecommendView *view = [[RecommendView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 250)];
//    tableView.tableHeaderView = view;
    
    /*
    self.newsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStylePlain];
    [self.allScrollView addSubview:self.newsTableView];
    
    self.eventTableView = [[UITableView alloc] initWithFrame:CGRectMake(kWidth, 0, kWidth, kHeight) style:UITableViewStylePlain];
    [self.allScrollView addSubview:self.eventTableView];
    
    self.videoTableView = [[UITableView alloc] initWithFrame:CGRectMake(kWidth * 2, 0, kWidth, kHeight) style:UITableViewStylePlain];
    [self.allScrollView addSubview:self.videoTableView];
    
    self.amusementTableView = [[UITableView alloc] initWithFrame:CGRectMake(kWidth * 3, 0, kWidth, kHeight) style:UITableViewStylePlain];
    [self.allScrollView addSubview:self.amusementTableView];
    
    self.officialTableView = [[UITableView alloc] initWithFrame:CGRectMake(kWidth * 4, 0, kWidth, kHeight) style:UITableViewStylePlain];
    [self.allScrollView addSubview:self.officialTableView];
    
    self.beautyTableView = [[UITableView alloc] initWithFrame:CGRectMake(kWidth * 5, 0, kWidth, kHeight) style:UITableViewStylePlain];
    [self.allScrollView addSubview:self.beautyTableView];
    
    self.GBATableView = [[UITableView alloc] initWithFrame:CGRectMake(kWidth * 6, 0, kWidth, kHeight) style:UITableViewStylePlain];
    [self.allScrollView addSubview:self.GBATableView];
    
    self.activityTableView = [[UITableView alloc] initWithFrame:CGRectMake(kWidth * 7, 0, kWidth, kHeight) style:UITableViewStylePlain];
    [self.allScrollView addSubview:self.activityTableView];
    
 */
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
