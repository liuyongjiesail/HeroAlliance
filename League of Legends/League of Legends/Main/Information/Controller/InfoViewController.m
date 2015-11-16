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
#import <MJRefresh.h>
#import <MJRefreshHeader.h>
#import "AFNetworking.h"


#define kWidth (self.iv.bounds.size.width - 50) / 5

@interface InfoViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>


@property (strong, nonatomic) InfoView *iv;

@property (strong, nonatomic) RecommendView *recommendView;

@property (strong, nonatomic) UIScrollView *headTitleSV;

@property (strong, nonatomic) UIView *myHeadView;

@property (strong, nonatomic) UIButton *button;

@property (strong, nonatomic) UIButton *saveButton;

@property (strong, nonatomic) UIImageView *placeholderImageView;

//用于存储目前取到的tableView
@property (strong, nonatomic) UITableView *tableView;

//推荐资讯数据源
@property (strong, nonatomic) NSMutableArray *dataArray;

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
   
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-next-2"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemAction:)];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.iv.infoTableView.frame = CGRectMake(self.iv.allScrollView.contentOffset.x / self.iv.allScrollView.bounds.size.width, 64,  self.iv.allScrollView.bounds.size.width, self.iv.allScrollView.bounds.size.height - 113);
    [self.iv.infoTableView registerClass:[InfoTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.iv.infoTableView.delegate = self;
    self.iv.infoTableView.dataSource = self;
    
    [self getJsonData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishAction) name:@"finishData" object:nil];
    
    self.iv.allScrollView.delegate = self;
    
    //轮播图实现
    self.recommendView = [[RecommendView alloc] initWithFrame:CGRectMake(0, 0, self.iv.allScrollView.bounds.size.width, 200)];

    self.iv.infoTableView.tableHeaderView = self.recommendView;
    
    for (int i = 0; i < self.dataArray.count; i++) {
        
        InfoModel *model = self.dataArray[i];
        
        UIImageView *imageView =(UIImageView *) [self.recommendView viewWithTag:i+10];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.image_url_big]];
        
        UILabel *label = (UILabel *)[self.recommendView viewWithTag:i];
        label.text = model.title;
        
    }
    
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
    self.iv.infoTableView.frame = CGRectMake(0, 0, self.iv.allScrollView.bounds.size.width, self.iv.allScrollView.bounds.size.height);
    
    self.saveButton.selected = YES;

}

//button点击方法实现
- (void)buttonAction:(UIButton *)sender
{
    self.saveButton.tintColor = [UIColor yellowColor];
    NSDictionary *dict = [NSDictionary dictionaryWithObject: @(sender.tag) forKey:@"number"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sender" object:nil userInfo:dict];
    
    if (self.saveButton != sender) {
    
        
        sender.selected = !sender.selected;
        self.saveButton.selected = ! self.saveButton.selected;
        self.saveButton = sender;
        [self.saveButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        sender.selected = YES;
        
        //通过tag值来确定tableView间的转换
        
        self.iv.allScrollView.contentOffset = CGPointMake((sender.tag - 100) * self.iv.allScrollView.bounds.size.width, 0);
        self.iv.infoTableView.frame = CGRectMake((sender.tag - 100) * self.iv.allScrollView.bounds.size.width, 64, self.iv.allScrollView.bounds.size.width, self.iv.allScrollView.bounds.size.height - 113);
    
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    self.iv.allScrollView.delegate != self;
//    NSLog(@"正在滚动");
     self.iv.allScrollView.scrollEnabled = YES;
    self.iv.allScrollView.directionalLockEnabled = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.iv.allScrollView.scrollEnabled = NO;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.iv.allScrollView.scrollEnabled = YES;

}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    CGFloat myFloat = scrollView.contentOffset.x;
    
    CGFloat index = myFloat / self.view.frame.size.width;
    
    NSLog(@"%f", index);
    
    self.button = (UIButton *)[self.headTitleSV viewWithTag:index + 100];
    
    [self buttonAction:self.button];
    
    [self finishAction];

}


#pragma mark -- MJRefreshDelegate

- (void)refreshingAction:(MJRefreshHeader *)sender
{
    NSLog(@"123");
}


#pragma mark -- 推荐资讯数据

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-  (void)getJsonData
{
    NSString *urlString = @"http://qt.qq.com/static/pages/news/phone/c13_list_1.shtml";
    
//    self.dataArray = [NSMutableArray array];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:urlString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"推荐请求数据成功");
        
        if (responseObject != nil) {
            
            for (NSDictionary *dic in responseObject[@"list"]) {
                
                InfoModel *info = [[InfoModel alloc] init];
                
                [info setValuesForKeysWithDictionary:dic];
                
                [self.dataArray addObject:info];
            }
        }
    
        
        self.recommendView = [[RecommendView alloc] initWithFrame:CGRectMake(0, 0, self.iv.allScrollView.bounds.size.width, 200)];
        
        InfoModel *model3 = self.dataArray[self.dataArray.count-1];
        
        UIImageView *imageView3 = (UIImageView *)[self.recommendView viewWithTag:10];
        [imageView3 sd_setImageWithURL:[NSURL URLWithString:model3.image_url_big]];
        
        self.iv.infoTableView.tableHeaderView = self.recommendView;
        
        for (int i = 0; i < self.dataArray.count; i++) {
            
            InfoModel *model = self.dataArray[i];
            
            UIImageView *imageView =(UIImageView *) [self.recommendView viewWithTag:i+10+1];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.image_url_big]];
            
            UILabel *label = (UILabel *)[self.recommendView.Headlabel viewWithTag:i+1];
            label.text = model.title;
//            NSLog(@"%@", model.title);
            
        }
        InfoModel *model2 = self.dataArray[0];

        UIImageView *imageView2 = (UIImageView *)[self.recommendView viewWithTag:15];
        [imageView2 sd_setImageWithURL:[NSURL URLWithString:model2.image_url_big]];
        
//        NSLog(@"tuijian :%@", self.dataArray);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"推荐数据请求失败");
    }];
    
    
    
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
