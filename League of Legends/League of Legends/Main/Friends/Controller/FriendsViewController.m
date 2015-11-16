//
//  FriendsViewController.m
//  League of Legends
//
//  Created by 刘永杰 on 15/11/11.
//  Copyright © 2015年 刘永杰. All rights reserved.
//

#import "FriendsViewController.h"
#import "RecommendView.h"
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import "MyView.h"

static int page = 0;

@interface FriendsViewController ()<BMKMapViewDelegate, BMKPoiSearchDelegate, BMKLocationServiceDelegate>

@property (strong, nonatomic) BMKMapView *mapView;
@property (strong, nonatomic) BMKPoiSearch *PoiSearch;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) MyView *myView;
@property (strong, nonatomic) BMKLocationService *Location;
@property (strong, nonatomic) CLLocation *toLocation;


@end

@implementation FriendsViewController

- (BMKPoiSearch *)PoiSearch
{
    if (_PoiSearch == nil) {
        
        self.PoiSearch = [[BMKPoiSearch alloc] init];
        self.PoiSearch.delegate = self;
    }
    return _PoiSearch;
}

- (void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
- (void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView = [[BMKMapView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.mapView;
    
    self.Location = [[BMKLocationService alloc] init];
    self.Location.delegate = self;
    [self.Location startUserLocationService];
    self.mapView.showsUserLocation = YES;

    self.mapView.userTrackingMode = BMKUserTrackingModeFollowWithHeading;//设置定位的状态
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(self.view.frame.size.width - 110, self.view.frame.size.height - 94, 100, 30);
    button.tintColor = [UIColor blackColor];
    [button setTitle:@"重新搜索" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    [self addRightItem];
    //加入自定义的View
    [self addMyView];
    //再次搜索网吧信息
    [self buttonClick];
    
    
    // Do any additional setup after loading the view.
}

-(void)startUserLocationService
{


}

//用户定位方向发生改变时调用
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"到用户定位");
}
//用户位置发生改变时调用
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"已经更新用户位置");
    
    [self.mapView updateLocationData:userLocation];
    NSLog(@"%@", userLocation.title);
    NSLog(@"%@", userLocation.location);
    self.myView.valueLabel.text = [NSString stringWithFormat:@"%.2fKM", [userLocation.location distanceFromLocation:self.toLocation]/1000 ];
    
}

- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}

- (void)addRightItem
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"立即导航" style:UIBarButtonItemStyleDone target:self action:@selector(goAction:)];
    
}

- (void)goAction:(UIBarButtonItem *)sender
{
    

}

- (void)addMyView
{
    self.myView = [[MyView alloc] initWithFrame:CGRectMake(0, 50, 300, 30)];
    self.navigationItem.titleView = self.myView;
}

- (void)buttonClick
{
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = page;
    citySearchOption.pageCapacity = 1;
    citySearchOption.city= @"海淀区";
    citySearchOption.keyword = @"网吧";
    BOOL flag = [self.PoiSearch poiSearchInCity:citySearchOption];
    if(flag)
    {
        NSLog(@"城市内检索发送成功");
    }
    else
    {
        NSLog(@"城市内检索发送失败");
    }
    page ++;
}

#pragma mark implement BMKSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    // 清楚屏幕中所有的annotation
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    
    if (error == BMK_SEARCH_NO_ERROR) {
        NSMutableArray *annotations = [NSMutableArray array];
        
        
        for (int i = 0; i < result.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = poi.pt;
            self.toLocation = [[CLLocation alloc] initWithLatitude:poi.pt.latitude longitude:poi.pt.longitude];
            item.title = poi.name;
            self.myView.nameLabel.text = item.title;
            [annotations addObject:item];
        }
        [_mapView addAnnotations:annotations];
        [_mapView showAnnotations:annotations animated:YES];
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }
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
