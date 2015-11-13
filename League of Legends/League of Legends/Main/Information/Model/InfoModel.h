//
//  InfoModel.h
//  League of Legends
//
//  Created by 刘永杰 on 15/11/12.
//  Copyright © 2015年 刘永杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoModel : NSObject

@property (strong, nonatomic) NSString *article_id;
@property (strong, nonatomic) NSString *article_url;
@property (strong, nonatomic) NSString *channel_desc;
@property (strong, nonatomic) NSString *channel_id;
@property (strong, nonatomic) NSString *image_spec;
@property (strong, nonatomic) NSString *image_url_big;
@property (strong, nonatomic) NSString *image_url_small;
@property (strong, nonatomic) NSString *image_with_btn;
@property (strong, nonatomic) NSString *insert_date;
@property (strong, nonatomic) NSString *is_act;
@property (strong, nonatomic) NSString *is_direct;
@property (strong, nonatomic) NSString *is_hot;
@property (strong, nonatomic) NSString *is_new;
@property (strong, nonatomic) NSString *is_top;
@property (strong, nonatomic) NSString *publication_date;
@property (strong, nonatomic) NSString *score;
@property (strong, nonatomic) NSString *summary;
@property (strong, nonatomic) NSString *targetid;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *video_info;

@end
