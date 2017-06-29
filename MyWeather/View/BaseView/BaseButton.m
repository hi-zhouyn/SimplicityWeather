//
//  BaseButton.m
//  MyWeather
//
//  Created by admin on 16/9/12.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import "BaseButton.h"

@implementation BaseButton

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect imageRect = self.imageView.frame;
    imageRect.origin.x = (self.frame.size.width - imageRect.size.width);
    self.imageView.frame = imageRect;
    CGRect titleRect = self.titleLabel.frame;
    titleRect.origin.x = (self.frame.size.width - imageRect.size.width - titleRect.size.width);
    self.titleLabel.frame = titleRect;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
