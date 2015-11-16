//
//  MyView.m
//  League of Legends
//
//  Created by 刘永杰 on 15/11/16.
//  Copyright © 2015年 刘永杰. All rights reserved.
//

#import "MyView.h"

@implementation MyView

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
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    self.nameLabel.backgroundColor = [UIColor greenColor];
    self.nameLabel.text = @"点击的网吧名称";
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    
    [self addSubview:self.nameLabel];
    
    self.placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 0, 70, 30)];
    self.placeLabel.text = @"距离您：";
    self.placeLabel.textAlignment = NSTextAlignmentCenter;
    self.placeLabel.textColor = [UIColor blackColor];
    [self addSubview:self.placeLabel];
    
    self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 0, 70, 30)];
    self.valueLabel.backgroundColor = [UIColor greenColor];
    self.valueLabel.textColor = [UIColor blackColor];
    self.valueLabel.text = @"1100m";
    self.valueLabel.textAlignment = NSTextAlignmentCenter;
    self.valueLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.valueLabel];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
