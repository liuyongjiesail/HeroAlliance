//
//  GoodsDataHandle.h
//  League of Legends
//
//  Created by 刘永杰 on 15/11/14.
//  Copyright © 2015年 刘永杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataBase.h"
#import "GoodsModel.h"
#import "FindListModel.h"

@interface GoodsDataHandle : NSObject

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) NSMutableArray *propsArray;

@property (strong, nonatomic) FindListModel *listModel;

+ (instancetype)sharedGoodsData;

- (NSInteger)modelForCount;

- (GoodsModel *)modelWithIndexPath:(NSInteger)index;

@end
