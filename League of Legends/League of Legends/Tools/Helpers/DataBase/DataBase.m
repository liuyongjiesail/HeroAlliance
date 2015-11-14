//
//  DataBase.m
//  League of Legends
//
//  Created by 刘永杰 on 15/11/14.
//  Copyright © 2015年 刘永杰. All rights reserved.
//

#import "DataBase.h"

@interface DataBase ()

@property (strong, nonatomic) NSString *filePath;

@end

@implementation DataBase

+ (instancetype)sharedDataBaseHandle
{
    static dispatch_once_t onceToken;
    static DataBase *db = nil;
    dispatch_once(&onceToken, ^{
        
        db = [[DataBase alloc] init];
    });
    return db;
}

- (NSString *)filePath
{
    if (_filePath == nil) {
        
        NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        self.filePath = [document stringByAppendingPathComponent:@"goods.sqlite"];
        
    }
    return _filePath;
}

- (FMDatabase *)myDB
{
    if (_myDB == nil) {
        
        self.myDB = [FMDatabase databaseWithPath:self.filePath];
    }
    return _myDB;
}




@end
