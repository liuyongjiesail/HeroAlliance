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

@interface FindDetailViewController ()

@property (strong, nonatomic) UIWebView *webView;

@end

@implementation FindDetailViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    FindListModel *listModel = self.listModel;
    
    self.navigationItem.title = listModel.title;
    
    if ([listModel.article_url hasPrefix:@"http://qt.qq.com"]) {
        
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
    
   
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-prev"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemAction:)];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
