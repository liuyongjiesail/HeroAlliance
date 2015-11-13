//
//  InfoTableViewCell.m
//  League of Legends
//
//  Created by 刘永杰 on 15/11/12.
//  Copyright © 2015年 刘永杰. All rights reserved.
//

#import "InfoTableViewCell.h"

@implementation InfoTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self p_setupViews];
    }
    return self;
}

- (void)p_setupViews
{
    self.myImageView = [[UIImageView alloc] init];
//    self.myImageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.myImageView];
    
    self.titlelabel = [[UILabel alloc] init];
//    self.titlelabel.backgroundColor = [UIColor blueColor];
    self.titlelabel.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:self.titlelabel];
    
    self.detalLabel = [[UILabel alloc] init];
//    self.detalLabel.backgroundColor = [UIColor blueColor];
    self.detalLabel.numberOfLines = 0;
    self.detalLabel.font = [UIFont systemFontOfSize:16];
    self.detalLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.detalLabel];
    
    self.timeLabel = [[UILabel alloc] init];
//    self.timeLabel.backgroundColor = [UIColor redColor];
    self.timeLabel.textColor = [UIColor grayColor];
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    [self.detalLabel addSubview:self.timeLabel];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.myImageView.frame = CGRectMake(10, 10, 100, 80);
    self.titlelabel.frame = CGRectMake(CGRectGetMaxX(self.myImageView.frame) + 10, CGRectGetMinY(self.myImageView.frame), self.bounds.size.width - self.myImageView.frame.size.width - 30, 30);
    self.detalLabel.frame = CGRectMake(CGRectGetMinX(self.titlelabel.frame), CGRectGetMaxY(self.titlelabel.frame), CGRectGetWidth(self.titlelabel.frame), 50);
    
    self.timeLabel.frame = CGRectMake(self.bounds.size.width - 240, 30, 100, 20);
    
}

+ (CGFloat)cellWithHeight
{
    return 100;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
