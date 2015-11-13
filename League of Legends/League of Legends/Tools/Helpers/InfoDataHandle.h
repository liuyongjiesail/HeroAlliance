//
//  InfoDataHandle.h
//  League of Legends
//
//  Created by 刘永杰 on 15/11/12.
//  Copyright © 2015年 刘永杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "InfoModel.h"


@interface InfoDataHandle : NSObject

+ (instancetype)sharedInfoDataHandle;
- (NSInteger)modelCount;
- (InfoModel *)modelWithIndex:(NSInteger)index;

@end
