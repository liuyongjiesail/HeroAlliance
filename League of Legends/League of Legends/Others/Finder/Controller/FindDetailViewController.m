//
//  FindDetailViewController.m
//  League of Legends
//
//  Created by 刘永杰 on 15/11/13.
//  Copyright © 2015年 刘永杰. All rights reserved.
//

#import "FindDetailViewController.h"
#import "FindListModel.h"
#import "FindHeadView.h"
#import "GoodsDataHandle.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperation.h"
#import "GoodsCollectionCell.h"
#import "GoodsDataHandle.h"
#import "GoodsDetailViewController.h"

static int count = 0;

@interface FindDetailViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UISearchControllerDelegate, UISearchResultsUpdating>

@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, nonatomic) UICollectionView *goodListCollection;
@property (strong, nonatomic) UIView *collectionView;
@property (strong, nonatomic) NSMutableArray *searchlistArray;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) UIButton *saveButton;

//主界面layout
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;

@property (strong, nonatomic) UIView *buttonView;

@end

@implementation FindDetailViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

    
    FindListModel *listModel = self.listModel;
    
    self.navigationItem.title = listModel.title;
    
    if ([listModel.article_url hasPrefix:@"http://qt.qq.com"]) {
        
        if ([listModel.title isEqualToString:@"物品资料"]) {
            
            [GoodsDataHandle sharedGoodsData];
            
            self.collectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 84, self.view.frame.size.width, self.view.frame.size.height - 84)];
//            self.collectionView.backgroundColor = [UIColor redColor];
            [self.view addSubview:self.collectionView];
            
            self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
            self.searchController.dimsBackgroundDuringPresentation = NO;
            self.searchController.hidesNavigationBarDuringPresentation = NO;
            self.searchController.searchResultsUpdater = self;
            
            UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 74)];
//            view1.backgroundColor = [UIColor grayColor];
            [view1 addSubview: self.searchController.searchBar];
            [self.view addSubview:view1];
            
            UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
            button1.frame = CGRectMake(0, 44, self.view.frame.size.width / 2, 35);
            [button1 addTarget:self action:@selector(button1Action:) forControlEvents:UIControlEventTouchUpInside];
            [button1 setTitle:@"全部地图" forState:UIControlStateNormal];
            button1.titleLabel.textAlignment = NSTextAlignmentRight;
            button1.backgroundColor = [UIColor whiteColor];
            button1.tintColor = [UIColor blackColor];
            button1.layer.borderWidth = 0.5;
            button1.layer.borderColor = [UIColor grayColor].CGColor;
            button1.selected = NO;
            button1.tag = 100001;
            [view1 addSubview:button1];
            
            UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
            button2.frame = CGRectMake(self.view.frame.size.width / 2, 44, self.view.frame.size.width/2, 35);
            button2.backgroundColor = [UIColor whiteColor];
            [button2 addTarget:self action:@selector(button2Action:) forControlEvents:UIControlEventTouchUpInside];
            [button2 setTitle:@"全部物品" forState:UIControlStateNormal];
            button2.titleLabel.textAlignment = NSTextAlignmentRight;
            button2.tintColor = [UIColor blackColor];
            button2.layer.borderWidth = 0.5;
            button2.tag = 100002;
            button2.layer.borderColor = [UIColor grayColor].CGColor;
            [view1 addSubview:button2];
            
            
            self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
            CGFloat w = (self.view.bounds.size.width - 120) / 4;
            
            self.flowLayout.itemSize = CGSizeMake(w, w + 60);
            NSLog(@"%f",w);
//            flowLayout.minimumLineSpacing = 10;
            //间距不能小于该数值，（大于可以）
//            flowLayout.minimumInteritemSpacing = 0;
            self.flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
            self.goodListCollection = [[UICollectionView alloc] initWithFrame:self.collectionView.bounds collectionViewLayout:self.flowLayout];
            self.goodListCollection.backgroundColor = [UIColor whiteColor];
            
            self.goodListCollection.delegate = self;
            self.goodListCollection.dataSource = self;
            
            [self.goodListCollection registerClass:[GoodsCollectionCell class] forCellWithReuseIdentifier:@"cell"];
            
            [self.collectionView addSubview:self.goodListCollection];
            
            
            
            self.buttonView.backgroundColor = [UIColor redColor];
            self.buttonView.alpha = 0.7;
            
            
        } else if ([listModel.title isEqualToString:@"英雄资料"]){
            
            
            
        } else if ([listModel.title isEqualToString:@"符文模拟"]) {
            
            
            
        } else if ([listModel.title isEqualToString:@"天赋模拟"]) {
            
            
        }
        
        
    } else {
        
        //webView数据部分加载
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        [self.view addSubview:self.webView];
        
        NSURL *url = [NSURL URLWithString:listModel.article_url];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [self.webView loadRequest:request];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-iconwenzhangcaozuoxiazaibukedianji"] style:UIBarButtonItemStyleDone target:self action:@selector(DownLoadAction:)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-prev"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemAction:)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishAction)  name:@"finishData" object:nil];
    self.collectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 158, self.view.frame.size.width, self.view.frame.size.height - 158)];
    
    // Do any additional setup after loading the view.
}

- (void)rightBarButtonItemAction:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//**********************物品图片资料下载*************************//
/*
- (void)DownLoadAction:(UIBarButtonItem *)sender
{
    
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    self.progressView.backgroundColor = [UIColor greenColor];
    self.progressView.frame = CGRectMake(0, self.view.bounds.size.height - 60, self.view.bounds.size.width, 20);
    self.progressView.progress = 0;
    [self.view addSubview:self.progressView];
    
//    [self.view preservesSuperviewLayoutMargins];
    
    
    NSString *urlString = @"http://ossweb-img.qq.com/upload/qqtalk/lol_hero/good_package_info.js";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:urlString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSString *goodUrl = responseObject[@"json_url"];
        NSLog(@"%@", goodUrl);
        
        UIWebView *webView = [[UIWebView alloc] init];
        
        
        NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:goodUrl]];
        
        [webView loadRequest:request];
        
        [self.view addSubview:webView];
        
        /*
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        
        //需要获取数据的网络接口(必须给URL）
        operation.inputStream = [NSInputStream inputStreamWithURL:[NSURL URLWithString:goodUrl]];
        
        //将获取的数据存储在哪里
        operation.outputStream = [NSOutputStream outputStreamToFileAtPath:document append:YES];
        
        //下载进度
        [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            
            NSLog(@"下载进度");
            
        }];
        
        //下载完成
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            
            NSLog(@"下载完成");
            
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            
            NSLog(@"下载失败");
            NSLog(@"%@", error);
        }];
        
        //开始下载
        [operation start];
        */
        
        
//        NSLog(@"请求成功");
//    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
//        
//        NSLog(@"请求失败");
//    }];
//    
//}


// ***********************物品资料界面****************************

- (void)finishAction
{
    [self.goodListCollection reloadData];
    NSLog(@"物品资料已更新");
}

#pragma mark -- 两个button弹出相应View
- (void)button1Action:(UIButton *)sender
{
    count ++;
    if (count % 2 != 0) {
        
        //button点击出现view
        
        self.buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 148, self.view.frame.size.width, 90)];
        self.buttonView.backgroundColor = [UIColor grayColor];
        self.buttonView.layer.borderColor = [UIColor whiteColor].CGColor;
//        self.buttonView.
        int count = 10000;
        for (int i = 0; i < 2; i++) {
            
            for (int j = 0; j < 3; j++) {
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(10 + (10 + (self.view.bounds.size.width - 40) / 3) * j, 10 + (10 + 30) * i, (self.view.bounds.size.width - 40)/ 3, 30);
                button.backgroundColor = [UIColor whiteColor];
                button.layer.cornerRadius = 5;
                button.layer.borderWidth = 0.5;
                button.layer.borderColor = [UIColor blackColor].CGColor;
                button.tag = count ++;
                [self.buttonView addSubview:button];
            }
            
        }
        
        [self.view addSubview:self.buttonView];
        [self.buttonView viewWithTag:10005].alpha = 0;

        
    }else {
    
        [self.buttonView removeFromSuperview];
    }
    
}

- (void)button2Action:(UIButton *)sender{
    
    count ++;
    if (count % 2 != 0) {
        
        self.buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 148, self.view.frame.size.width, 210)];
        self.buttonView.backgroundColor = [UIColor grayColor];
//        self.buttonView.alpha = 0.5;
        NSMutableArray *propsArray = [GoodsDataHandle sharedGoodsData].propsArray;
//        NSLog(@"=====%@", [GoodsDataHandle sharedGoodsData].propsArray);
        int count = 20000;
        for (int i = 0; i < 5; i++) {
            
            for (int j = 0; j < 4; j++) {
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
                button.frame = CGRectMake(10 + (10 + (self.view.bounds.size.width - 50) / 4) * j, 10 + (10 + 30) * i, (self.view.bounds.size.width - 50)/ 4, 30);
                button.backgroundColor = [UIColor whiteColor];
                button.layer.cornerRadius = 5;
                button.layer.borderWidth = 0.5;
                button.layer.borderColor = [UIColor blackColor].CGColor;
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                button.tag = count ++;
                [button addTarget:self action:@selector(propsAction:) forControlEvents:UIControlEventTouchUpInside];
                [self.buttonView addSubview:button];
            }
            
        }
        
        for (int i = 0; i < propsArray.count; i++) {
            
            UIButton *button = (UIButton *) [self.buttonView viewWithTag:(20001 + i)];
            
            [button setTitle:propsArray[i] forState:UIControlStateNormal];
        }
        
            
        self.saveButton = (UIButton *)[self.buttonView viewWithTag:20000];
        
        [self.saveButton setTitle:@"全部物品" forState:UIControlStateNormal];
        
//        self.saveButton.selected = YES;

        [self.view addSubview:self.buttonView];
//        NSLog(@"%@", sender.titleLabel.text);
        
        
    }else {
        
        [self.buttonView removeFromSuperview];
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.searchController.active) {
        
        return self.searchlistArray.count;
        
    } else {
        
        return [[GoodsDataHandle sharedGoodsData] modelForCount];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    GoodsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (!self.searchController.active) {
        
        GoodsModel *model = [[GoodsDataHandle sharedGoodsData] modelWithIndexPath:indexPath.item];
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", model.good_id]ofType:@".png"];
        
        cell.myImageView.backgroundColor = [UIColor redColor];
        cell.myImageView.image = [UIImage imageWithContentsOfFile:imagePath];
        cell.goodsName.text = model.name;
        return cell;
        
    } else {
        
        //在这里不能循环打印，否则会导致数据输出一样，这里必须根据item数值来输出数据
        GoodsModel *model = self.searchlistArray[indexPath.item];
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", model.good_id]ofType:@".png"];
        cell.myImageView.backgroundColor = [UIColor redColor];
        cell.myImageView.image = [UIImage imageWithContentsOfFile:imagePath];
        cell.goodsName.text = model.name;
        return cell;

    }
    
    return  NULL;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsDetailViewController *goodDetailVC = [[GoodsDetailViewController alloc] init];
    
    GoodsModel *model = [[GoodsDataHandle sharedGoodsData] modelWithIndexPath:indexPath.item];
    
    [self showViewController:goodDetailVC sender:nil];
    
    NSLog(@"%ld", indexPath.item);
}

#pragma mark -- goodsListSearchControllerDelegate

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *str = self.searchController.searchBar.text;
    
    //必须在这里初始化，不能使用懒加载。
    self.searchlistArray = [NSMutableArray array];

    for (GoodsModel *model in [GoodsDataHandle sharedGoodsData].dataArray) {

        if ([model.name containsString:str]) {
            
            [self.searchlistArray addObject:model];
        }
    }

    [self.goodListCollection reloadData];
}

#pragma mark --- 装备属性按钮点击并更新collectionView
- (void)propsAction:(UIButton *)sender
{
    NSLog(@"%@", sender.titleLabel.text);
    
    if (self.saveButton != sender) {
        
        self.saveButton.selected = !self.saveButton.selected;
        sender.selected = !sender.selected;
        self.saveButton = sender;
        UIButton *button = (UIButton*)[self.view viewWithTag:100002];
        [button setTitle:sender.titleLabel.text forState:UIControlStateNormal];

//        [self.buttonView removeFromSuperview];
        [self button2Action:sender];
//        count ++;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
