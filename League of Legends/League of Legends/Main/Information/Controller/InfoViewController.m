//
//  InfoViewController.m
//  League of Legends
//
//  Created by 刘永杰 on 15/11/11.
//  Copyright © 2015年 刘永杰. All rights reserved.
//

#import "InfoViewController.h"
#import "InfoView.h"
#import "InfoDataHandle.h"
#import "InfoModel.h"
#import "InfoTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "InfoDetailViewController.h"
#import "RecommendView.h"
#import "TimeHandle.h"

#define kWidth (self.iv.bounds.size.width - 50) / 5

@interface InfoViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>


@property (strong, nonatomic) InfoView *iv;

@property (strong, nonatomic) RecommendView *recommendView;

@property (strong, nonatomic) UIScrollView *headTitleSV;

@property (strong, nonatomic) UIView *myHeadView;

@property (strong, nonatomic) UIButton *button;

@property (strong, nonatomic) UIButton *saveButton;

@property (strong, nonatomic) UIImageView *placeholderImageView;

@end

@implementation InfoViewController

- (void)loadView
{
    self.iv = [[InfoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.iv;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    
//    self.iv = [[InfoView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
//    [self.view addSubview:self.iv];
//    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-next-2"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemAction:)];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.iv.infoTableView registerClass:[InfoTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.iv.infoTableView.delegate = self;
    self.iv.infoTableView.dataSource = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishAction) name:@"finishData" object:nil];
    
    self.iv.allScrollView.delegate = self;
    
    //轮播图实现
//    UITableView *tabView = (UITableView *)[self.iv.allScrollView viewWithTag:1000];
//    self.recommendView = [[RecommendView alloc] initWithFrame:CGRectMake(0, 0, self.iv.allScrollView.bounds.size.width, 200)];
////    self.iv.allScrollView.
////    NSLog(@"%@", self.recommendView);
//    tabView.tableHeaderView = self.recommendView;
//    NSLog(@"%@", tabView);
    
    //资讯导航条
    [self p_setupHeadTitle];
    
    // Do any additional setup after loading the view.
}

- (void)finishAction
{
    [self.iv.infoTableView reloadData];
    NSLog(@"已更新");
}


#pragma mark -- 资讯导航条
//头标题
- (void)p_setupHeadTitle
{
    
    NSArray *dataArray = @[@"最新", @"赛事", @"视频", @"娱乐", @"官方", @"美女", @"攻略", @"活动"];
    self.headTitleSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.iv.bounds.size.width - 40, 44)];
//    self.headTitleSV.backgroundColor = [UIColor redColor];
    self.headTitleSV.showsHorizontalScrollIndicator = NO;
    self.headTitleSV.contentSize = CGSizeMake(kWidth * dataArray.count, 0);
    self.headTitleSV.contentOffset = CGPointMake(0, 0);
    self.navigationItem.titleView =self.headTitleSV;
    
    
    NSInteger count = 100;
    
    for (int i = 0; i < dataArray.count; i++) {
        
        self.button = [UIButton buttonWithType:UIButtonTypeSystem];
        self.button.frame = CGRectMake(kWidth * i, 0, kWidth, 40);
        [self.headTitleSV addSubview:self.button];
        [self.button setTitle:dataArray[i] forState:UIControlStateNormal];
        [self.button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//        self.button.showsTouchWhenHighlighted= YES;
        [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        self.button.tag = count ++;
        [self.button setTintColor:[UIColor whiteColor]];
        self.button.titleLabel.font = [UIFont systemFontOfSize:18];
    }
    
    self.saveButton = (UIButton *)[self.headTitleSV viewWithTag:100];
    self.iv.infoTableView.frame = CGRectMake(0, 64, self.iv.allScrollView.bounds.size.width, self.iv.allScrollView.bounds.size.height);

//    [self.iv.allScrollView addSubview:self.recommendView];
//    [self.saveButton setTitleColor:[UIColor yellowColor] forState:UIControlStateSelected];
    
    
    
//    self.saveButton.titleLabel.font = [UIFont systemFontOfSize:22];
    self.saveButton.selected = YES;

}

//button点击方法实现
- (void)buttonAction:(UIButton *)sender
{
    self.saveButton.tintColor = [UIColor yellowColor];
    
    if (self.saveButton != sender) {
    
        
        sender.selected = !sender.selected;
        self.saveButton.selected = ! self.saveButton.selected;
        self.saveButton = sender;
        [self.saveButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        
        //通过tag值来确定tableView间的转换

            
        self.iv.allScrollView.contentOffset = CGPointMake((sender.tag - 100) * self.iv.allScrollView.bounds.size.width, 0);
        self.iv.infoTableView.frame = CGRectMake((sender.tag - 100) * self.iv.allScrollView.bounds.size.width, 64, self.iv.allScrollView.bounds.size.width, self.iv.allScrollView.bounds.size.height - 113);
        

        NSDictionary *dict = [NSDictionary dictionaryWithObject: @(sender.tag) forKey:@"number"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"sender" object:nil userInfo:dict];
        if(sender.tag == 107) {
            
            self.navigationController.navigationBar.tintColor = [UIColor grayColor];
        } else {
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        }
    }
    
}

//右barButton方法实现
- (void)rightBarButtonItemAction:(UIBarButtonItem *)sender
{
    
    
    
}

#pragma mark -- UITableViewDelegateAndTableViewDataSouce

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[InfoDataHandle sharedInfoDataHandle] modelCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    InfoModel *info = [[InfoDataHandle sharedInfoDataHandle] modelWithIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.titlelabel.text = info.title;
    cell.detalLabel.text = info.summary;
    
    cell.timeLabel.text = [[TimeHandle sharedTimeHandle] IntervalWithString:info.publication_date];
    [cell.myImageView sd_setImageWithURL:[NSURL URLWithString:info.image_url_small] placeholderImage:[UIImage imageNamed:@""]];
    if ([info.image_with_btn isEqualToString:@"True"]) {
        
        self.placeholderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 50, 30, 30)];
        self.placeholderImageView.image = [UIImage imageNamed:@"iconfont-0019play"];
    }
    [cell.myImageView addSubview:self.placeholderImageView];

    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [InfoTableViewCell cellWithHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    InfoDetailViewController *detailVC = [[InfoDetailViewController alloc] init];
    
    InfoModel *info = [[InfoDataHandle sharedInfoDataHandle] modelWithIndex:indexPath.row];
    
    detailVC.infoModel = info;
    
    [self showViewController:detailVC sender:nil];
}

#pragma mark -- UIScrollViewDelegate

/*
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    CGFloat myFloat = scrollView.contentOffset.x;
    
    NSInteger index = myFloat / self.view.frame.size.width;
    
    UIButton *button = (UIButton *)[self.iv viewWithTag:index + 100];
    
    [self buttonAction:button];

}
*/

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
