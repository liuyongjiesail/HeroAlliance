//
//  TimeHandle.m
//  League of Legends
//
//  Created by 刘永杰 on 15/11/13.
//  Copyright © 2015年 刘永杰. All rights reserved.
//

#import "TimeHandle.h"

@implementation TimeHandle

+ (instancetype)sharedTimeHandle
{
    static dispatch_once_t onceToken;
    static TimeHandle *time = nil;
    dispatch_once(&onceToken, ^{
        
        time = [[TimeHandle alloc] init];
    });
    return time;
}

- (NSString *)IntervalWithString:(NSString *)aString
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDate *date = [formatter dateFromString:aString];
    
    NSDate *nowDate = [NSDate date];
    
    NSTimeInterval t = [nowDate timeIntervalSinceDate:date];

    if (t/60 < 60) {
        
        return [NSString stringWithFormat:@"%.0f分钟前", t/60];
    } else if (t/3600 < 24) {
        
        return [NSString stringWithFormat:@"%.0f小时前", t/3600];
    } else if ( t/(24 * 3600) >= 1 && t/(24 * 3600) <= 2 ){
        
        return [NSString stringWithFormat:@"%.0f天前", t/(24*3600)];
        
    } else if (t/(24*3600) > 2) {
        
        return [aString substringWithRange:NSMakeRange(5, 6)];
    }
    
    //当传来字符串格式为以下类型的时候，打开注释并将上面代码注释掉
    // aString = @"20151013134106";
    /*
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"YYYYMMddHHmmss"];
    
    NSDate *date = [formatter dateFromString:aString];
    
    NSDate *nowDate = [NSDate date];
    
    NSTimeInterval t = [nowDate timeIntervalSinceDate:date];
    
    if (t/60 < 60) {
        return [NSString stringWithFormat:@"%.0f分钟前", t/60];
    } else if (t/3600 < 24) {
        
        return [NSString stringWithFormat:@"%.0f小时前", t/3600];
    } else if ( t/(24 * 3600) >= 1 && t/(24 * 3600) <= 2 ){
        
        return [NSString stringWithFormat:@"%.f天前", t/(24*3600)];
        
    } else if (t/(24*3600) > 2) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        //设定日期转换格式（提取数据的方式）
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        //转换
        NSString *timeStr = [formatter stringFromDate:date];
        
        return [timeStr substringWithRange:NSMakeRange(5, 6)];
        
    }
    
     */
    
    return NULL;
    
}


@end
