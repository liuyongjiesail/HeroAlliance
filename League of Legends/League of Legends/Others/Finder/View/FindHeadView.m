//
//  FindHeadView.m
//  League of Legends
//
//  Created by 刘永杰 on 15/11/13.
//  Copyright © 2015年 刘永杰. All rights reserved.
//

#import "FindHeadView.h"

#define kWidth self.bounds.size.width / 3
#define kHeight self.bounds.size.height


@implementation FindHeadView

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
        
    self.myButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.myButton.frame = CGRectMake(0 * kWidth, 0, kWidth, kHeight);
//    self.myButton.backgroundColor = [UIColor redColor];
    [self addSubview:self.myButton];
    
    self.myImageView = [[UIImageView alloc] init];
    self.myImageView.frame = CGRectMake(kWidth / 3, kWidth / 10, kWidth / 3, kHeight / 2.5);
//    self.myImageView.backgroundColor = [UIColor blueColor];
    [self.myButton addSubview:self.myImageView];
    
    self.myTitleLabel = [[UILabel alloc] init];
//    self.myTitleLabel.backgroundColor = [UIColor blueColor];
    self.myTitleLabel.frame = CGRectMake(0, kWidth / 2.5 + 5, kWidth, kHeight / 3);
    self.myTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.myButton addSubview:self.myTitleLabel];
  
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
