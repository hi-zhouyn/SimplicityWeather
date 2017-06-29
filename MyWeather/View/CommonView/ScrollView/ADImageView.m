//
//  ADImageView.m
//  WaterDeliVer
//
//  Created by 21Lovetong on 15/7/19.
//  Copyright (c) 2015年 CodeSpace. All rights reserved.
//

#import "ADImageView.h"

@implementation ADImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUserInteractionEnabled:YES];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
