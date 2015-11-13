//
//  InfoTableViewCell.h
//  League of Legends
//
//  Created by 刘永杰 on 15/11/12.
//  Copyright © 2015年 刘永杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *myImageView;
@property (strong, nonatomic) UILabel *titlelabel;
@property (strong, nonatomic) UILabel *detalLabel;
@property (strong, nonatomic) UILabel *timeLabel;

+ (CGFloat)cellWithHeight;

@end
