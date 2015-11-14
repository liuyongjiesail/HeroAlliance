//
//  FindListCell.m
//  League of Legends
//
//  Created by 刘永杰 on 15/11/14.
//  Copyright © 2015年 刘永杰. All rights reserved.
//

#import "FindListCell.h"

@implementation FindListCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self p_setupViews];
    }
    return  self;
}

- (void)p_setupViews
{
    self.myImageView = [[UIImageView alloc] init];
//    self.myImageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.myImageView];
    
    self.titleLable = [[UILabel alloc] init];
//    self.titleLable.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:self.titleLable];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.myImageView.frame = CGRectMake(10, 10, 25, 25);
    self.titleLable.frame = CGRectMake(CGRectGetMaxX(self.myImageView.frame) + 15, CGRectGetMinY(self.myImageView.frame) - 5, 200, CGRectGetHeight(self.myImageView.frame) + 10);
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
