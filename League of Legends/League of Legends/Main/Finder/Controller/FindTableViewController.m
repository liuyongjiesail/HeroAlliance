//
//  FindTableViewController.m
//  League of Legends
//
//  Created by 刘永杰 on 15/11/12.
//  Copyright © 2015年 刘永杰. All rights reserved.
//

#import "FindTableViewController.h"
#import "FindListDataHandle.h"
#import <UIImageView+WebCache.h>
#import "FindDetailViewController.h"
#import "FindHeadView.h"

@interface FindTableViewController ()

@property (strong, nonatomic) UIView *myHeadView;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation FindTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"发现";
    UIColor * color = [UIColor yellowColor];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishData) name:@"finishData" object:nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//     self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)finishData
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return [FindListDataHandle sharedFindListModel].listDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    
    //从这里取得headArray中的数据必须从这里取得
    self.dataArray = [FindListDataHandle sharedFindListModel].headDataArray;
//    NSLog(@"%@",self.dataArray);

    return [[FindListDataHandle sharedFindListModel].listDataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    FindListModel *model = [FindListDataHandle sharedFindListModel].listDataArray[indexPath.section][indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.image_url_big]];

    cell.textLabel.text = model.title;
    
    
    //******************在这里更新tableView的headView***********************
    
    self.myHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    
    int count = 100;
    for (int i = 0; i < self.dataArray.count; i++) {
        
        FindHeadView *headView = [[FindHeadView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 3 * i, 0, self.view.bounds.size.width, 100)];
        
        FindListModel *model = self.dataArray[i];
        
        [headView.myButton addTarget:self action:@selector(ButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        headView.myButton.tag = count++;
        headView.myButton.showsTouchWhenHighlighted = YES;
        
        [headView.myImageView sd_setImageWithURL:[NSURL URLWithString:model.image_url_big]];
        headView.myTitleLabel.text = model.title;
        
        [self.myHeadView addSubview: headView];
        
        //        [self.tableView reloadData];
    }
    self.myHeadView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.myHeadView;
    
    //********************************************************************
    // Configure the cell...
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FindDetailViewController *findDVC = [[FindDetailViewController alloc] init];
    
    FindListModel *model = [FindListDataHandle sharedFindListModel].listDataArray[indexPath.section][indexPath.row];
    
    findDVC.listModel = model;
    
    [self showViewController:findDVC sender:nil];
    
}

//headView  button点击跳转
- (void)ButtonAction:(UIButton *)sender
{
//    sender.backgroundColor = [UIColor grayColor];
    FindDetailViewController *findDVC = [[FindDetailViewController alloc] init];
    
    FindListModel *model = self.dataArray[sender.tag - 100];
    
    findDVC.listModel = model;

    [self showViewController:findDVC sender:nil];

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
