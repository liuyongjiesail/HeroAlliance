//
//  GoodsDataHandle.m
//  League of Legends
//
//  Created by 刘永杰 on 15/11/14.
//  Copyright © 2015年 刘永杰. All rights reserved.
//

/*
 装备图片下载
 http://ossweb-img.qq.com/upload/qqtalk/lol_hero/good_package_info.js
 
 所有装备详情
 http://ossweb-img.qq.com/upload/qqtalk/lol_hero/goods_list.js
 
 */

#import "GoodsDataHandle.h"
#import "AFNetworking.h"

@interface GoodsDataHandle ()


@end

@implementation GoodsDataHandle

+ (instancetype)sharedGoodsData
{
    static dispatch_once_t onceToken;
    static GoodsDataHandle *good = nil;
    dispatch_once(&onceToken, ^{
        
        good = [[GoodsDataHandle alloc] init];
        
        [good LoadData];
    });
    return good;
}

- (void)LoadData
{
    self.dataArray = [NSMutableArray array];
    
    
    
    NSString *urlString = @"http://ossweb-img.qq.com/upload/qqtalk/lol_hero/goods_list.js";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:urlString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        for (NSDictionary *dict in responseObject[@"items"]) {
            
            GoodsModel *goods = [[GoodsModel alloc] init];
            
            [goods setValuesForKeysWithDictionary:dict];
            
            [self.dataArray addObject:goods];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"finishData" object:nil];
        });
        
        
        NSLog(@"请求成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
    
}

- (NSInteger)modelForCount
{
    return self.dataArray.count;
}

- (GoodsModel *)modelWithIndexPath:(NSInteger)index
{
    return self.dataArray[index];
}


@end
