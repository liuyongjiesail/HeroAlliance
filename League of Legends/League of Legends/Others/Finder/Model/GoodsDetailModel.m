//
//  GoodsDetailModel.m
//  League of Legends
//
//  Created by 刘永杰 on 15/11/16.
//  Copyright © 2015年 刘永杰. All rights reserved.
//

#import "GoodsDetailModel.h"

@implementation GoodsDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        
        self.ID = value;
    }
}

@end
