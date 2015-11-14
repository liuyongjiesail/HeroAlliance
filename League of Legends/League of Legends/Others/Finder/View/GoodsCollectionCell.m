//
//  GoodsCollectionCell.m
//  League of Legends
//
//  Created by 刘永杰 on 15/11/14.
//  Copyright © 2015年 刘永杰. All rights reserved.
//

#import "GoodsCollectionCell.h"

@implementation GoodsCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self p_setupViews];
    }
    return self;
}

- (void)p_setupViews
{
    self.myImageView = [[UIImageView alloc] init];
//    self.myImageView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.myImageView];
    
    self.goodsName = [[UILabel alloc] init];
//    self.goodsName.backgroundColor = [UIColor blueColor];
    self.goodsName.textAlignment = NSTextAlignmentCenter;
    self.goodsName.numberOfLines = 0;
    [self.contentView addSubview:self.goodsName];
}

-(void)layoutSubviews
{
    self.myImageView.frame = CGRectMake(0, 0, 73.5, 73.5);
    self.goodsName.frame = CGRectMake(0, 73.5, 73.5, 60);
}

@end
