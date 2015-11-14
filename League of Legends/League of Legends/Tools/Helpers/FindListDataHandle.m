//
//  FindListDataHandle.m
//  League of Legends
//
//  Created by 刘永杰 on 15/11/12.
//  Copyright © 2015年 刘永杰. All rights reserved.
//

#import "FindListDataHandle.h"
#import "AFNetworking.h"

@interface FindListDataHandle ()

@end

@implementation FindListDataHandle

+ (instancetype)sharedFindListModel
{
    static dispatch_once_t onceToken;
    static FindListDataHandle *fldd = nil;
    dispatch_once(&onceToken, ^{
        
        fldd = [[FindListDataHandle alloc] init];
        
        [fldd loadData];
        
    });
    return fldd;
}

- (void)loadData
{
    
    self.headDataArray = [NSMutableArray array];
//    self.listDataArray = [NSMutableArray array];
    
    NSString *urlString = @"http://qt.qq.com/static/pages/news/discovery/c21_index.js";
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    [session GET:urlString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"请求发现数据成功");
        
        //用于存储不同分组的数据
        NSMutableArray *arr1 = [NSMutableArray array];
        NSMutableArray *arr2 = [NSMutableArray array];
        NSMutableArray *arr3 = [NSMutableArray array];
        NSMutableArray *arr4 = [NSMutableArray array];
        NSMutableArray *arr5 = [NSMutableArray array];
        NSMutableArray *arr6 = [NSMutableArray array];
        NSMutableArray *arr7 = [NSMutableArray array];
        
        for (NSDictionary *dict in responseObject[@"list"]) {
            
            FindListModel *findModel = [[FindListModel alloc] init];
            
            [findModel setValuesForKeysWithDictionary:dict];
            

            //根据不同的section将model对象添加到不同的数组中
            switch ([findModel.section_index integerValue]) {
                case 0:
                    [self.headDataArray addObject:findModel];
                    break;
                case 1:{
                    [arr1 addObject:findModel];
                    break;
                }
                case 2:{
                    [arr2 addObject:findModel];
                    break;
                }
                case 3:{
                    
                    [arr3 addObject:findModel];
                    break;
                }
                case 4:{
                    
                    [arr4 addObject:findModel];
                    break;
                }
                case 5:{
                    
                    [arr5 addObject:findModel];
                    break;
                }
                case 6:{
                    
                    [arr6 addObject:findModel];
                    break;
                }
                case 7:{
                    
                    [arr7 addObject:findModel];
                    break;
                }
                    
                default:
                    break;
            }  
            
        }
        self.listDataArray = [NSMutableArray arrayWithObjects:arr1,arr2, arr3, arr4, arr5, arr6, arr7, nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"finishData" object:nil];
        });
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
        NSLog(@"请求发现数据失败");
        NSLog(@"%@", error);

    }];
    
    
}

@end
