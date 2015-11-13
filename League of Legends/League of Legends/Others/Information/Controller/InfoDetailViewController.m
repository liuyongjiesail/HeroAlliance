//
//  InfoDetailViewController.m
//  League of Legends
//
//  Created by 刘永杰 on 15/11/12.
//  Copyright © 2015年 刘永杰. All rights reserved.
//

#import "InfoDetailViewController.h"
#import "InfoDetailView.h"

@interface InfoDetailViewController ()

@property (strong, nonatomic) InfoDetailView *infoView;
@property (strong, nonatomic) NSString *urlString;

@end

@implementation InfoDetailViewController

- (void)loadView
{
    self.infoView = [[InfoDetailView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.infoView;
}

- (void)viewWillAppear:(BOOL)animated
{
    InfoModel *model = self.infoModel;
    
//    model.title.
    
    if ([model.article_url hasSuffix:@".shtml"]) {
        self.urlString = [NSString stringWithFormat:@"http://qt.qq.com/static/pages/news/phone/%@?APP_BROWSER_VERSION_CODE=1&ios_version=691&imgmode=auto", model.article_url];
    } else {
        
        self.urlString = model.article_url;
    }
    
    
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.infoView.webView loadRequest:request];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"资讯详情";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //选择自己喜欢的颜色
    //设置navigationbar的title字体颜色
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-prev"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemAction:)];
    // Do any additional setup after loading the view.
}

- (void)leftBarButtonItemAction:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
