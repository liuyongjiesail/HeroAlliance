//
//  InfoDataHandle.m
//  League of Legends
//
//  Created by 刘永杰 on 15/11/12.
//  Copyright © 2015年 刘永杰. All rights reserved.
//

#import "InfoDataHandle.h"
#import "AFNetworking.h"


@interface InfoDataHandle ()

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSString *oneStr;
@property (strong, nonatomic) NSString *twoStr;
@property (strong, nonatomic) NSString *urlString;


@end

@implementation InfoDataHandle


+ (instancetype)sharedInfoDataHandle
{
    static dispatch_once_t onceToken;
    static InfoDataHandle *info = nil;
    dispatch_once(&onceToken, ^{
        
        info = [[InfoDataHandle alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:info selector:@selector(clickButton:) name:@"sender" object:nil];
        info.twoStr = @"1";
        info.oneStr = @"12";
        [info loadData];

    });
    return info;
}


//得到button的tag值传给数据源
- (void)clickButton:(NSNotification *)text
{
    NSLog(@"接收到Button点击通知");
    
    //通过button的tag值来确定页面
    NSLog(@"%@", text);
    
    switch ([text.userInfo[@"number"] intValue]) {
            
        case 100: self.oneStr = @"12"; break;
        case 101: self.oneStr = @"73"; break;
        case 102: self.oneStr = @"12"; break;
        case 103: self.oneStr = @"18"; break;
        case 104: self.oneStr = @"3"; break;
        case 105: self.oneStr = @"17"; break;
        case 106: self.oneStr = @"10"; break;
        case 107: self.oneStr = @"23"; break;
        default:
            break;
    }
    [self loadData];
    
    
}

- (void)loadData
{
    
    self.dataArray = [NSMutableArray array];

    self.urlString = [NSString stringWithFormat:@"http://qt.qq.com/static/pages/news/phone/c%@_list_%@.shtml", self.oneStr, self.twoStr];
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    [session GET:self.urlString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSLog(@"数据请求成功");
        
        if (responseObject != nil) {
            
            for (NSDictionary *dic in responseObject[@"list"]) {
                
                InfoModel *info = [[InfoModel alloc] init];
                
                [info setValuesForKeysWithDictionary:dic];
                
                [self.dataArray addObject:info];
                
            }
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"finishData" object:nil];
        });
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
        NSLog(@"数据请求失败");
        //        NSLog(@"%@", error);
        
    }];
    
}

- (NSInteger)modelCount
{
    return self.dataArray.count;
}
- (InfoModel *)modelWithIndex:(NSInteger)index
{
    if (self.dataArray != nil) {
        return self.dataArray[index];
    }
    return NULL;
}

@end
