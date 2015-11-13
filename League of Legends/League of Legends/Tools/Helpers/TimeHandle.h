//
//  TimeHandle.h
//  League of Legends
//
//  Created by 刘永杰 on 15/11/13.
//  Copyright © 2015年 刘永杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeHandle : NSObject

+ (instancetype)sharedTimeHandle;

- (NSString *)IntervalWithString:(NSString *)aString;

@end
