//
//  NowWeatherHeadView.m
//  SimplicityWeather
//
//  Created by 周亚楠 on 2018/9/29.
//  Copyright © 2018年 SimplicityWeather. All rights reserved.
//

#import "NowWeatherHeadView.h"
@interface NowWeatherHeadView ()

@property (weak, nonatomic) IBOutlet UILabel *citeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempScopeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowWeatherLabel;

@end

@implementation NowWeatherHeadView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
