//
//  GoodsDetailModel.h
//  League of Legends
//
//  Created by 刘永杰 on 15/11/16.
//  Copyright © 2015年 刘永杰. All rights reserved.
//

/*
 {
	"active": true,
	"canproducelist": [
 "3001",
 "3135",
 "3124",
 "3027",
 "3029",
 "3286",
 "3151",
 "3089"
	],
	"coprice": "0",
	"good_desc": "+40法术强度",
	"good_id": 1026,
	"greatguide": "",
	"id": 1213,
	"insert_date": "2015-07-21 18:40:03",
	"last_modify_date": "2015-07-21 18:45:59",
	"maplist": [
 "召唤师峡谷",
 "水晶之痕",
 "扭曲丛林",
 "嚎哭深渊"
	],
	"name": "爆裂魔杖",
	"othernames": [
 "八百五",
 "小魔杖"
	],
	"price": "850",
	"produceneedlist": [
 ""
	],
	"proplist": [
 "法术强度"
	],
	"saleprice": "595",
	"suithero": [
 "7",
 "1",
 "55",
 "45",
 "61",
 "90",
 "82",
 "74",
 "134",
 "8",
 "101",
 "50",
 "30",
 "31",
 "131",
 "127",
 "103",
 "69",
 "245"
	]
 }
 
 */

#import <Foundation/Foundation.h>

@interface GoodsDetailModel : NSObject

@property (strong, nonatomic) NSString *active;
@property (strong, nonatomic) NSArray *canproducelist;
@property (strong, nonatomic) NSString *coprice;
@property (strong, nonatomic) NSString *good_desc;
@property (strong, nonatomic) NSString *good_id;
@property (strong, nonatomic) NSString *greatguide;
@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *insert_date;
@property (strong, nonatomic) NSString *last_modify_date;
@property (strong, nonatomic) NSArray *maplist;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *othernames;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSArray *proplist;
@property (strong, nonatomic) NSString *saleprice;
@property (strong, nonatomic) NSArray *suithero;

@end
