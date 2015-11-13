//
//  FindListModel.h
//  League of Legends
//
//  Created by 刘永杰 on 15/11/12.
//  Copyright © 2015年 刘永杰. All rights reserved.
//

/*
 
 "article_id": "12467",
 "article_url": "http://qt.qq.com/club_v2",
 "image_url_big": "",
 "is_act": "0",
 "is_direct": "True",
 "is_hot": "0",
 "is_new": "0",
 "is_share": "0",
 "is_top": "0",
 "is_web": "0",
 "parentid": "",
 "pos_index": "100",
 "section_index": "100",
 "sub_index": "",
 "summary": "",
 "title": "俱乐部"
 
 */

#import <Foundation/Foundation.h>



@interface FindListModel : NSObject

@property (strong, nonatomic) NSString *article_id;
@property (strong, nonatomic) NSString *article_url;
@property (strong, nonatomic) NSString *image_url_big;
@property (strong, nonatomic) NSString *is_act;
@property (strong, nonatomic) NSString *is_direct;
@property (strong, nonatomic) NSString *is_hot;
@property (strong, nonatomic) NSString *is_new;
@property (strong, nonatomic) NSString *is_share;
@property (strong, nonatomic) NSString *is_top;
@property (strong, nonatomic) NSString *is_web;
@property (strong, nonatomic) NSString *parentid;
@property (strong, nonatomic) NSString *pos_index;
@property (strong, nonatomic) NSString *section_index;
@property (strong, nonatomic) NSString *sub_index;
@property (strong, nonatomic) NSString *summary;
@property (strong, nonatomic) NSString *title;

@end
