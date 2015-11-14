//
//  DataBase.h
//  League of Legends
//
//  Created by 刘永杰 on 15/11/14.
//  Copyright © 2015年 刘永杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>

@interface DataBase : NSObject

@property (strong, nonatomic) FMDatabase *myDB;

+ (instancetype)sharedDataBaseHandle;


@end
