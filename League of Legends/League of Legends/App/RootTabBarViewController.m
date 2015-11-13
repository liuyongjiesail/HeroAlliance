//
//  RootTabBarViewController.m
//  League of Legends
//
//  Created by 刘永杰 on 15/11/11.
//  Copyright © 2015年 刘永杰. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "InfoViewController.h"
#import "FriendsViewController.h"
#import "UserViewController.h"
#import "FindTableViewController.h"

@interface RootTabBarViewController ()

@end

@implementation RootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    InfoViewController *infoVC = [[InfoViewController alloc] init];
    UINavigationController *infoNC = [[UINavigationController alloc] initWithRootViewController:infoVC];
    infoNC.tabBarItem  = [[UITabBarItem alloc] initWithTitle:@"资讯" image:[UIImage imageNamed:@"iconfont-iconcaidanshouye-2"] selectedImage:[UIImage imageNamed:@""]];
    
    FriendsViewController *friendVC = [[FriendsViewController alloc] init];
    UINavigationController *friendNC = [[UINavigationController alloc] initWithRootViewController:friendVC];
    friendNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"好友" image:[UIImage imageNamed:@"iconfont-pengyouquan"] selectedImage:[UIImage imageNamed:@""]];
    
    FindTableViewController *findVC = [[FindTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    UINavigationController *findNC = [[UINavigationController alloc] initWithRootViewController:findVC];
    findNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:[UIImage imageNamed:@"iconfont-search-2"] selectedImage:[UIImage imageNamed:@""]];
    
    UserViewController *userVC = [[UserViewController alloc] init];
    UINavigationController *userNC = [[UINavigationController alloc] initWithRootViewController:userVC];
    userNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"iconfont-mynormal"] selectedImage:[UIImage imageNamed:@""]];
    
    self.viewControllers = @[infoNC, friendNC, findNC, userNC];
    
    // Do any additional setup after loading the view.
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
