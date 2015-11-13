//
//  FindListDataHandle.h
//  League of Legends
//
//  Created by 刘永杰 on 15/11/12.
//  Copyright © 2015年 刘永杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FindListModel.h"

@interface FindListDataHandle : NSObject

@property (strong, nonatomic) NSMutableArray *headDataArray;
@property (strong, nonatomic) NSMutableArray *listDataArray;

+ (instancetype)sharedFindListModel;


@end
