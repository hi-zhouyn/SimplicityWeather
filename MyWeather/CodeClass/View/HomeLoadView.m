//
//  HomeLoadView.m
//  MyWeather
//
//  Created by admin on 16/7/19.
//  Copyright © 2016年 周亚楠. All rights reserved.
//

#import "HomeLoadView.h"

@implementation HomeLoadView

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self autoLayoutAllSubViewsWithoutFont];
    
//    self.bgScrollView.pagingEnabled = YES;
//    self.bgScrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, kSCREEN_WIDTH + kSCREEN_HEIGHT);
}
-(void)updateUI:(NowModel *)nowModel CityName:(NSString *)cityName Time:(NSString *)time Aqi:(AqiModel *)aqiModel Daily:(DailyForecastModel *)dailyModel
{
    self.cityLabel.text = cityName;
    self.nowWeatherLabel.text = nowModel.txt;
    self.nowWeatherAirLabel.text = [NSString stringWithFormat:@"%@ %@",aqiModel.aqi,aqiModel.qlty];
    self.nowWeatherTMPLabel.text = nowModel.tmp;
    self.updateTimeLabel.text = time;
    self.nowWeatherWindLabel.text = [NSString stringWithFormat:@"%@/%@℃  %@ %@",dailyModel.max,dailyModel.min,nowModel.dir,nowModel.sc];
    
}
@end
