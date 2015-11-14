//
//  GoodsModel.h
//  League of Legends
//
//  Created by 刘永杰 on 15/11/14.
//  Copyright © 2015年 刘永杰. All rights reserved.
//
/*
 {
	"items": [
 {
 "good_id": 1001,
 "maplist": [
 "召唤师峡谷",
 "水晶之痕",
 "扭曲丛林",
 "嚎哭深渊"
 ],
 "name": "速度之靴",
 "othernames": [
 "布鞋",
 "草鞋"
 ],
 "proplist": [
 "鞋"
 ]
 },
 
 */

#import <Foundation/Foundation.h>

@interface GoodsModel : NSObject

@property (strong, nonatomic) NSString *good_id;
@property (strong, nonatomic) NSArray *maplist;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *othernames;
@property (strong, nonatomic) NSArray *proplist;

@end
